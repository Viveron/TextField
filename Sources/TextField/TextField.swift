//
//  TextField.swift
//  TextField
//
//  Created by Viktor Shabanov on 17/05/2019.
//  Copyright © 2019 Viktor Shabanov. All rights reserved.
//

import UIKit

open class TextField: UITextField {
    
    public static let extraContentGuideIdentifier = "extraContentGuide"
    
    public let extraContentGuide = LayoutGuide(identifier: TextField.extraContentGuideIdentifier)
    
    open var titleView: UIView? {
        willSet {
            updateExtraView(titleView, with: newValue, mode: titleViewMode)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var titleViewMode: ExtendedViewMode = .never {
        willSet {
            updateExtraViewMode(titleViewMode, with: newValue, view: titleView)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var titleViewAlignment: UIControl.ContentHorizontalAlignment = .left {
        didSet {
            layoutIfChanged(titleViewAlignment, from: oldValue)
        }
    }
    
    open var titleViewSpacing: CGFloat = 0 {
        didSet {
            layoutIfChanged(titleViewSpacing, from: oldValue)
        }
    }
    
    open var supplyView: UIView? {
        willSet {
            updateExtraView(supplyView, with: newValue, mode: supplyViewMode)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var supplyViewMode: ExtendedViewMode = .never {
        willSet {
            updateExtraViewMode(supplyViewMode, with: newValue, view: supplyView)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var supplyViewAlignment: UIControl.ContentHorizontalAlignment = .fill {
        didSet {
            layoutIfChanged(supplyViewAlignment, from: oldValue)
        }
    }
    
    open var supplyViewSpacing: CGFloat = 0 {
        didSet {
            layoutIfChanged(supplyViewSpacing, from: oldValue)
        }
    }
    
    open var prefixView: UIView? {
        willSet {
            updateIntraView(prefixView, with: newValue, mode: prefixViewMode)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var prefixViewMode: ExtendedViewMode = .never {
        willSet {
            updateIntraViewMode(prefixViewMode, with: newValue, view: prefixView)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var prefixViewPosition: Behavior = .dynamic {
        didSet {
            layoutIfChanged(prefixViewPosition, from: oldValue)
        }
    }
    
    open var prefixViewAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            layoutIfChanged(prefixViewAlignment, from: oldValue)
        }
    }
    
    open var prefixViewTextSpacing: CGFloat = 0 {
        didSet {
            layoutIfChanged(prefixViewTextSpacing, from: oldValue)
        }
    }
    
    open var suffixView: UIView? {
        willSet {
            updateIntraView(suffixView, with: newValue, mode: suffixViewMode)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var suffixViewMode: ExtendedViewMode = .never {
        willSet {
            updateIntraViewMode(suffixViewMode, with: newValue, view: suffixView)
        }
        didSet {
            forceLayoutSubviews()
        }
    }
    
    open var suffixViewPosition: Behavior = .dynamic {
        didSet {
            layoutIfChanged(suffixViewPosition, from: oldValue)
        }
    }
    
    open var suffixViewAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            layoutIfChanged(suffixViewAlignment, from: oldValue)
        }
    }
    
    open var suffixViewTextSpacing: CGFloat = 0 {
        didSet {
            layoutIfChanged(suffixViewTextSpacing, from: oldValue)
        }
    }
    
    open var leftViewAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            layoutIfChanged(leftViewAlignment, from: oldValue)
        }
    }
    
    open var rightViewAlignment: UIControl.ContentVerticalAlignment = .center {
        didSet {
            layoutIfChanged(rightViewAlignment, from: oldValue)
        }
    }
    
    open var placeholderMode: Behavior = .static {
        didSet {
            updatePlaceholderIfChanged(placeholderMode, from: oldValue)
        }
    }
    
    open var placeholderColor: UIColor? {
        didSet {
            updateAttributedPlaceholderIfChanged(placeholderColor, from: oldValue)
        }
    }
    
    open var placeholderOnEditing: String? {
        willSet {
            if placeholderMode == .static {
                placeholder = newValue
            }
        }
        didSet {
            updatePlaceholderIfChanged(placeholderOnEditing, from: oldValue)
        }
    }
    
    open var placeholderOnEmpty: String? {
        willSet {
            if placeholderMode == .static {
                placeholder = newValue
            }
        }
        didSet {
            updatePlaceholderIfChanged(placeholderOnEmpty, from: oldValue)
        }
    }

    /// Insets for adding some space inside of `UITextField` between
    /// the border and contained text and elements views.
    open var contentInsets: UIEdgeInsets = UIEdgeInsets(edges: 0) {
        didSet {
            updateContentInsetsIfChanged(contentInsets, from: oldValue)
        }
    }
    
    // MARK: - Overrided properties
    
    open override var text: String? {
        didSet {
            displayIfChanged(text, from: oldValue)
        }
    }
    
    open override var attributedText: NSAttributedString? {
        didSet {
            displayIfChanged(attributedText, from: oldValue)
        }
    }
    
    open override var font: UIFont? {
        didSet {
            layoutIfChanged(font, from: oldValue)
        }
    }
    
    open override var textAlignment: NSTextAlignment {
        didSet {
            layoutIfChanged(textAlignment, from: oldValue)
        }
    }
    
    open override var defaultTextAttributes: [NSAttributedString.Key: Any] {
        didSet {
            forceLayoutSubviewsIfNeeded()
        }
    }
    
    open override var allowsEditingTextAttributes: Bool {
        didSet {
            layoutIfChanged(allowsEditingTextAttributes, from: oldValue)
        }
    }
    
    open override var typingAttributes: [NSAttributedString.Key: Any]? {
        didSet {
            forceLayoutSubviewsIfNeeded()
        }
    }
    
    open override var placeholder: String? {
        didSet {
            updatePlaceholderIfChanged(placeholder, from: oldValue)
        }
    }
    
    open override var attributedPlaceholder: NSAttributedString? {
        didSet {
            layoutIfChanged(attributedPlaceholder, from: oldValue)
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        addTarget(self,
                  action: #selector(_allEditingEventsAction),
                  for: [.allEditingEvents, .valueChanged])
        
        extraContentGuide.addOwningView(self)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func titleViewRect(forBounds bounds: CGRect) -> CGRect {
        let titleSize = titleViewSize(forBounds: bounds)
        var titleRect = extraViewRect(titleViewAlignment, bounds, titleSize)
        titleRect.origin.y = bounds.minY - abs(titleViewSpacing) - titleRect.height

        return titleRect
    }
    
    open func supplyViewRect(forBounds bounds: CGRect) -> CGRect {
        let supplySize = supplyViewSize(forBounds: bounds)
        var supplyRect = extraViewRect(supplyViewAlignment, bounds, supplySize)
        supplyRect.origin.y = bounds.maxY + abs(supplyViewSpacing)
        
        return supplyRect
    }
    
    open override func textRect(forBounds bounds: CGRect) -> CGRect {
        let contentBounds = textRectContentBounds(from: bounds)
        let textRect = super.textRect(forBounds: contentBounds)

        let prefixSize = prefixViewSize(forBounds: contentBounds)
        let suffixSize = suffixViewSize(forBounds: contentBounds)

        let inset = UIEdgeInsets(left: prefixSize.width + prefixViewTextSpacing,
                                 right: suffixSize.width + suffixViewTextSpacing)

        return textRect.inset(by: inset)
    }
    
    open override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return textRect(forBounds: bounds)
    }
    
    open override func leftViewRect(forBounds bounds: CGRect) -> CGRect {
        let contentBounds = leftViewRectContentBounds(from: bounds)
        let size = super.leftViewRect(forBounds: contentBounds).size

        return intraViewRect(leftViewAlignment, contentBounds, size, .zero)
    }
    
    open override func rightViewRect(forBounds bounds: CGRect) -> CGRect {
        let contentBounds = rightViewRectContentBounds(from: bounds)
        let size = super.rightViewRect(forBounds: contentBounds).size

        return intraViewRect(rightViewAlignment, contentBounds, size, bounds.width - size.width)
    }

    open override func layoutSubviews() {
        super.layoutSubviews()
        
        layoutIntraSubviews()
        layoutExtraSubviews()
    }
    
    // MARK: - Private methods
    
    private func layoutExtraSubviews() {
        var titleRect = bounds
        var supplyRect = bounds
        
        if titleView != nil, isNeedToDisplay(titleViewMode) {
            titleRect = titleViewRect(forBounds: bounds)
        }
        if supplyView != nil, isNeedToDisplay(supplyViewMode) {
            supplyRect = supplyViewRect(forBounds: bounds)
        }

        titleView?.frame = titleRect
        supplyView?.frame = supplyRect
        
        let union = bounds.union(titleRect.union(supplyRect))
        var insets: UIEdgeInsets = .zero
        
        if union.minY != bounds.minY {
            insets.top = abs(union.minY - bounds.minY)
        }
        if union.minX != bounds.minX {
            insets.left = abs(union.minX - bounds.minX)
        }
        if union.maxX > bounds.maxX {
            insets.right = abs(union.maxX - bounds.maxX)
        }
        if union.maxY > bounds.maxY {
            insets.bottom = abs(union.maxY - bounds.maxY)
        }

        extraContentGuide.insets = insets
    }
    
    private func layoutIntraSubviews() {
        let isNeedsLayoutPrefixView = prefixView?.superview != nil
        let isNeedsLayoutSuffixView = suffixView?.superview != nil
        
        guard isNeedsLayoutPrefixView || isNeedsLayoutSuffixView else {
            return
        }
        
        let textRect = self.textRect(forBounds: bounds)
        let textSize = self.textSize(forBounds: textRect)

        let contentBounds = bounds.inset(by: contentInsets)

        let prefixSize = prefixViewSize(forBounds: contentBounds)
        let suffixSize = suffixViewSize(forBounds: contentBounds)
        
        var prefixRect = CGRect(origin: .zero, size: prefixSize)
        var suffixRect = CGRect(origin: .zero, size: suffixSize)
        
        switch actualTextAlignment {
        case .left:
            if isNeedsLayoutPrefixView {
                let x = textRect.minX - prefixSize.width - prefixViewTextSpacing
                prefixRect = intraViewRect(prefixViewAlignment, contentBounds, prefixSize, x)
            }
            if isNeedsLayoutSuffixView {
                let x: CGFloat
                if suffixViewPosition == .dynamic {
                    x = textRect.minX + min(textSize.width, textRect.width) + suffixViewTextSpacing
                } else {
                    x = textRect.maxX + suffixViewTextSpacing
                }
                suffixRect = intraViewRect(suffixViewAlignment, contentBounds, suffixSize, x)
            }
            
        case .right:
            if isNeedsLayoutPrefixView {
                let x: CGFloat
                if prefixViewPosition == .dynamic {
                    x = textRect.maxX - prefixSize.width - min(textSize.width, textRect.width) - prefixViewTextSpacing
                } else {
                    x = textRect.minX - prefixSize.width - prefixViewTextSpacing
                }
                prefixRect = intraViewRect(prefixViewAlignment, contentBounds, prefixSize, x)
            }
            if isNeedsLayoutSuffixView {
                let x = textRect.maxX + suffixViewTextSpacing
                suffixRect = intraViewRect(suffixViewAlignment, contentBounds, suffixSize, x)
            }
            
        case .center:
            if isNeedsLayoutPrefixView {
                let x: CGFloat
                if prefixViewPosition == .dynamic {
                    let inRect = textSize.width <= (textRect.width + prefixViewTextSpacing)
                    x = inRect ? textRect.midX - textSize.width / 2 - prefixViewTextSpacing : textRect.minX
                } else {
                    x = textRect.minX - prefixViewTextSpacing
                }
                prefixRect = intraViewRect(prefixViewAlignment, contentBounds, prefixSize, x - prefixSize.width)
            }
            if isNeedsLayoutSuffixView {
                let x: CGFloat
                if suffixViewPosition == .dynamic {
                    let inRect = textSize.width <= (textRect.width + suffixViewTextSpacing)
                    x = inRect ? textRect.midX + textSize.width / 2 + suffixViewTextSpacing : textRect.maxX
                } else {
                    x = textRect.maxX + suffixViewTextSpacing
                }
                suffixRect = intraViewRect(suffixViewAlignment, contentBounds, suffixSize, x)
            }
        }
        
        prefixView?.frame = prefixRect
        suffixView?.frame = suffixRect
    }

    /// Bounds for rect of text with applied `contentInsets` values
    private func textRectContentBounds(from bounds: CGRect) -> CGRect {
        var insets = contentInsets
        // If leftView is displayed then no need for additional inset,
        // but if not - we will add all contentInsets values ourselves
        if isDisplayedLeftView {
            insets.left = 0
        }

        return bounds.inset(by: insets)
    }

    /// Bounds for rect of `leftView` with applied `contentInsets` values
    private func leftViewRectContentBounds(from bounds: CGRect) -> CGRect {
        var insets = contentInsets
        insets.right = 0

        return bounds.inset(by: insets)
    }

    /// Bounds for rect of `rightView` with applied `contentInsets` values
    private func rightViewRectContentBounds(from bounds: CGRect) -> CGRect {
        var insets = contentInsets
        insets.left = 0

        return bounds.inset(by: insets)
    }
    
    private func updateExtraView(_ view: UIView?, with newValue: UIView?, mode: ExtendedViewMode) {
        if view !== newValue {
            view?.removeFromSuperview()
            
            if let view = newValue {
                insertSubview(view, at: 0)
                
                displayExtraViewIfNeeded(newValue, mode: mode)
            }
        }
    }
    
    private func displayExtraViewIfNeeded(_ view: UIView?, mode: ExtendedViewMode) {
        view?.isHidden = !isNeedToDisplay(mode)
    }
    
    private func updateExtraViewMode(_ mode: ExtendedViewMode, with newValue: ExtendedViewMode, view: UIView?) {
        if mode != newValue {
            displayExtraViewIfNeeded(view, mode: newValue)
        }
    }
    
    private func updateIntraView(_ view: UIView?, with newValue: UIView?, mode: ExtendedViewMode) {
        if view !== newValue, newValue != nil {
            view?.removeFromSuperview()
            
            displayIntraViewIfNeeded(newValue, mode: mode)
        }
    }
    
    private func displayIntraViewIfNeeded(_ view: UIView?, mode: ExtendedViewMode) {
        guard let view = view else {
            return
        }
        
        if isNeedToDisplay(mode) {
            if view.superview == nil {
                insertSubview(view, at: 0)
            }
        } else {
            view.removeFromSuperview()
        }
    }
    
    private func updateIntraViewMode(_ mode: ExtendedViewMode, with newValue: ExtendedViewMode, view: UIView?) {
        if mode != newValue {
            displayIntraViewIfNeeded(view, mode: newValue)
        }
    }
    
    private func isNeedToDisplay(_ mode: ExtendedViewMode) -> Bool {
        return mode.isNeedToDisplay(isEditing, isEmpty)
    }
    
    private func titleViewSize(forBounds bounds: CGRect) -> CGSize {
        return extraViewSize(titleView, bounds, titleViewMode, titleViewAlignment)
    }
    
    private func supplyViewSize(forBounds bounds: CGRect) -> CGSize {
        return extraViewSize(supplyView, bounds, supplyViewMode, supplyViewAlignment)
    }
    
    private func prefixViewSize(forBounds bounds: CGRect) -> CGSize {
        return intraViewSize(prefixView, bounds, prefixViewMode, prefixViewAlignment)
    }
    
    private func suffixViewSize(forBounds bounds: CGRect) -> CGSize {
        return intraViewSize(suffixView, bounds, suffixViewMode, suffixViewAlignment)
    }
    
    private func extraViewSize(_ view: UIView?,
                               _ bounds: CGRect,
                               _ mode: ExtendedViewMode,
                               _ alignment: UIControl.ContentHorizontalAlignment) -> CGSize {

        guard let view = view else {
            return .zero
        }

        let range = CGSize(width: bounds.width, height: .greatestFiniteMagnitude)
        let size = view.sizeThatFits(range)
        guard alignment == .fill else {
            return size
        }
        
        return CGSize(width: bounds.width, height: size.height)
    }
    
    private func extraViewRect(_ alignment: UIControl.ContentHorizontalAlignment,
                               _ bounds: CGRect,
                               _ size: CGSize) -> CGRect {
     
        var rect = CGRect(origin: .zero, size: size)
        
        if alignment == .fill || rect.size.width > bounds.width {
            rect.size.width = bounds.width
        }
        
        switch alignment {
        case .right, .trailing:
            rect.origin.x = bounds.maxX - rect.width
            
        case .center:
            rect.origin.x = bounds.midX - rect.width / 2
            
        default:
            break
        }
        
        return rect
    }
    
    private func intraViewSize(_ view: UIView?,
                               _ bounds: CGRect,
                               _ mode: ExtendedViewMode,
                               _ alignment: UIControl.ContentVerticalAlignment) -> CGSize {
        
        guard let view = view, isNeedToDisplay(mode) else {
            return .zero
        }
        
        let size = view.intrinsicContentSize
        guard alignment == .fill else {
            return size
        }
        
        return CGSize(width: size.width, height: bounds.height)
    }
    
    private func intraViewRect(_ alignment: UIControl.ContentVerticalAlignment,
                               _ bounds: CGRect,
                               _ size: CGSize,
                               _ x: CGFloat) -> CGRect {
        
        var origin = CGPoint(x: x, y: contentInsets.top)
        var size = size
        
        switch alignment {
        case .top:
            origin.y = bounds.origin.y
            
        case .center:
            let diff = size.height - bounds.size.height
            origin.y = bounds.origin.y - diff / 2
            
        case .bottom:
            origin.y = bounds.maxY - size.height
            
        case .fill:
            size.height = bounds.height
            
        @unknown default:
            break
        }
        
        // Проверки на не пересечение границ области bounds, так как нет гарантии,
        // что входные значения size и x будут находится в ожидаемом ректе
        if (origin.x + size.width) > bounds.maxX {
            origin.x -= (origin.x + size.width) - bounds.maxX
        }
        if origin.x < bounds.minX {
            origin.x = bounds.minX
        }
        
        return CGRect(origin: origin, size: size)
    }
    
    private func textSize(forBounds bounds: CGRect) -> CGSize {
        var text: String?
        var attributes: [NSAttributedString.Key: Any]?
        
        if isEmpty {
            text = attributedPlaceholder?.string
            if !(text?.isEmpty ?? true) {
                attributes = attributedPlaceholder?.attributes(at: 0, effectiveRange: nil)
            }
        } else {
            text = self.text
            // Ранее использованное значение `typingAttributes ?? defaultTextAttributes` для
            // получения аттрибутов было не корректным, так как `typingAttributes` появляются
            // только когда происходит ввод и отличаются значением от `defaultTextAttributes`
            attributes = attributedText?.attributes(at: 0, effectiveRange: nil)
        }
        
        // Решение использовать функцию size(withAttributes:) было принято исходя из того,
        // что результат вызова метода boundingRect(with:options:attributes:context:)
        // не соответствовал реальной ширине текста и приводил к лайауту с большими погрешностями.
        // Особеннсть заключалось в подсчете размера текста с пробелами, что указано в документации:
        // https://developer.apple.com/documentation/foundation/nsstring/1524729-boundingrect
        let size: CGSize = text?.size(withAttributes: attributes) ?? .zero
        guard size.width > bounds.width else {
            return size
        }
        
        return CGSize(width: bounds.width, height: size.height)
    }
    
    private func displayIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            _allEditingEventsAction()
        }
    }
    
    private func layoutIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            forceLayoutSubviewsIfNeeded()
        }
    }
    
    private func checkIfNeedsForceLayoutSubviews() -> Bool {
        return prefixView != nil || suffixView != nil || titleView != nil || supplyView != nil
    }
    
    private func forceLayoutSubviewsIfNeeded() {
        if checkIfNeedsForceLayoutSubviews() {
            forceLayoutSubviews()
        }
    }

    private func updateContentInsetsIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            forceLayoutSubviews()
        }
    }
    
    private func updatePlaceholderIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            updatePlaceholder()
        }
    }
    
    private func updateAttributedPlaceholderIfChanged<T: Equatable>(_ value: T, from oldValue: T) {
        if value != oldValue {
            updateAttributedPlaceholder()
        }
    }
    
    private func updatePlaceholder() {
        if placeholderMode == .dynamic {
            placeholder = isEditing ? placeholderOnEditing : placeholderOnEmpty
        }
        
        forceLayoutSubviewsIfNeeded()
        updateAttributedPlaceholder()
    }
    
    private func updateAttributedPlaceholder() {
        let string = placeholder ?? ""
        
        if let attributedString = attributedPlaceholder {
            if let color = placeholderColor {
                attributedPlaceholder = attributedString.copy(withString: string,
                                                              name: .foregroundColor,
                                                              value: color)
            } else {
                attributedPlaceholder = attributedString.copy(withString: string)
            }
        } else {
            if let color = placeholderColor, let font = font {
                let attributes: [NSAttributedString.Key: Any] = [
                    .foregroundColor: color,
                    .font: font
                ]
                
                attributedPlaceholder = NSAttributedString(string: string,
                                                           attributes: attributes)
            }
        }
    }
    
    // MARK: - UI Actions
    
    @objc private func _allEditingEventsAction() {
        displayExtraViewIfNeeded(titleView, mode: titleViewMode)
        displayExtraViewIfNeeded(supplyView, mode: supplyViewMode)
        displayIntraViewIfNeeded(prefixView, mode: prefixViewMode)
        displayIntraViewIfNeeded(suffixView, mode: suffixViewMode)
        
        updatePlaceholder()
    }
}
