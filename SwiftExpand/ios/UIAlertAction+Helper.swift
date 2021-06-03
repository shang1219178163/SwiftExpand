//
//  UIAlertAction+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/16.
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
        setValue(color, forKey: kAlertActionColor);
        return self
    }
    
    // 设置UIAlertController Image
    func setImage(_ image: UIImage?) -> Self {
        guard let image = image else { return self }
        setValue(image, forKey: kAlertActionImage)
        return self
    }
    
    /// 设置UIAlertController Image
    func setImageTintColor(_ color: UIColor?) -> Self {
        guard let color = color else { return self }
        setValue(color, forKey: kAlertActionImageTintColor)
        return self
    }
    
    /// 设置UIAlertController Image
    func setChecked(_ value: Bool) -> Self {
        setValue(value, forKey: kAlertActionChecked)
        return self
    }
}
