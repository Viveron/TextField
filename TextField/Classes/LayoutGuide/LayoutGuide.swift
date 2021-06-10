//
//  LayoutGuide.swift
//  TextField
//
//  Created by Victor Shabanov on 17.10.2019.
//  Copyright © 2019 Victor Shabanov. All rights reserved.
//

import UIKit

public final class LayoutGuide: UILayoutGuide {
    
    private var topLayoutConstraint: NSLayoutConstraint!
    private var leftLayoutConstraint: NSLayoutConstraint!
    private var rightLayoutConstraint: NSLayoutConstraint!
    private var bottomLayoutConstraint: NSLayoutConstraint!
    
    // MARK: - Interface
    
    public var kind: Kind = .margin {
        didSet {
            updateKindIfChanged(oldValue)
        }
    }
    
    public var insets: UIEdgeInsets = .zero {
        didSet {
            updateInsetsIfChanged(oldValue)
        }
    }
    
    public convenience init(identifier: String) {
        self.init()
        self.identifier = identifier
    }
    
    public func addOwningView(_ view: UIView) {
        guard owningView !== view else {
            return
        }
        
        owningView?.removeLayoutGuide(self)
        view.addLayoutGuide(self)
        
        topLayoutConstraint = topAnchor.constraint(equalTo: view.topAnchor)
        leftLayoutConstraint = leftAnchor.constraint(equalTo: view.leftAnchor)
        rightLayoutConstraint = rightAnchor.constraint(equalTo: view.rightAnchor)
        bottomLayoutConstraint = bottomAnchor.constraint(equalTo: view.bottomAnchor)
        
        let constraints = [
            topLayoutConstraint,
            leftLayoutConstraint,
            rightLayoutConstraint,
            bottomLayoutConstraint
        ]
        
        constraints.forEach {
            $0?.priority = .required
            $0?.isActive = true
        }
    }
    
    // MARK: - Private methods
    
    private func updateKindIfChanged(_ oldValue: Kind) {
        guard kind != oldValue, owningView != nil else {
            return
        }
        
        updateLayoutConstraint()
    }
    
    private func updateInsetsIfChanged(_ oldValue: UIEdgeInsets) {
        guard insets != oldValue, owningView != nil else {
            return
        }
        
        updateLayoutConstraint()
    }
    
    private func updateLayoutConstraint() {
        let topConstant = actualConstant(insets.top, kind)
        if topLayoutConstraint.constant != topConstant {
           topLayoutConstraint.constant = topConstant
        }
        
        let leftConstant = actualConstant(insets.left, kind)
        if leftLayoutConstraint.constant != leftConstant {
           leftLayoutConstraint.constant = leftConstant
        }
        
        let rightConstant = -actualConstant(insets.right, kind)
        if rightLayoutConstraint.constant != rightConstant {
           rightLayoutConstraint.constant = rightConstant
        }
        
        let bottomConstant = -actualConstant(insets.bottom, kind)
        if bottomLayoutConstraint.constant != bottomConstant {
           bottomLayoutConstraint.constant = bottomConstant
        }
    }
    
    // MARK: - Helpers
    
    private func actualConstant(_ value: CGFloat, _ kind: Kind) -> CGFloat {
        return kind == .margin && value > 0 ? -value : value
    }
}
