//
//  NSTabView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import AppKit

@objc public extension NSTabView {

    /*
    /// 添加子视图
    /// - Parameter items: @[@[@"JsonToModelNewController", @"json转模型", ],
    @[@"ProppertyLazyController", @"属性Lazy",],
    @[@"AuthorInfoController", @"其他",],
    @[@"NSTestViewController", @"测试模块",],
    @[@"MacTemplet.TmpViewController",],
    ]
     */
    func addItems(_ items: [[String]]) {
        for e in items.enumerated() {
            let vc = NSCtrFromString(e.element.first!)
            if e.element.count > 1 {
                vc.title = vc.title ?? e.element[1]
            }
            
            let item = NSTabViewItem(viewController: vc)
            item.view = vc.view
            addTabViewItem(item)
        }
    }
}


public extension NSTabView {

    ///添加控制器及其名称
    @discardableResult
    func addItems(_ items: [(NSViewController, String)], handler: ((NSTabViewItem)->Void)? = nil) -> Self {
        items.forEach { (vc, title) in
            vc.title = title
            
            let item = NSTabViewItem(viewController: vc)
            item.view = vc.view
            handler?(item)
            addTabViewItem(item)
        }
        return self
    }
    
    @discardableResult
    func reloadItems(_ items: [(NSViewController, String)], handler: ((NSTabViewItem)->Void)? = nil) -> Self {
        tabViewItems.forEach {
            removeTabViewItem($0)
        }
        addItems(items, handler: handler)
        return self
    }
    
}
