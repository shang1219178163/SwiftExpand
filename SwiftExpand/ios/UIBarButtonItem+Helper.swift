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
    
    convenience init(_ obj: String, style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) {
        if let image = UIImage(named: obj) {
            self.init(image: image, style: style, target: target, action: action)
            return
        }
        self.init(title: obj, style: style, target: target, action: action)
    }
    
    convenience init(_ obj: String, style: UIBarButtonItem.Style = .plain, action: @escaping ((UIBarButtonItem) -> Void)) {
        self.init(obj, style: style, target: nil, action: nil)
        self.addAction(action)
    }
    
    /// 按钮是否显示
    func setHidden(_ hidden: Bool, color: UIColor = UIColor.theme) {
        isEnabled = !hidden
        tintColor = !hidden ? color : .clear
    }
    
    func addTargetForAction(_ target: AnyObject, action: Selector) {
        self.target = target
        self.action = action
    }
    
    /// 创建多个 UIBarButtonItem
    static func createTitles(_ titles: [String], style: UIBarButtonItem.Style = .plain, target: Any? = nil, action: Selector? = nil) -> [UIBarButtonItem]{
        var list = [UIBarButtonItem]()
        
        for e in titles.enumerated() {
            let barItem = UIBarButtonItem(title: e.element, style: style, target: target, action: action)
            list.append(barItem)
        }
        return list
    }
    
    
    /// 创建多个 UIBarButtonItem
    static func createTitles(_ titles: [String], style: UIBarButtonItem.Style = .plain, action: @escaping ((UIBarButtonItem) -> Void)) -> [UIBarButtonItem]{
        var list = [UIBarButtonItem]()
        
        for e in titles.enumerated() {
            let barItem = UIBarButtonItem(title: e.element, style: style, target: nil, action: nil)
            barItem.addAction(action)
            list.append(barItem)
        }
        return list
    }
    
    /// Creates a fixed space UIBarButtonItem with a specific width.
    static func fixedSpace(width: CGFloat) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        barButtonItem.width = width
        return barButtonItem
    }
}
