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
            return 0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.tag, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 设置UIAlertController按钮颜色
    func setTitleColor(_ color: UIColor = .theme) {
        setValue(color, forKey: kAlertActionColor);
    }
    
    /// 设置UIAlertController Image
//    func setImage(_ image: UIImage?) {
//        guard let image = image else { return }
//        setValue(image, forKey: kAlertActionImage)
//    }
    
//    /// 设置UIAlertController Image
//    func setImageTintColor(_ color: UIColor?) {
//        guard let color = color else { return }
//        setValue(color, forKey: kAlertActionImageTintColor)
//    }
//    
//    /// 设置UIAlertController Image
//    func setChecked(_ value: Bool) {
//        setValue(value, forKey: kAlertActionChecked)
//    }
}
