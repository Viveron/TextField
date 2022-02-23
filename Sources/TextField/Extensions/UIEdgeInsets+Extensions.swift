//
//  UIEdgeInsets+Extensions.swift
//  TextField
//
//  Created by Viktor Shabanov on 21/07/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import UIKit

internal extension UIEdgeInsets {

    init(edges: CGFloat) {
        self.init(top: edges, left: edges, bottom: edges, right: edges)
    }

    init(left: CGFloat, right: CGFloat) {
        self.init(top: 0, left: left, bottom: 0, right: right)
    }
}
