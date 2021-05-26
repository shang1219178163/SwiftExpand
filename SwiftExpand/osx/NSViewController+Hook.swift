//
//  NSViewController+Hook.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/4.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSViewController{
    override class func initializeMethod() {
        super.initializeMethod()
        
        if self != NSViewController.self {
            return
        }
        
        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
        DispatchQueue.once(token: onceToken) {
            let oriSel = #selector(present(_:asPopoverRelativeTo:of:preferredEdge:behavior:))
            let repSel = #selector(hook_present(_:asPopoverRelativeTo:of:preferredEdge:behavior:))
            hookInstanceMethod(of: oriSel, with: repSel)
        }
        
    }
        
    private func hook_present(_ viewController: NSViewController, asPopoverRelativeTo positioningRect: NSRect, of positioningView: NSView, preferredEdge: NSRectEdge, behavior: NSPopover.Behavior){
        if viewController.presentingViewController != nil {
            dismiss(viewController)
            return
        }
        
        hook_present(viewController, asPopoverRelativeTo: positioningRect, of: positioningView, preferredEdge: preferredEdge, behavior: behavior)
    }

}
