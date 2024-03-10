//
//  Keyboard.swift
//  MetalPlayground
//
//  Created by Todd Martin on 3/9/24.
//

import Foundation

class Keyboard {
    private static var KEY_COUNT: Int = 256
    private static var keys = [Bool].init(repeating: false, count: KEY_COUNT)
    
    public static func SetKeyPressed(_ keyCode: UInt16, isOn: Bool) {
        keys[Int(keyCode)] = isOn
    }
    
    public static func IsKeyPressed(_ keyCode: KeyCodes) -> Bool {
        return keys[Int(keyCode.rawValue)]
    }
}
