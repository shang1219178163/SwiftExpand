//
//  NSViewController+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSViewController {

    var vcName: String {
        var name = String(describing: self.classForCoder)
        if name.hasSuffix("ViewController") {
            name = name.replacingOccurrences(of: "ViewController", with: "")
        }
        if name.hasSuffix("Controller") {
            name = name.replacingOccurrences(of: "Controller", with: "")
        }
        return name
    }
    
    // MARK: -funtions
    /// 新增子控制器
    func addChildVC(_ vc: NSViewController) {
        vc.view.frame = self.view.bounds
        addChild(vc)
        view.addSubview(vc.view)
    }
    
    /// 移除添加的子控制器(对应方法 addChildVC)
    func removeChildVC(_ vc: NSViewController) {
        assert(vc.isKind(of: NSViewController.self))
        
        vc.view.removeFromSuperview()
        vc.removeFromParent()
    }
    
    /// 打开弹窗
    func showSheet(_ handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        let rect = CGRectMake(0, 0, preferredContentSize.width, preferredContentSize.height)
        let window = NSWindow(vc: self, rect: rect)
        NSApp.keyWindow?.beginSheet(window, completionHandler: handler)
    }
    /// 关闭弹窗
    func endSheet(response: NSApplication.ModalResponse) {
        guard let window = view.window else { return }
        NSApp.keyWindow?.endSheet(window, returnCode: response)
    }
}
