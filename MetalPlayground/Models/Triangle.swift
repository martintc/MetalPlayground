//
//  Triangle.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import Foundation
import simd
import Metal

class Triangle: ObservableObject {
    @Published var translate: simd_float3 = simd_float3(0, 0, 0)
    @Published var scale: simd_float3 = simd_float3(1, 1, 1)
    @Published var rotate: simd_float3 = simd_float3(0, 0, 0)
    
    @Published var vertexBuffer: MTLBuffer
    
    var indexBuffer: MTLBuffer
    
    static let shared = Triangle()
    
    var modelMatrix: simd_float4x4 {
        get {
            var model = matrix_identity_float4x4
            
            model.translate(direction: translate)
            
            if rotate.x != 0 {
                model.rotate(angle: rotate.x, axis: X_AXIS)
            }
            
            if rotate.y != 0 {
                model.rotate(angle: rotate.y, axis: Y_AXIS)
            }
            
            if rotate.z != 0 {
                model.rotate(angle: rotate.z, axis: Z_AXIS)
            }
            model.scale(axis: scale)
            
            return model
        }
    }
    
    init() {
        let vertices: [simd_float3] = [
            simd_float3(-1.0, -1.0, 0.0),
            simd_float3( 0.0,  1.0, 0.0),
            simd_float3( 1.0, -1.0, 0.0)
        ]
        
        let indicies: [ushort] = [
            0, 1, 2
        ]
                
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Error: could not create default device in initializer for triangle")
        }
        
        vertexBuffer = device.makeBuffer(bytes: vertices, 
                                         length: vertices.count * MemoryLayout.stride(ofValue: vertices[0]),
                                         options: MTLResourceOptions.storageModeShared)!
        
        indexBuffer = device.makeBuffer(bytes: indicies, 
                                        length: indicies.count * MemoryLayout.stride(ofValue: indicies[0]),
                                        options: MTLResourceOptions.storageModeShared)!
    }
    
}
