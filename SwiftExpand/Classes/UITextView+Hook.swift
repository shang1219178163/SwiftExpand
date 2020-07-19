//
//  UITextView+Hook.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc extension UITextView{
    
    override public class func initializeMethod() {
        super.initializeMethod();
        
        if self != UITextView.self {
            return
        }

        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
        DispatchQueue.once(token: onceToken) {
            let oriSel = NSSelectorFromString("deinit")
            let repSel = #selector(self.hook_deinit)
            _ = hookInstanceMethod(of: oriSel, with: repSel);
        }
        
    }
    
    private func hook_deinit() {
        //需要注入的代码写在此处
        NotificationCenter.default.removeObserver(self)
        self.hook_deinit()
    }
    
    public var placeHolderTextView: UITextView {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UITextView {
                return obj
            }
            
            let view = UITextView(frame: bounds);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.autocapitalizationType = .none;
            view.autocorrectionType = .no;
            view.backgroundColor = .clear;
            view.textColor = .gray
            view.textAlignment = .left;
            view.font = self.font
            self.addSubview(view)
            
            NotificationCenter.default.addObserver(self, selector: #selector(p_textViewDidBeginEditing(_:)), name: UITextView.textDidBeginEditingNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(p_textViewDidEndEditing(_:)), name: UITextView.textDidEndEditingNotification, object: nil)

            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    private func p_textViewDidBeginEditing(_ n: Notification) {
        placeHolderTextView.isHidden = true
    }
    
    private func p_textViewDidEndEditing(_ n: Notification) {
        placeHolderTextView.isHidden = (self.text != "")
    }
    
    
}
