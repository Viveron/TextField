//
//  UIEdgeInsets+Extensions.swift
//  TextField
//
//  Created by Victor Shabanov on 21/07/2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

internal extension UIEdgeInsets {
    
    init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }
}
