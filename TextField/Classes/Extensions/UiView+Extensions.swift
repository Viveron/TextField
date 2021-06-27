//
//  UiView+Extensions.swift
//  TextField
//
//  Created by Viktor Shabanov on 23/06/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import UIKit

internal extension UIView {
    
    func forceLayoutSubviews() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
