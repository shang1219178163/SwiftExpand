//
//  UISearchBar+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/10/9.
//

import UIKit

@objc public extension UISearchBar{
    
    var textField: UITextField? {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UITextField;
            if obj == nil {
                obj = self.findSubview(type: UITextField.self, resursion: true) as? UITextField
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj;
        }
    }
    
    var cancellBtn: UIButton? {
        if let btn = self.findSubview(type: (NSClassFromString("UINavigationButton") as! UIResponder.Type).self, resursion: true) as? UIButton {
            return btn;
        }
        return nil;
    }
    
//    var cancellBtn: UIButton? {
//        get {
//            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIButton;
//            if obj == nil {
//                obj = self.findSubview(type: (NSClassFromString("UINavigationButton") as! UIResponder.Type).self, resursion: true) as? UIButton
//                obj?.setTitle("取消", for: .normal)
//                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            }
//            return obj;
//        }
//    }
    
//    var textField: UITextField? {
//        guard let textField: UITextField = (self.findSubview(type: UITextField.self, resursion: true) as? UITextField) else { return nil}
//        return textField;
//    }
    
//    var cancellBtn: UITextField? {
//        guard let textField: UITextField = (self.findSubview(type: SwiftClassFromString("UINavigationButton").self, resursion: true) as? UITextField) else { return nil}
//        return textField;
//    }
    
//    var placeholderStr: String {
//        get {
//            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! String;
//        }
//        set {
//            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//
//            if newValue.count <= 0  {
//                return;
//            }
//            let dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  UIColor.white.withAlphaComponent(0.5),
//                                                      NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 13),
//            ]
//            guard let textField: UITextField = (self.findSubview(type: UITextField.self, resursion: true) as? UITextField) else { return }
//            textField.attributedPlaceholder = NSAttributedString(string: newValue, attributes: dic);
//
//        }
//    }
    
}
