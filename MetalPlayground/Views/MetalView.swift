//
//  MetalView.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import MetalKit
import SwiftUI

struct MetalView: NSViewRepresentable {
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    func makeNSView(context: NSViewRepresentableContext<MetalView>) -> MTKView {
        let mtkView = MTKView()
        mtkView.delegate = context.coordinator
        mtkView.preferredFramesPerSecond = 60
        mtkView.enableSetNeedsDisplay = true
        if let metalDevice = MTLCreateSystemDefaultDevice() {
            mtkView.device = metalDevice
        }
        mtkView.framebufferOnly = false
        mtkView.clearColor = MTLClearColor(red: 0, green: 0, blue: 0, alpha: 0)
        mtkView.drawableSize = mtkView.frame.size
        mtkView.enableSetNeedsDisplay = true
        mtkView.isPaused = false
        return mtkView
    }
    
    func updateNSView(_ nsView: MTKView, context: NSViewRepresentableContext<MetalView>) {
    }
    
    class Coordinator : NSObject, MTKViewDelegate {
        var parent: MetalView
        var metalDevice: MTLDevice!
        var metalCommandQueue: MTLCommandQueue!
        var vertexDescriptor: MTLVertexDescriptor
        var renderPipelineState: MTLRenderPipelineState
        
        @EnvironmentObject var triangle: Triangle
        
        init(_ parent: MetalView) {
            self.parent = parent
            if let metalDevice = MTLCreateSystemDefaultDevice() {
                self.metalDevice = metalDevice
            }
            
            self.vertexDescriptor = MTLVertexDescriptor()
            
            vertexDescriptor.layouts[30].stride = MemoryLayout<Vertex>.stride
            vertexDescriptor.layouts[30].stepRate = 1
            vertexDescriptor.layouts[30].stepFunction = .perVertex
            
            vertexDescriptor.attributes[0].format = .float3
            vertexDescriptor.attributes[0].offset = MemoryLayout.offset(of: \Vertex.position)!
            vertexDescriptor.attributes[0].bufferIndex = 30
            
//            vertexDescriptor.attributes[1].format = .float3
//            vertexDescriptor.attributes[1].offset = 0
//            vertexDescriptor.attributes[0].bufferIndex = 30
            
            guard let library = self.metalDevice.makeDefaultLibrary() else {
                fatalError("Error: Could not make default library")
            }
            
            let renderPipelineDescriptor = MTLRenderPipelineDescriptor()
            renderPipelineDescriptor.vertexFunction = library.makeFunction(name: "vertex_shader")
            renderPipelineDescriptor.fragmentFunction = library.makeFunction(name: "fragment_shader")
            renderPipelineDescriptor.colorAttachments[0].pixelFormat = .bgra8Unorm
            renderPipelineDescriptor.vertexDescriptor = self.vertexDescriptor
            
            do {
                self.renderPipelineState = try metalDevice.makeRenderPipelineState(descriptor: renderPipelineDescriptor)
            } catch {
                fatalError("Error: \(error)")
            }
            
            self.metalCommandQueue = metalDevice.makeCommandQueue()!
            super.init()
        }
        
        func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
            // do nothing
        }
        
        func update() {
            if (Keyboard.IsKeyPressed(.rightArrow)) {
                DebugCamera.shared.position.x -= 0.1
            }
            
            if (Keyboard.IsKeyPressed(.leftArrow)) {
                DebugCamera.shared.position.x += 0.1
            }
            
            if (Keyboard.IsKeyPressed(.upArrow)) {
                DebugCamera.shared.position.y -= 0.1
            }
            
            if (Keyboard.IsKeyPressed(.downArrow)) {
                DebugCamera.shared.position.y += 0.1
            }
            
            if (Mouse.IsMouseButtonPressed(button: .left)) {
                DebugCamera.shared.position.z -= 0.1
            }
            
            if (Mouse.IsMouseButtonPressed(button: .right)) {
                DebugCamera.shared.position.z += 0.1
            }
            
            print(Mouse.GetDX())
        }
        
        func draw(in view: MTKView) {
            update()
            guard let drawable = view.currentDrawable else {
                return
            }
            let commandBuffer = metalCommandQueue.makeCommandBuffer()
            let rpd = view.currentRenderPassDescriptor
            rpd?.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 1)
            let re = commandBuffer?.makeRenderCommandEncoder(descriptor: rpd!)
            
            var vertexUniforms = VertexUniforms(modelMatrix: Triangle.shared.modelMatrix,
                                                viewMatrix: DebugCamera.shared.viewMatrix,
                                                projectionMatrix: DebugCamera.shared.projectionMatrix)
            
            re?.setRenderPipelineState(self.renderPipelineState)
            
            re?.setVertexBytes(&vertexUniforms, length: MemoryLayout.stride(ofValue: vertexUniforms), index: 0)
            
            re?.setVertexBuffer(Triangle.shared.vertexBuffer, offset: 0, index: 30)
            
//            re?.drawPrimitives(type: .triangle, vertexStart: 0, vertexCount: 3)
            re?.drawIndexedPrimitives(type: .triangle,
                                      indexCount: 3,
                                      indexType: .uint16,
                                      indexBuffer: Triangle.shared.indexBuffer,
                                      indexBufferOffset: 0)
            
            re?.endEncoding()
            commandBuffer?.present(drawable)
            commandBuffer?.commit()
        }
    }
}
