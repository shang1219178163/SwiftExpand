
//
//  UITextView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

public extension UITextView{
    
    public var placeHolderTextView: UITextView {
        get {
            var view = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UITextView;
            if view == nil {
                view = UITextView(frame: bounds);
                view!.autoresizingMask = UIViewAutoresizing(rawValue: UIViewAutoresizing.flexibleWidth.rawValue | UIViewAutoresizing.flexibleHeight.rawValue)
                view!.autocapitalizationType = .none;
                view!.autocorrectionType = .no;
                view!.backgroundColor = .clear;
                view!.textColor = .gray
                view!.textAlignment = .left;
                view!.font = self.font
                self.addSubview(view!)
                
                
                NotificationCenter.default.addObserver(self, selector: #selector(textViewDidBeginEditing(_:)), name: NSNotification.Name.UITextViewTextDidBeginEditing, object: nil)
                NotificationCenter.default.addObserver(self, selector: #selector(textViewDidEndEditing(_:)), name: NSNotification.Name.UITextViewTextDidEndEditing, object: nil)

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

            }
            return view!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc func textViewDidBeginEditing(_ noti: Notification) -> Void {
        placeHolderTextView.isHidden = true
    }
    
    @objc func textViewDidEndEditing(_ noti: Notification) -> Void {
        placeHolderTextView.isHidden = false

    }
    
    
}
