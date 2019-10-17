//
//  LayoutGuide+Kind.swift
//  TextField
//
//  Created by Victor Shabanov on 17.10.2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

extension LayoutGuide {
    
    /// CSS Box Model
    public enum Kind: Equatable {
        
        /// Outside of view content
        case margin
        
        /// Inside of view content
        case padding
    }
}
