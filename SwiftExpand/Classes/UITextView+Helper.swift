
//
//  UITextView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension UITextView{
    
    func delegateChain(_ delegate: UITextViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    func textChain(_ text: String!) -> Self {
        self.text = text
        return self
    }

    func fontChain(_ font: UIFont?) -> Self {
        self.font = font
        return self
    }

    func textColorChain(_ textColor: UIColor?) -> Self {
        self.textColor = textColor
        return self
    }

    // default is NSLeftTextAlignment
    func textAlignmentChain(_ textAlignment: NSTextAlignment) -> Self {
        self.textAlignment = textAlignment
        return self
    }

    func selectedRangeChain(_ selectedRange: NSRange) -> Self {
        self.selectedRange = selectedRange
        return self
    }

    func isEditableChain(_ isEditable: Bool) -> Self {
        self.isEditable = isEditable
        return self
    }

    // toggle selectability, which controls the ability of the user to select content and interact with URLs & attachments. On tvOS this also makes the text view focusable.
    @available(iOS 7.0, *)
    func isSelectableChain(_ isSelectable: Bool) -> Self {
        self.isSelectable = isSelectable
        return self
    }

    @available(iOS 3.0, *)
    func dataDetectorTypesChain(_ dataDetectorTypes: UIDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }

    // defaults to NO
    @available(iOS 6.0, *)
    func allowsEditingTextAttributesChain(_ allowsEditingTextAttributes: Bool) -> Self {
        self.allowsEditingTextAttributes = allowsEditingTextAttributes
        return self
    }

    @available(iOS 6.0, *)
    func attributedTextChain(_ attributedText: NSAttributedString!) -> Self {
        self.attributedText = attributedText
        return self
    }

    // automatically resets when the selection changes
    @available(iOS 6.0, *)
    func typingAttributesChain(_ typingAttributes: [NSAttributedString.Key : Any]) -> Self {
        self.typingAttributes = typingAttributes
        return self
    }

    func inputViewChain(_ inputView: UIView?) -> Self {
        self.inputView = inputView
        return self
    }

    func inputAccessoryViewChain(_ inputAccessoryView: UIView?) -> Self {
        self.inputAccessoryView = inputAccessoryView
        return self
    }

    // defaults to NO. if YES, the selection UI is hidden, and inserting text will replace the contents of the field. changing the selection will automatically set this to NO.
    @available(iOS 6.0, *)
    func clearsOnInsertionChain(_ clearsOnInsertion: Bool) -> Self {
        self.clearsOnInsertion = clearsOnInsertion
        return self
    }

    @available(iOS 7.0, *)
    func textContainerInsetChain(_ textContainerInset: UIEdgeInsets) -> Self {
        self.textContainerInset = textContainerInset
        return self
    }

    @available(iOS 7.0, *)
    func linkTextAttributesChain(_ linkTextAttributes: [NSAttributedString.Key : Any]) -> Self {
        self.linkTextAttributes = linkTextAttributes
        return self
    }

    @available(iOS 13.0, *)
    func usesStandardTextScalingChain(_ usesStandardTextScaling: Bool) -> Self {
        self.usesStandardTextScaling = usesStandardTextScaling
        return self
    }
    
    ///获取文字行数
    var numberOfLine: Int {
        let rows = (contentSize.height - textContainerInset.top - textContainerInset.bottom)/font!.lineHeight
        return Int(rows)
    }
    
    /// [源]UITextView创建
    static func create(_ rect: CGRect = .zero) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autocapitalizationType = .none;
        view.autocorrectionType = .no;
        view.backgroundColor = .white;
        
        view.layer.borderWidth = 0.5;
        view.layer.borderColor = UIColor.line.cgColor;
        
        view.textAlignment = .left;
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }
     
    /// 展示性质UITextView创建
    static func createShow(_ rect: CGRect = .zero) -> UITextView {
        let view = UITextView.create(rect);
        view.contentOffset = CGPoint(x: 0, y: 8)
        view.isEditable = false;
        view.dataDetectorTypes = .all;
        return view
    }
    /// 用户协议点击跳转配制方法
    func setupUserAgreements(_ content: String, tapTexts: [String], tapUrls: [String], tapColor: UIColor = UIColor.theme, fontSize: CGFloat = 15) {
        let attDic = [NSAttributedString.Key.foregroundColor: self.textColor ?? UIColor.gray,
                      NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: fontSize)
        ]
                
        let linkAttDic = [NSAttributedString.Key.foregroundColor: tapColor,
                          NSAttributedString.Key.font: self.font ?? UIFont.systemFont(ofSize: fontSize)
        ]
        setupUserAgreements(content, tapTexts: tapTexts, tapUrls: tapUrls, attributes: attDic, linkAttributes: linkAttDic)
    }
    
    /// 用户协议点击跳转配制方法
    func setupUserAgreements(_ content: String, tapTexts: [String], tapUrls: [String], attributes: [NSAttributedString.Key : Any], linkAttributes: [NSAttributedString.Key : Any], options mask: NSString.CompareOptions = []) {
        let attString = NSMutableAttributedString(string: content, attributes: attributes)
        for e in tapTexts.enumerated() {
            let nsRange = (attString.string as NSString).range(of: e.element, options: mask)
            attString.addAttribute(NSAttributedString.Key.link, value: "\(e.offset)_\(tapUrls[e.offset])", range: nsRange)
        }
        linkTextAttributes = linkAttributes
        attributedText = attString
        isSelectable = true
        isEditable = false
    }
}
