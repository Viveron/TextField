//
//  UiView+Extensions.swift
//  TextField
//
//  Created by Victor Shabanov on 23/06/2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

internal extension UIView {
    
    func forceLayoutSubviews() {
        setNeedsLayout()
        layoutIfNeeded()
    }
}
