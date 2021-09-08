//
//  UITextView+Hook.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//


/**
 此实现不完美, 建议继承 UITextView 实现该效果
 */

import UIKit
import Foundation

@objc extension UITextView{
    private struct AssociateKeys {
        static var placeHolderLabel = "UITextView" + "placeHolderLabel"
    }
            
    public var placeHolderLabel: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.placeHolderLabel) as? UILabel {
                return obj
            }
            let obj = UILabel()
            obj.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            obj.font = font
            obj.textColor = .gray
            obj.textAlignment = textAlignment
//            obj.text = "请输入"
            obj.numberOfLines = 0
            obj.contentMode = .top
            obj.backgroundColor = .clear
            obj.isUserInteractionEnabled = true
//            obj.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(obj)
            
            obj.addGestureTap { (reco) in
                self.becomeFirstResponder()
            }
            
            let inset = UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6)
            obj.zz_equalToSuperview(inset)
            
            NotificationCenter.default.addObserver(self, selector: #selector(p_textViewDidBeginEditing(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(p_textViewDidEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(p_textViewDidChange(_:)), name: UITextView.textDidChangeNotification, object: nil)

            objc_setAssociatedObject(self, &AssociateKeys.placeHolderLabel, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return obj
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.placeHolderLabel, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    private func p_textViewDidBeginEditing(_ n: Notification) {
        DispatchQueue.main.async {
            self.placeHolderLabel.isHidden = true
        }
    }
    
    private func p_textViewDidEndEditing(_ n: Notification) {
        DispatchQueue.main.async {
            self.placeHolderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    private func p_textViewDidChange(_ n: Notification) {
//        guard let textView = n.object as? UITextView else { return }
        DispatchQueue.main.async {
            self.placeHolderLabel.isHidden = !self.text.isEmpty
        }
    }
    
    
}
