
//
//  UITextView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UITextView{
    
    ///获取文字行数
    var numberOfLine: Int {
        let rows = (contentSize.height - textContainerInset.top - textContainerInset.bottom)/font!.lineHeight
        return Int(rows)
    }
    
    /// [源]UITextView创建
    static func create(_ rect: CGRect = .zero) -> Self {
        let view = self.init(frame: rect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .white
        
        view.layer.borderWidth = 0.5
        view.layer.borderColor = UIColor.line.cgColor
        
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }
     
    /// 展示性质UITextView创建
    static func createShow(_ rect: CGRect = .zero) -> UITextView {
        let view = UITextView.create(rect)
        view.contentOffset = CGPoint(x: 0, y: 8)
        view.isEditable = false
        view.dataDetectorTypes = .all
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
