//
//  MathUtilities.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import Foundation
import simd
import MetalKit

extension simd_float4x4 {
    init(scaleBy scale: simd_float3, rotateBy rotate: simd_float3, translateBy translate: simd_float3) {
        let matrix = matrix_identity_float4x4
//        self = matrix * getTranslationMatrix(translate) * getScaleMatrix(scale) * getRotationMatrix(rotate)
        self = matrix * getScaleMatrix(scale) * getRotationMatrix(rotate) * getTranslationMatrix(translate)
    }
    
    static func perspective(degreesFov: Float, aspectRatio: Float, near: Float, far: Float) -> simd_float4x4 {
        let fov = Float.toRadians(from: degreesFov)
        
        let t: Float = tan(fov / 2)
        
        let x: Float = 1 / (aspectRatio * t)
        let y: Float = 1 / t
        let z: Float = -((far + near) / (far - near))
        let w: Float = -((2 * far * near) / (far - near))
        
        var result = matrix_identity_float4x4
        result.columns = (simd_float4(x, 0, 0, 0), 
                          simd_float4(0, y, 0, 0),
                          simd_float4(0, 0, z, -1),
                          simd_float4(0, 0, w, 0))
        return result
    }
}

func getScaleMatrix(_ vector: simd_float3) -> simd_float4x4 {
    return simd_float4x4(simd_float4(vector.x, 0, 0, 0),
                         simd_float4(0, vector.y, 0, 0),
                         simd_float4(0, 0, vector.z, 0),
                         simd_float4(0, 0, 0, 1))
}

func getTranslationMatrix(_ vector: simd_float3) -> simd_float4x4 {
    return simd_float4x4(simd_float4(1, 0, 0, 0),
                         simd_float4(0, 1, 0, 0),
                         simd_float4(0, 0, 1, 0),
                         simd_float4(vector.x, vector.y, vector.z, 1))
}

func getRotationMatrix(_ vector: simd_float3) -> simd_float4x4 {
    if vector.x == 0 && vector.y == 0 && vector.z == 0 {
        return matrix_identity_float4x4
    }
    
    let angleRadians = Float.pi / 3
    let a = normalize(vector)
    let x = a.x, y = a.y, z = a.z
    let c = cosf(angleRadians)
    let s = sinf(angleRadians)
    let t = 1 - c
    return simd_float4x4(simd_float4( t * x * x + c,     t * x * y + z * s, t * x * z - y * s, 0),
              simd_float4( t * x * y - z * s, t * y * y + c,     t * y * z + x * s, 0),
              simd_float4( t * x * z + y * s, t * y * z - x * s,     t * z * z + c, 0),
              simd_float4(                 0,                 0,                 0, 1))
}

extension simd_float3 {
    func normalize() -> simd_float3 {
        let x = self.x * self.x
        let y = self.y * self.y
        let z = self.z * self.z
        let magnitude = sqrtf(x + y + z)
        return self / magnitude
    }
    
    static func normalize(vector a: simd_float3) -> simd_float3 {
        let x = a.x * a.x
        let y = a.y * a.y
        let z = a.z * a.z
        let magnitude = sqrtf(x + y + z)
        return a / magnitude
    }
    
    static func crossProduct(a: simd_float3, b: simd_float3) -> simd_float3 {
        var c = simd_float3()
        c.x = (a.y * b.z) - (a.z * b.y)
        c.y = (a.z * b.x) - (b.z * a.x)
        c.z = (a.x * b.y) - (b.z * a.y)
        return c
    }
    
    static func dotProduct(a: simd_float3, b: simd_float3) -> Float {
        (a.x * b.x) + (a.y * b.y) + (a.z * b.z)
    }
}

extension Float {
    static func toRadians(from angle: Float) -> Float {
        return angle * 180.0 / .pi;
    }
    
    static func toDegrees(from angle: Float) -> Float {
        return angle * (180.0 / .pi)
    }
}
