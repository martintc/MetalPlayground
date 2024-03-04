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
    
    var xLower: Float
    var xUpper: Float
    var yLower: Float
    var yUpper: Float
    var zLower: Float
    var zUpper: Float
    
    var body: some View {
        HStack {
            Text("\(operation)")
            
            VStack {
                Text("\(xAxis)")
                Slider(value: $xAxis, in: xLower...xUpper)
            }
            
            VStack {
                Text("\(yAxis)")
                Slider(value: $yAxis, in: yLower...yUpper)
            }
            
            VStack {
                Text("\(zAxis)")
                Slider(value: $zAxis, in: zLower...zUpper)
            }
        }
        .padding()
    }
}

#Preview {
    VectorComponent(operation: "Scale", 
                    xAxis: .constant(Float(0)),
                    yAxis: .constant(Float(0.0)),
                    zAxis: .constant(Float(1.0)),
                    xLower: Float(0.0),
                    xUpper: Float(0.0),
                    yLower: Float(0.0),
                    yUpper: Float(0.0),
                    zLower: Float(0.0),
                    zUpper: Float(0.0))
}
