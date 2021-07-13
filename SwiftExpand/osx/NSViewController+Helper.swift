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
}
