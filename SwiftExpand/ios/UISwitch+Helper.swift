//
//  UISwitch+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UISwitch{
    
    private struct AssociateKeys {
        static var closure   = "UISwitch" + "closure"
    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UISwitch) ->Void), for controlEvents: UIControl.Event = .valueChanged) {
        addTarget(self, action:#selector(p_handleActionSwitch(_:)), for:controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 点击回调
    private func p_handleActionSwitch(_ sender: UISwitch) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UISwitch) ->Void) {
            block(sender)
        }
    }

    /// [源]UISwitch创建
    convenience init(rect: CGRect = .zero, isOn: Bool = true) {
        self.init(frame: rect)
        self.autoresizingMask = .flexibleWidth
        self.isOn = isOn
        self.onTintColor = UIColor.theme
    }
    
}
