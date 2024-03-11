//
//  MTKViewExtensions.swift
//  MetalPlayground
//
//  Created by Todd Martin on 3/9/24.
//

import Foundation
import MetalKit

extension MTKView {
    //--- Keyboard ---
    override open var acceptsFirstResponder: Bool { return true }
    
    open override func keyDown(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: true)
    }
    
    open override func keyUp(with event: NSEvent) {
        Keyboard.SetKeyPressed(event.keyCode, isOn: false)
    }
    
    //--- Mouse button input ---
    
    // mouseSomeAction refers to a left button click
    
    open override func mouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    open override func mouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    open override func rightMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    open override func rightMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    open override func otherMouseDown(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: true)
    }
    
    open override func otherMouseUp(with event: NSEvent) {
        Mouse.SetMouseButtonPressed(button: event.buttonNumber, isOn: false)
    }
    
    //--- Mouse movement input ---
    open override func mouseMoved(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    open override func scrollWheel(with event: NSEvent) {
        Mouse.ScrollMouse(deltaY: Float(event.deltaY))
    }
    
    open override func mouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    open override func rightMouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    open override func otherMouseDragged(with event: NSEvent) {
        setMousePositionChanged(event: event)
    }
    
    open override func updateTrackingAreas() {
        // do nothing
    }
    
    private func setMousePositionChanged(event: NSEvent){
             let overallLocation = simd_float2(Float(event.locationInWindow.x),
                                               Float(event.locationInWindow.y))
        
             let deltaChange = simd_float2(Float(event.deltaX),
                                           Float(event.deltaY))
        
             Mouse.SetMousePositionChange(overallPosition: overallLocation,
                                          deltaPosition: deltaChange)
        }
}
