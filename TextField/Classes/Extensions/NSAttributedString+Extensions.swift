//
//  NSAttributedString+Extensions.swift
//  TextField
//
//  Created by Victor Shabanov on 21/07/2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

internal extension NSAttributedString {
    
    func copy(withString string: String) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        mutable.mutableString.setString(string)
        return mutable
    }
}
