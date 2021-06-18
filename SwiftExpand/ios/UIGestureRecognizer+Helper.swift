//
//  UIGestureRecognizer+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/23.
//

import UIKit

@objc public extension UIGestureRecognizer{
    private struct AssociateKeys {
        static var funcName   = "UIGestureRecognizer" + "funcName"
        static var closure    = "UIGestureRecognizer" + "closure"
    }
    
    /// 方法名称(用于自定义)
    var funcName: String {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.funcName) as? String {
                return obj;
            }
 
            let string = String(describing: self.classForCoder);
            objc_setAssociatedObject(self, &AssociateKeys.funcName, string, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return string
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.funcName, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// 闭包回调
    func addAction(_ closure: @escaping (UIGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        addTarget(self, action: #selector(p_invoke))
    }
    
    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIGestureRecognizer) -> Void) {
            closure(self);
        }
    }
    
}



@objc public extension UITapGestureRecognizer {
    private struct AssociateKeys {
        static var closure    = "UITapGestureRecognizer" + "closure"
    }
    
    /// 闭包回调
    override func addAction(_ closure: @escaping (UITapGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        addTarget(self, action: #selector(p_invokeTap))
    }
    
    private func p_invokeTap() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UITapGestureRecognizer) -> Void) {
            closure(self);
        }
    }
    
    /// UILabel 富文本点击
    func didTapAttributedTextIn(label: UILabel, tapTexts: [String], action: @escaping (String, Int) -> Void) {
        // Create instances of NSLayoutManager, NSTextContainer and NSTextStorage
        let layoutManager = NSLayoutManager()
        let textContainer = NSTextContainer(size: CGSize.zero)
        let textStorage = NSTextStorage(attributedString: label.attributedText!)

        // Configure layoutManager and textStorage
        layoutManager.addTextContainer(textContainer)
        textStorage.addLayoutManager(layoutManager)

        // Configure textContainer
        textContainer.lineFragmentPadding = 0.0
        textContainer.lineBreakMode = label.lineBreakMode
        textContainer.maximumNumberOfLines = label.numberOfLines

        let labelSize = label.bounds.size
        textContainer.size = labelSize

        // Find the tapped character location and compare it to the specified range
        let locationOfTouchInLabel = self.location(in: label)
        let textBoundingBox = layoutManager.usedRect(for: textContainer)
        let textContainerOffset = CGPoint(x:(labelSize.width - textBoundingBox.size.width)*0.5 - textBoundingBox.origin.x,
                                        y:(labelSize.height - textBoundingBox.size.height)*0.5 - textBoundingBox.origin.y);
        let locationOfTouchInTextContainer = CGPoint(x: locationOfTouchInLabel.x - textContainerOffset.x,
                                                   y: locationOfTouchInLabel.y - textContainerOffset.y);

        let indexOfCharacter = layoutManager.characterIndex(for: locationOfTouchInTextContainer,
                                                          in: textContainer,
                                                          fractionOfDistanceBetweenInsertionPoints: nil)

        if label.text == nil {
            return;
        }
        
        for e in tapTexts.enumerated() {
            let targetRange: NSRange = (label.text! as NSString).range(of: e.element)
            let isContain = NSLocationInRange(indexOfCharacter, targetRange)
            if isContain {
                action(e.element, e.offset)
            }
        }
    }
}
