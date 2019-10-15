//
//  UIControl+Helper.swift
//  BuildUI
//
//  Created by Bin Shang on 2018/12/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UIControl {
    /// UIControl 添加回调方式
    func addActionHandler(_ action: @escaping (ControlClosure), for controlEvents: UIControl.Event = UIControl.Event.touchUpInside) {
        let funcAbount = NSStringFromSelector(#function) + ",\(controlEvents)"
        let runtimeKey = RuntimeKeyFromParams(self, funcAbount: funcAbount)!
        
        self.runtimeKey = runtimeKey
        addTarget(self, action:#selector(handleActionSender(_:)), for:controlEvents);
        objc_setAssociatedObject(self, runtimeKey, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /// 点击回调
    private func handleActionSender(_ sender: UIControl) {
        let block = objc_getAssociatedObject(self, self.runtimeKey) as? ControlClosure;
        if block != nil {
            block!(sender);
        }
        
    }
}
