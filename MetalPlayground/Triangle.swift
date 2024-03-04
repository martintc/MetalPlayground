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
    
    static let shared = Triangle()
    
    var modelMatrix: simd_float4x4 {
        get {
            return matrix_identity_float4x4 * simd_float4x4(scaleBy: scale, rotateBy: rotate, translateBy: translate)
        }
    }
    
    init() {
        let vertices: [Float] = [
            -0.5, -0.5, 0.0, //vertex 0
             0.5, -0.5, 0.0, //vertex 1
             0.0,  0.5, 0.0  //vertex 2
        ]
        
        guard let device = MTLCreateSystemDefaultDevice() else {
            fatalError("Error: could not create default device in initializer for triangle")
        }
        
        vertexBuffer = device.makeBuffer(bytes: vertices, length: vertices.count * MemoryLayout.stride(ofValue: vertices[0]), options: MTLResourceOptions.storageModeShared)!
    }
    
}
