//
//  Shaders.metal
//  MetalPlayground
//
//  Created by Todd Martin on 2/29/24.
//

#include <metal_stdlib>
using namespace metal;

struct Vertex {
    float3 position [[attribute((0))]];
};

struct Uniforms {
    float4x4 modelMatrix;
    float4x4 viewMatrix;
    float4x4 projectionMatrix;
};

vertex float4 vertex_shader(Vertex in [[stage_in]], constant Uniforms &uniforms [[buffer(0)]]) {
    return uniforms.projectionMatrix * uniforms.viewMatrix * uniforms.modelMatrix * float4(in.position, 1.0);
}

fragment float4 fragment_shader() {
    return float4(0.2, 0.7, 0.9, 1.0);
}
