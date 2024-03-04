//
//  VertexUniforms.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/29/24.
//

import Foundation
import simd

struct VertexUniforms {
    var modelMatrix: simd_float4x4
    var viewMatrix: simd_float4x4
    var projectionMatrix: simd_float4x4
}
