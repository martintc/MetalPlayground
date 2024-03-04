//
//  ModelControlView.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import SwiftUI
import simd

struct ModelControlView: View {
    @State private var isModelOn: Bool = false
    @EnvironmentObject var triangle: Triangle
//    @State private var modelScale: simd_float3 = Triangle.shared.scale
//    @State private var modelRotate: simd_float3 = Triangle.shared.rotate
//    @State private var modelTranslate: simd_float3 = Triangle.shared.translate
    
    var body: some View {
        HStack {
            // model space
            VStack {
                Toggle(isOn: $isModelOn, label: {
                    Text("Show Triangle")
                })
                VectorComponent(operation: "Scale",
                                xAxis: $triangle.scale.x,
                                yAxis: $triangle.scale.y,
                                zAxis: $triangle.scale.z)
            
                VectorComponent(operation: "Rotate",
                                xAxis: $triangle.rotate.x,
                                yAxis: $triangle.rotate.y,
                                zAxis: $triangle.rotate.z)
                
                VectorComponent(operation: "Translate",
                                xAxis: $triangle.translate.x,
                                yAxis: $triangle.translate.y,
                                zAxis: $triangle.translate.z)
            }
            
            MatrixComponent(matrix: simd_float4x4(scaleBy: triangle.scale,
                                                  rotateBy: triangle.rotate,
                                                  translateBy: triangle.translate))
            
            VStack {
                Text("Camera")
                
                
            }
            
        }
    }
}

#Preview {
    ModelControlView()
}
