//
//  NSMenu+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//


import AppKit

@objc public extension NSMenu {
    
    convenience init(title: String, children: [NSMenuItem]) {
        self.init(title: title)
        children.forEach {
            addItem($0)
        }
    }

    ///遍历方法
    convenience init(with title: String = "Menu", itemTitles: [String], handler: ((NSMenuItem) -> Void)?) {
        self.init()
        self.title = title
                
        for e in itemTitles.enumerated() {
            let item = NSMenuItem(title: e.element, action: nil, keyEquivalent: "")
            if let handler = handler {
                item.addAction(handler)
            }
            self.addItem(item)
        }
    }


    @discardableResult
    func addItem(withTitle title: String, keyEquivalent charCode: String, handler: @escaping (NSMenuItem) -> Void) -> Self {
        let item = addItem(withTitle: title, action: nil, keyEquivalent: charCode)
        item.addAction(handler)
        return self
    }
    
    @discardableResult
    func insertItem(withTitle title: String, keyEquivalent charCode: String, at index: Int, handler: @escaping (NSMenuItem) -> Void) -> Self {
        let item = insertItem(withTitle: title, action: nil, keyEquivalent: charCode, at: index)
        item.addAction(handler)
        return self
    }

}


@objc public extension NSMenuItem {
    private struct AssociateKeys {
        static var closure = "NSMenuItem" + "closure"
    }

    /// 闭包回调
    func addAction(_ handler: @escaping ((NSMenuItem) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC)
        target = self
        action = #selector(p_invoke(_:))
    }
    
    private func p_invoke(_ sender: NSMenuItem) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSMenuItem) -> Void) {
            handler(sender)
        }
    }
    
    convenience init(title string: String, keyEquivalent charCode: String, handler: ((NSMenuItem) -> Void)?) {
        self.init(title: string, action: nil, keyEquivalent: charCode)
        if let handler = handler {
            self.addAction(handler)
        }
    }

}
