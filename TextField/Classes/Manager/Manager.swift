//
//  Manager.swift
//  TextField
//
//  Created by Viktor Shabanov on 16.10.2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import Foundation

open class Manager<Element>: NSObject where Element: AnyObject {
    
    private var isNeedsUpdateElement: Bool = true
    
    private weak var element: Element? {
        didSet {
            if element !== oldValue {
                resetState()
            }
        }
    }
    
    // Immediately apply state changes
    // That mean that `update(_:)` called every time when state was changed
    open var shouldUpdateElementWhenStateChange: Bool = false {
        didSet {
            updateElementOnStateChangeIfNeeded()
        }
    }
    
    open var state: State = .default {
        didSet {
            if state != oldValue {
                setNeedsUpdateElement()
                updateElementOnStateChangeIfNeeded()
            }
        }
    }
    
    public override required init() {
        super.init()
    }
    
    open func resetState() {
        state = .default
    }
    
    open func register(for element: Element) {
        self.element = element
        // override for registre for element events after that updates should occur
    }
    
    open func update(_ element: Element) {
        // override for change element style or display parameters
    }
    
    open func setNeedsUpdateElement() {
        isNeedsUpdateElement = true
    }
    
    open func updateElementIfNeeded() {
        if isNeedsUpdateElement {
            updateElement()
        }
    }
    
    // MARK: - Private methods
    
    private func updateElementOnStateChangeIfNeeded() {
        if shouldUpdateElementWhenStateChange {
            updateElementIfNeeded()
        }
    }
    
    private func updateElement() {
        isNeedsUpdateElement = false
        if let element = element {
            update(element)
        }
    }
}
