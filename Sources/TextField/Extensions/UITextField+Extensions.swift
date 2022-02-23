//
//  UITextField+Extensions.swift
//  TextField
//
//  Created by Viktor Shabanov on 21/07/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
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

    var isDisplayedLeftView: Bool {
        return isDisplayed(leftView, with: leftViewMode)
    }

    var isDisplayedRightView: Bool {
        return isDisplayed(rightView, with: rightViewMode)
    }

    // MARK: - Helpers

    private func isDisplayed(_ view: UIView?, with mode: ViewMode) -> Bool {
        guard view != nil else {
            return false
        }

        switch mode {
        case .never:
            return false

        case .whileEditing:
            return isEditing

        case .unlessEditing:
            // Yeath, apple's '.unlessEditing' mode just is not simple
            return !isEditing || (isEditing && isEmpty)

        case .always:
            return true

        @unknown default:
            return false
        }
    }
}
