//
//  UIControl+Helper.swift
//  BuildUI
//
//  Created by Bin Shang on 2018/12/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc extension UIControl {
    private struct AssociateKeys {
        static var closure   = "UIControl" + "closure"
    }
    /// UIControl 添加回调方式
    public func addActionHandler(_ action: @escaping ((UIControl) ->Void), for controlEvents: UIControl.Event = .touchUpInside) {
        addTarget(self, action:#selector(p_handleAction(_:)), for:controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 点击回调
    private func p_handleAction(_ sender: UIControl) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIControl) ->Void) {
            block(sender)
        }
    }
}
