//
//  MatrixComponent.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import SwiftUI
import simd

struct MatrixComponent: View {
    var matrix: simd_float4x4
    
    var body: some View {
        Grid {
            GridRow {
                Text("\(matrix[0][0])")
                Text("\(matrix[0][1])")
                Text("\(matrix[0][2])")
                Text("\(matrix[0][3])")
            }
            
            GridRow {
                Text("\(matrix[1][0])")
                Text("\(matrix[1][1])")
                Text("\(matrix[1][2])")
                Text("\(matrix[1][3])")
            }
            
            GridRow {
                Text("\(matrix[2][0])")
                Text("\(matrix[2][1])")
                Text("\(matrix[2][2])")
                Text("\(matrix[2][3])")
            }
            
            GridRow {
                Text("\(matrix[3][0])")
                Text("\(matrix[3][1])")
                Text("\(matrix[3][2])")
                Text("\(matrix[3][3])")
            }
        }
    }
}

#Preview {
    MatrixComponent(matrix: matrix_identity_float4x4)
}
