//
//  TextField+ExtendedViewMode.swift
//  TextField
//
//  Created by Viktor Shabanov on 23/06/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import UIKit

extension TextField {
    
    /// Simular UITextField.ViewMode enum, but with truth table for custom values:
    ///
    /// Parameter | AND operation
    /// –––––––––––––––––––––––––––––––––
    /// isEditing | -     +     -     +
    /// isEmpty   | -     -     +     +
    /// –––––––––––––––––––––––––––––––––
    ///    .custom($0,   $1,   $2,   $3)
    ///
    /// Need set `Bool` values into case `.custom` as expected result of AND operation.
    /// Matched value used in `isNeedToDisplay(_ isEditing:, _ isEmpty:)` as return value.
    public enum ExtendedViewMode: RawRepresentable, Equatable {
        
        case never
        case whileEditing
        case whileEditingAndNoEmpty
        case unlessEditing
        case always
        case custom(Bool, Bool, Bool, Bool)
        
        // MARK: - RawRepresentable
        
        public var rawValue: UInt8 {
            switch self {
            case .never:
                return 0b00000000
                
            case .whileEditing:
                return 0b00000101

            case .whileEditingAndNoEmpty:
                return 0b00001101
                
            case .unlessEditing:
                return 0b00001110
                
            case .always:
                return 0b00001111
                
            case let .custom(b0, b1, b2, b3):
                return ExtendedViewMode.pack((b0, b1, b2, b3))
            }
        }
        
        public init?(rawValue: UInt8) {
            switch rawValue {
            case ExtendedViewMode.never.rawValue:
                self = .never
                
            case ExtendedViewMode.whileEditing.rawValue:
                self = .whileEditing
                
            case ExtendedViewMode.unlessEditing.rawValue:
                self = .unlessEditing
                
            case ExtendedViewMode.always.rawValue:
                self = .always
                
            default:
                let unpacked = ExtendedViewMode.unpack(rawValue)
                self = .custom(unpacked.0, unpacked.1, unpacked.2, unpacked.3)
            }
        }
        
        // MARK: - Internal methods
        
        internal func isNeedToDisplay(_ isEditing: Bool, _ isEmpty: Bool) -> Bool {
            let offset: Int
            switch (isEditing, isEmpty) {
            case (false, false):
                offset = 3
                
            case (true, false):
                offset = 2
                
            case (false, true):
                offset = 1
                
            case (true, true):
                offset = 0
            }
            
            let result: UInt8 = ((UInt8.one << offset) & rawValue)
            
            return result.boolean
        }
    }
}

// MARK: - Helpers
extension TextField.ExtendedViewMode {
    
    private static func pack(_ truthTable: (Bool, Bool, Bool, Bool)) -> UInt8 {
        let bits = [
            truthTable.0.binary,
            truthTable.1.binary,
            truthTable.2.binary,
            truthTable.3.binary
        ]
        
        return bits.reduce(UInt8.zero) { ($0 << 1) | $1 }
    }
    
    private static func unpack(_ value: UInt8) -> (Bool, Bool, Bool, Bool) {
        var bits: [UInt8] = []
        
        (0...3).forEach { index in
            bits[index] = (value << index) & UInt8.one
        }
        
        return (bits[0].boolean, bits[1].boolean, bits[2].boolean, bits[3].boolean)
    }
}
