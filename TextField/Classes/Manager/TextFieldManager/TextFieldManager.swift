//
//  TextFieldManager.swift
//  TextField
//
//  Created by Victor Shabanov on 16.10.2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

open class TextFieldManager<Element>: Manager<Element> where Element: UITextField {
    
    open var resetStateOnEditing: Bool = false {
       didSet {
           setNeedsUpdateIfChanged(resetStateOnEditing, from: oldValue)
       }
    }
    
    open var resetStateOnEmpty: Bool = true {
        didSet {
            setNeedsUpdateIfChanged(resetStateOnEmpty, from: oldValue)
        }
    }
    
    open override func reguster(for element: Element) {
        super.reguster(for: element)
        
        element.addTarget(self,
                          action: #selector(allEditingEventsAction(_:)),
                          for: .allEditingEvents)
    }

    // MARK: - Private methods
    
    private func setNeedsUpdateIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            setNeedsUpdateElement()
        }
    }
    
    // MARK: - UI Actions
    
    @objc private func allEditingEventsAction(_ sender: UITextField) {
        let isNeedsResetStateOnEmpty = resetStateOnEmpty && sender.isEmpty
        let isNeedsResetStateOnEditing = resetStateOnEditing && sender.isEditing
        
        if isNeedsResetStateOnEmpty || isNeedsResetStateOnEditing {
            resetState()
        }
        
        setNeedsUpdateElement()
        updateElementIfNeeded()
    }
}
