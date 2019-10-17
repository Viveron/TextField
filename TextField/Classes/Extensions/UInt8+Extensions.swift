//
//  UInt8+Extensions.swift
//  TextField
//
//  Created by Victor Shabanov on 23/06/2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import Foundation

internal extension UInt8 {
    
    static let one: UInt8 = 0b00000001
    
    var boolean: Bool {
        return self != .zero
    }
}
