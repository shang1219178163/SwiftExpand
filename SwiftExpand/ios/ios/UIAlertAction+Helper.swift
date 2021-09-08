//
//  UIAlertAction+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UIAlertAction{
    private struct AssociateKeys {
        static var tag = "UIAlertAction" + "tag"
    }
    
    var tag: Int {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.tag) as? Int {
                return obj
            }
            objc_setAssociatedObject(self, &AssociateKeys.tag, 0, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.tag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 设置UIAlertController按钮颜色
    func setTitleColor(_ color: UIColor = .theme) -> Self {
        setValue(color, forKey: kAlertActionColor)
        return self
    }
    
}
