//
//  RenderedView.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/28/24.
//

import SwiftUI

struct RenderedView: View {
    @Environment(\.openWindow) private var openWindow
    @Environment(\.dismissWindow) private var dismissWindow

    
    var body: some View {
        VStack {
            ModelControlView()
            Spacer()
            MetalView()
        }
    }
}

#Preview {
    RenderedView()
        .environmentObject(Triangle.shared)
}
