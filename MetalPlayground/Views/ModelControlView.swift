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
    @EnvironmentObject var debugCamera: DebugCamera
    
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
                                zAxis: $triangle.scale.z,
                                xLower: 0,
                                xUpper: 10,
                                yLower: 0,
                                yUpper: 10,
                                zLower: 0,
                                zUpper: 10)
            
                VectorComponent(operation: "Rotate",
                                xAxis: $triangle.rotate.x,
                                yAxis: $triangle.rotate.y,
                                zAxis: $triangle.rotate.z,
                                xLower: 0,
                                xUpper: 10,
                                yLower: 0,
                                yUpper: 10,
                                zLower: 0,
                                zUpper: 10)
                
                VectorComponent(operation: "Translate",
                                xAxis: $triangle.translate.x,
                                yAxis: $triangle.translate.y,
                                zAxis: $triangle.translate.z,
                                xLower: -10,
                                xUpper: 10,
                                yLower: -10,
                                yUpper: 10,
                                zLower: -10,
                                zUpper: 10)
            }
            
            MatrixComponent(matrix: Triangle.shared.modelMatrix)
            
            VStack {
                Text("Camera")
                
                VectorComponent(operation: "Position",
                                xAxis: $debugCamera.position.x,
                                yAxis: $debugCamera.position.y,
                                zAxis: $debugCamera.position.z,
                                xLower: -10,
                                xUpper: 10,
                                yLower: -10,
                                yUpper: 10,
                                zLower: -10,
                                zUpper: 10)
                
                VectorComponent(operation: "Rotation",
                                xAxis: $debugCamera.rotation.x,
                                yAxis: $debugCamera.rotation.y,
                                zAxis: $debugCamera.rotation.z,
                                xLower: -1,
                                xUpper: 1,
                                yLower: -1,
                                yUpper: 1,
                                zLower: -1,
                                zUpper: 1)
            }
            
            MatrixComponent(matrix: debugCamera.viewMatrix)
            
        }
    }
}

#Preview {
    ModelControlView()
}
