//
//  Camera.swift
//  MetalPlayground
//
//  Created by Todd Martin on 3/1/24.
//

import Foundation
import simd

class Camera: ObservableObject {
    @Published var right: simd_float3
    @Published var up: simd_float3
    @Published var forward: simd_float3
    @Published var translation: simd_float3
    @Published var position = simd_float3(0, 0, 0)
    @Published var fov: Float = Float.toRadians(from: 60)
    @Published var aspectRatio: Float = 1.0
    @Published var nearPlane: Float = 0.1
    @Published var farPlane: Float = 20
    
    static let shared = Camera()
    
    init() {
        right = simd_float3()
        up = simd_float3()
        forward = simd_float3()
        translation = simd_float3()
        self.calculateForward(from: simd_float3(0, 0, 1), to: simd_float3(0, 0, 0))
        self.calculateRight()
        self.calculateUp()
        self.calculateTransaltion()
    }
    
    var viewMatrix: simd_float4x4 {
        let view = matrix_float4x4(simd_float4(right, translation.x),
                               simd_float4(up, translation.y),
                               simd_float4(forward, translation.z),
                               simd_float4(0, 0, 0, 1))
        
//        let view = matrix_float4x4(simd_float4(right, 0),
//                               simd_float4(up, 0),
//                               simd_float4(forward, 0),
//                               simd_float4(translation, 1))
        
//        let view = matrix_float4x4(simd_float4(right.x, up.x, forward.x, translation.x),
//                               simd_float4(right.y, up.y, forward.y, translation.y),
//                               simd_float4(right.z, up.z, forward.z, translation.z),
//                               simd_float4(0, 0, 0, 1))
        
//        let view = matrix_float4x4(simd_float4(right.x, up.x, forward.x, 0),
//                               simd_float4(right.y, up.y, forward.y, 0),
//                               simd_float4(right.z, up.z, forward.z, 0),
//                               simd_float4(translation.x, translation.y, translation.z, 1))
        
        return matrix_identity_float4x4 * view
    }
    
    var projectionMatrix: simd_float4x4 {
        let tanHalfFov = tan(fov / 2.0);

            var matrix = simd_float4x4(0.0);
            matrix[0][0] = 1.0 / (aspectRatio * tanHalfFov);
            matrix[1][1] = 1.0 / (tanHalfFov);
            matrix[2][2] = farPlane / (farPlane - nearPlane);
            matrix[2][3] = 1.0;
            matrix[3][2] = -(farPlane * nearPlane) / (farPlane - nearPlane);

            return matrix;
    }
    
    func calculateForward(from: simd_float3,  to: simd_float3) {
        let vector = from - to
        self.forward = vector.normalize()
    }
    
    func calculateRight() {
        let vector = simd_float3.crossProduct(a: simd_float3(0, 1, 0), b: self.forward)
        self.right = simd_float3.normalize(vector: vector)
    }
    
    func calculateUp() {
        let vector = simd_float3.crossProduct(a: self.forward, b: self.right)
        self.up = simd_float3.normalize(vector: vector)
    }
    
    func calculateTransaltion() {
        self.translation.x = simd_float3.dotProduct(a: self.position, b: self.right)
        self.translation.y = simd_float3.dotProduct(a: self.position, b: self.up)
        self.translation.z = simd_float3.dotProduct(a: self.position, b: self.forward)
    }
}
