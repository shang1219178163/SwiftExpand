//
//  NSGestureRecognizer+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSGestureRecognizer {
    private struct AssociateKeys {
        static var closure    = "NSGestureRecognizer" + "closure"
    }

    /// 闭包回调
    func addAction(_ handler: @escaping ((NSGestureRecognizer) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke(_:));
    }

    private func p_invoke(_ sender: NSGestureRecognizer) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSGestureRecognizer) -> Void) {
            handler(sender);
        }
    }
    
}

@objc public extension NSClickGestureRecognizer {
    private struct AssociateKeys {
        static var closure    = "NSClickGestureRecognizer" + "closure"
    }
    
    /// 闭包回调
    override func addAction(_ handler: @escaping (NSClickGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invokeClick(_:));
    }

    private func p_invokeClick(_ sender: NSClickGestureRecognizer) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSClickGestureRecognizer) -> Void) {
            handler(sender);
        }
    }
    
}

