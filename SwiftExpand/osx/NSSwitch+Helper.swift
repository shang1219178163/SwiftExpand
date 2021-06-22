//
//  NSSwitch+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/25.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@available(OSX 10.15, *)
@objc public extension NSSwitch {

    private struct AssociateKeys {
        static var closure   = "NSSwitch" + "closure"
    }
    
    /// 闭包回调
    func adActionHandler(_ handler: @escaping ((NSSwitch) -> Void)) {
        target = self
        action = #selector(p_invokeSwitch(_:))
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
        
    private func p_invokeSwitch(_ sender: NSSwitch) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSSwitch) -> Void) {
            handler(sender)
        }
    }
    
    
}
