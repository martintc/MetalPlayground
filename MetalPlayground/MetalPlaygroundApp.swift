//
//  MetalPlaygroundApp.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/27/24.
//

import SwiftUI

@main
struct MetalPlaygroundApp: App {
    @StateObject private var triangle: Triangle = Triangle.shared
    var body: some Scene {
        WindowGroup() {
            RenderedView()
                .environmentObject(triangle)
        }
    }
}
