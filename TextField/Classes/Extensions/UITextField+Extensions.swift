//
//  UITextField+Extensions.swift
//  TextField
//
//  Created by Victor Shabanov on 21/07/2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

internal extension UITextField {
    
    enum TextAlignment {
        case left
        case right
        case center
    }
    
    var actualTextAlignment: TextAlignment {
        switch textAlignment {
        case .left:
            return .left
            
        case .right:
            return .right
            
        case .center:
            return .center
            
        default:
            switch UIApplication.shared.userInterfaceLayoutDirection {
            case .leftToRight:
                return .left
                
            case .rightToLeft:
                return .right
                
            // Even if UIUserInterfaceLayoutDirection is supplemented, only possible
            // and expected property will be related with centered layout
            @unknown default:
                return .center
            }
        }
    }
    
    var isEmpty: Bool {
        return text?.isEmpty ?? true
    }
}
