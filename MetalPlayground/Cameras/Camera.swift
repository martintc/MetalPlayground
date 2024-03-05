//
//  Camera.swift
//  MetalPlayground
//
//  Created by Todd Martin on 3/1/24.
//

import simd

enum CameraTypes {
    case Debug
}

protocol Camera {
    var cameraType: CameraTypes { get }
    var position: simd_float3 { get set }
    var projectionMatrix: simd_float4x4 { get }
    var rotation: simd_float3 { get set }
    
    func update(deltaTime: Float)
}

extension Camera {
    var viewMatrix: simd_float4x4 {
        var viewMatrix = matrix_identity_float4x4
        
        if self.rotation.x != 0 {
            viewMatrix.rotate(angle: self.rotation.x, axis: X_AXIS)
        }
        
        if self.rotation.y != 0 {
            viewMatrix.rotate(angle: self.rotation.y, axis: Y_AXIS)
        }
        
        if self.rotation.z != 0 {
            viewMatrix.rotate(angle: self.rotation.z, axis: Z_AXIS)
        }
        
        viewMatrix.translate(direction: -position)
        
        return viewMatrix
    }
}
