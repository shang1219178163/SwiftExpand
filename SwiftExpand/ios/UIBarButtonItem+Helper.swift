//
//  UIBarButtonItem+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

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
            objc_setAssociatedObject(self, &AssociateKeys.systemType, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// UIBarButtonItem 回调
    func addAction(_ closure: @escaping ((UIBarButtonItem) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        target = self
        action = #selector(p_invoke)
    }

    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIBarButtonItem) -> Void) {
            closure(self)
        }
    }
    
    convenience init(obj: String, style: UIBarButtonItem.Style = .plain, tag: Int = 0, target: Any? = nil, action: Selector? = nil) {
        if let image = UIImage(named: obj) {
            self.init(image: image, style: style, target: target, action: action)
        } else {
            self.init(title: obj, style: style, target: target, action: action)
        }
        self.tag = tag
    }
    
    convenience init(obj: String, style: UIBarButtonItem.Style = .plain, tag: Int = 0, action: @escaping ((UIBarButtonItem) -> Void)) {
        self.init(obj: obj, style: style, tag: tag, target: nil, action: nil)
        self.addAction(action)
    }
    
    convenience init(systemItem: UIBarButtonItem.SystemItem, tag: Int = 0, action: @escaping ((UIBarButtonItem) -> Void)) {
        self.init(barButtonSystemItem: systemItem, target: nil, action: nil)
        self.tag = tag
        self.systemType = systemItem
        self.addAction(action)
    }
    
    convenience init(button obj: String, tag: Int = 0, action: @escaping ((UIButton) -> Void)) {
        let sender = UIButton(barItem: obj)
        sender.addActionHandler(action)
        self.init(customView: sender)
        self.tag = tag
    }
    
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
    
    /// Creates a fixed space UIBarButtonItem with a specific width.
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
    
    /// Creates a flexibleSpace space UIBarButtonItem with a specific width.
    static func flexibleSpace() -> UIBarButtonItem {
        return UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
    }
}
