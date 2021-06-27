//
//  Bool+Extensions.swift
//  TextField
//
//  Created by Viktor Shabanov on 23/06/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import Foundation

internal extension Bool {
    
    var binary: UInt8 {
        return self ? .one : .zero
    }
}
