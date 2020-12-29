//
//  UIBarButtonItem+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UIBarButtonItem{
    private struct AssociateKeys {
        static var systemType = "UIBarButtonItem" + "systemType"
        static var closure = "UIBarButtonItem" + "closure"
    }
    
    var systemType: UIBarButtonItem.SystemItem {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.systemType) as? UIBarButtonItem.SystemItem {
                return obj
            }
            return .done
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.systemType, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// UIBarButtonItem 回调
    func addAction(_ closure: @escaping ((UIBarButtonItem) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke);
    }

    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIBarButtonItem) -> Void) {
            closure(self);
        }
    }
    
    /// 按钮是否显示
    func setHidden(_ hidden: Bool, color: UIColor = UIColor.theme) {
        isEnabled = !hidden;
        tintColor = !hidden ? color : .clear;
    }

    /// 创建 UIBarButtonItem
    static func create(_ obj: String, style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) -> UIBarButtonItem{
        if let image = UIImage(named: obj) {
            return UIBarButtonItem(image: image, style: style, target: target, action: action)
        }
        return UIBarButtonItem(title: obj, style: style, target: target, action: action);
    }
    
    /// 创建多个 UIBarButtonItem
    static func createTitles(_ titles: [String], style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) -> [UIBarButtonItem]{
        var list = [UIBarButtonItem]()
        
        for e in titles.enumerated() {
            let barItem = UIBarButtonItem(title: e.element, style: style, target: target, action: action);
            list.append(barItem)
        }
        return list
    }

}
