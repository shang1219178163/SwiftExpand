//
//  UITextView+Hook.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc extension UITextView{
    private struct AssociateKeys {
        static var placeHolderLabel = "UITextView" + "placeHolderLabel"
    }
    
//    override public class func initializeMethod() {
//        super.initializeMethod()
//
//        if self != UITextView.self {
//            return
//        }
//
//        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))"
//        DispatchQueue.once(token: onceToken) {
//            let oriSel = NSSelectorFromString("deinit")
//            let repSel = #selector(self.hook_deinit)
//            hookInstanceMethod(of: oriSel, with: repSel)
//        }
//    }
//
//    private func hook_deinit() {
//        //需要注入的代码写在此处
//        NotificationCenter.default.removeObserver(self)
//        self.hook_deinit()
//    }
            
    public var placeHolderLabel: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.placeHolderLabel) as? UILabel {
                return obj
            }
            let obj = UILabel()
            obj.frame = bounds.inset(by: UIEdgeInsets(top: 8, left: 6, bottom: 8, right: 6))
            obj.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            obj.font = font
            obj.textColor = .gray
            obj.textAlignment = textAlignment
            obj.text = "请输入"
            obj.numberOfLines = 0
            obj.backgroundColor = .clear
            obj.isUserInteractionEnabled = true
            obj.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(obj)
            
            
            obj.addGestureTap { (reco) in
                self.becomeFirstResponder()
            }
            
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
