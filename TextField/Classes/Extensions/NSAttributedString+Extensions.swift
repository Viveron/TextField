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
    
    func copy(withString string: String, name: NSAttributedString.Key, value: Any) -> NSAttributedString {
        let mutable = NSMutableAttributedString(attributedString: self)
        let range = NSRange(location: 0, length: string.count)
        mutable.mutableString.setString(string)
        mutable.addAttribute(name, value: value, range: range)
        return mutable
    }
}
