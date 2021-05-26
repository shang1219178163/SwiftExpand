//
//  NSControl+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSControl{
    private struct AssociateKeys {
        static var closure   = "NSControl" + "closure"
    }
    
    func addTarget(_ target: AnyObject?, action: Selector?, on mask: NSEvent.EventTypeMask = .leftMouseDown) {
        self.target = target;
        self.action = action;
        sendAction(on: mask)
    }
    /// 闭包回调
    func addActionHandler(_ handler: @escaping ((NSControl) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke(_:));
    }
    
    private func p_invoke(_ sender: NSControl) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSControl) -> Void) {
            handler(sender);
        }
    }

}
