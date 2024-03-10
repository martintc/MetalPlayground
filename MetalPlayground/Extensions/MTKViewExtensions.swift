//
//  MTKViewExtensions.swift
//  MetalPlayground
//
//  Created by Todd Martin on 3/9/24.
//

import Foundation
import MetalKit

extension MTKView {
    override open var acceptsFirstResponder: Bool { return true }
    
    open override func keyDown(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: true)
    }
    
    open override func keyUp(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: false)
    }
}
