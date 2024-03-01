//
//  VectorComponent.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import SwiftUI

struct VectorComponent: View {
    var operation: String
    @Binding var xAxis: Float
    @Binding var yAxis: Float
    @Binding var zAxis: Float
    
    var body: some View {
        HStack {
            Text("\(operation)")
            
            VStack {
                Text("\(xAxis)")
                Slider(value: $xAxis, in: 0...10)
            }
            
            VStack {
                Text("\(yAxis)")
                Slider(value: $yAxis, in: 0...10)
            }
            
            VStack {
                Text("\(zAxis)")
                Slider(value: $zAxis, in: 0...10)
            }
        }
        .padding()
    }
}

#Preview {
    VectorComponent(operation: "Scale", xAxis: .constant(Float(0)), yAxis: .constant(Float(0)), zAxis: .constant(Float(0)))
}
