//
//  Renderer.swift
//  MetalPlayground
//
//  Created by Todd Martin on 2/27/24.
//

import Foundation
import Metal
import MetalKit

class Renderer: NSObject, MTKViewDelegate {
    func draw(in view: MTKView) {
        // do nothing
    }
    
    func mtkView(_ view: MTKView, drawableSizeWillChange size: CGSize) {
        // do nnothing
    }
    
    var device: MTLDevice
    var mtkView: MTKView

    init?(_ view: MTKView) {
        self.mtkView = view
        
        guard let device = view.device else {
            fatalError("Error: Could not create a system default device")
        }
        
        self.device = device
    }
}
