//
//  UISearchBar+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/10/9.
//

import UIKit

@objc public extension UISearchBar{
    
    var placeholderStr: String {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! String;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            if newValue.count <= 0  {
                return;
            }
            let dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  UIColor.white.withAlphaComponent(0.5),
                                                      NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 13),
            ]
            guard let textField: UITextField = (self.findSubview(type: UITextField.self, resursion: true) as? UITextField) else { return }
            textField.attributedPlaceholder = NSAttributedString(string: newValue, attributes: dic);
            
        }
    }
    
}
