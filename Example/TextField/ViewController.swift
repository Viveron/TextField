//
//  ViewController.swift
//  TextField
//
//  Created by viveron on 10/17/2019.
//  Copyright (c) 2019 viveron. All rights reserved.
//

import UIKit
import TextField

class ViewController: UIViewController {

    let textField = TextField()
    let textFieldMediator = SimpleManager()
    
    let leftView = IntrinsicView(CGSize(width: 12, height: 30))
    let rightView = IntrinsicView(CGSize(width: 10, height: 30))
    
    let titleView = UILabel()
    let supplyView = FitView(CGSize(width: 50, height: 1))
    
    let topView = IntrinsicView(CGSize(width: 10, height: 10))
    let bottomView = IntrinsicView(CGSize(width: 10, height: 10))
    
    override func viewDidLoad() {
        super.viewDidLoad()

        textField.contentInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        textField.layer.cornerRadius = 5
        textField.layer.borderWidth = 1
        textField.layer.borderColor = UIColor.black.cgColor

        makeLayout(textField)
        textFieldMediator.register(for: textField)
        
        // 1. Placeholder
        textField.placeholderColor = .red
        textField.placeholderOnEditing = "Placeholder"
        textField.placeholderOnEmpty = "Placeholder on empty text"
        textField.placeholderMode = .dynamic
        
        // 2. Left/Right view
        leftView.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        rightView.backgroundColor = UIColor.green.withAlphaComponent(0.5)

        textField.leftView = leftView
        textField.leftViewMode = .unlessEditing
        textField.leftViewAlignment = .top

        textField.rightView = rightView
        textField.rightViewMode = .whileEditing
        textField.rightViewAlignment = .fill

        // 3. Prefix/Suffix view
        textField.textAlignment = .left

        textField.prefixView = IntrinsicView(CGSize(width: 25, height: 25))
        textField.prefixView?.backgroundColor = .yellow
        textField.prefixViewMode = .always
        textField.prefixViewAlignment = .center
        textField.prefixViewTextSpacing = 5

        textField.suffixView = IntrinsicView(CGSize(width: 15, height: 20))
        textField.suffixView?.backgroundColor = .magenta
        textField.suffixViewMode = .always
        textField.suffixViewPosition = .static
        textField.suffixViewAlignment = .center
        textField.suffixViewTextSpacing = 5
        
        // 4. Title/Supply view
        titleView.text = textField.placeholderOnEmpty
        textField.titleView = titleView
        textField.titleViewMode = .custom(true, true, false, true)
        textField.titleViewSpacing = 10
        textField.titleViewAlignment = .left

        textField.supplyView = supplyView
        textField.supplyView?.backgroundColor = .red
        textField.supplyViewMode = .always
        textField.supplyViewSpacing = 5
        textField.supplyViewAlignment = .fill
        
        // 5. Autolayput
        topView.backgroundColor = .yellow
        bottomView.backgroundColor = .orange

        view.addSubview(topView)
        view.addSubview(bottomView)

        topView.translatesAutoresizingMaskIntoConstraints = false
        topView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        topView.bottomAnchor.constraint(equalTo: textField.extraContentGuide.topAnchor).isActive = true

        bottomView.translatesAutoresizingMaskIntoConstraints = false
        bottomView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        bottomView.topAnchor.constraint(equalTo: textField.extraContentGuide.bottomAnchor).isActive = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        
        view.endEditing(true)
    }
    
    // MARK: - Helpers
    
    private func makeLayout(_ textField: TextField) {
        textField.backgroundColor = UIColor.gray.withAlphaComponent(0.1)
        view.addSubview(textField)
        
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        textField.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        textField.widthAnchor.constraint(equalToConstant: 303).isActive = true
        textField.heightAnchor.constraint(equalToConstant: 44).isActive = true
    }
}

class SimpleManager: TextFieldManager<TextField> {
    
    override func update(_ textFiled: TextField) {
        super.update(textFiled)
        
        textFiled.supplyView?.backgroundColor = textFiled.isEditing ? .darkText : .green
    }
}

class IntrinsicView: UIView {
    
    var intrinsicSize: CGSize = CGSize(width: UIView.noIntrinsicMetric,
                                       height: UIView.noIntrinsicMetric)
    
    override var intrinsicContentSize: CGSize {
        return intrinsicSize
    }
    
    init(_ size: CGSize) {
        super.init(frame: CGRect(origin: .zero, size: size))
        
        intrinsicSize = size
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class FitView: IntrinsicView {
    
    override func sizeThatFits(_ size: CGSize) -> CGSize {
        return intrinsicContentSize
    }
}
