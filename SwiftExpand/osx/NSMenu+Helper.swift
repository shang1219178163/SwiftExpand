//
//  NSMenu+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//




@objc public extension NSMenu {
    ///
    convenience init(withTitle title: String = "Menu", itemTitles: [String], handler: ((NSMenuItem) -> Void)? = nil) {
        self.init()
        self.title = title
                
        for e in itemTitles.enumerated() {
            let item = NSMenuItem(title: e.element, action: nil, keyEquivalent: "")
            if handler != nil {
                item.addAction(handler!)
            }
            self.addItem(item)
        }
    }
    /// 创建下拉菜单
    static func createMenu(withTitle title: String = "Menu", itemTitles: [String], handler: ((NSMenuItem) -> Void)? = nil) -> NSMenu {
        
        let menu = NSMenu(title: title)
        for e in itemTitles.enumerated() {
            let item = NSMenuItem(title: e.element, action: nil, keyEquivalent: "")
            if handler != nil {
                item.addAction(handler!)
            }
            menu.addItem(item)
        }
        return menu;
    }

    @discardableResult
    func addItem(withTitle title: String, keyEquivalent: String, handler: @escaping (NSMenuItem) -> Void) -> NSMenuItem {
        let item = addItem(withTitle: title, action: nil, keyEquivalent: keyEquivalent)
        item.addAction(handler)
        return item;
    }
    
    @discardableResult
    func insertItem(withTitle title: String, keyEquivalent charCode: String, at index: Int, handler: @escaping (NSMenuItem) -> Void) -> NSMenuItem {
        let item = insertItem(withTitle: title, action: nil, keyEquivalent: charCode, at: index)
        item.addAction(handler)
        return item;
    }
    
    
}


@objc public extension NSMenuItem {
    private struct AssociateKeys {
        static var closure = "NSMenuItem" + "closure"
    }
    
    static func create(title: String, keyEquivalent charCode: String, handler: @escaping ((NSMenuItem) -> Void)) -> NSMenuItem {
        let menuItem = NSMenuItem(title: title, action: nil, keyEquivalent: charCode)
        menuItem.addAction(handler)
        return menuItem;
    }
    /// 闭包回调
    func addAction(_ handler: @escaping ((NSMenuItem) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke(_:));
    }
    
    private func p_invoke(_ sender: NSMenuItem) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSMenuItem) -> Void) {
            handler(sender);
        }
    }
    
//    func menuChain(_ menu: NSMenu?) -> Self {
//        self.menu = menu
//        return self
//    }
//
//    func submenuChain(_ submenu: NSMenu?) -> Self {
//        self.submenu = submenu
//        return self
//    }
//
//    func titleChain(_ title: String) -> Self {
//        self.title = title
//        return self
//    }
//
//    func attributedTitleChain(_ attributedTitle: NSAttributedString?) -> Self {
//        self.attributedTitle = attributedTitle
//        return self
//    }
//
//    func keyEquivalentChain(_ keyEquivalent: String) -> Self {
//        self.keyEquivalent = keyEquivalent
//        return self
//    }
//
//    func keyEquivalentModifierMaskChain(_ keyEquivalentModifierMask: NSEvent.ModifierFlags) -> Self {
//        self.keyEquivalentModifierMask = keyEquivalentModifierMask
//        return self
//    }
//
//    @available(macOS 10.13, *)
//    func allowsKeyEquivalentWhenHiddenChain(_ allowsKeyEquivalentWhenHidden: Bool) -> Self {
//        self.allowsKeyEquivalentWhenHidden = allowsKeyEquivalentWhenHidden
//        return self
//    }
//
//    func imageChain(_ image: NSImage?) -> Self {
//        self.image = image
//        return self
//    }
//
//    func stateChain(_ state: NSControl.StateValue) -> Self {
//        self.state = state
//        return self
//    }
//
//    // checkmark by default
//    func onStateImageChain(_ onStateImage: NSImage!) -> Self {
//        self.onStateImage = onStateImage
//        return self
//    }
//
//    // none by default
//    func offStateImageChain(_ offStateImage: NSImage?) -> Self {
//        self.offStateImage = offStateImage
//        return self
//    }
//
//    // horizontal line by default
//    func mixedStateImageChain(_ mixedStateImage: NSImage!) -> Self {
//        self.mixedStateImage = mixedStateImage
//        return self
//    }
//
//    func isEnabledChain(_ isEnabled: Bool) -> Self {
//        self.isEnabled = isEnabled
//        return self
//    }
//
//    func isAlternateChain(_ isAlternate: Bool) -> Self {
//        self.isAlternate = isAlternate
//        return self
//    }
//
//    func indentationLevelChain(_ indentationLevel: Int) -> Self {
//        self.indentationLevel = indentationLevel
//        return self
//    }
//
//    func targetChain(_ target: AnyObject?) -> Self {
//        self.target = target
//        return self
//    }
//
//    func actionChain(_ action: Selector?) -> Self {
//        self.action = action
//        return self
//    }
//
//    func tagChain(_ tag: Int) -> Self {
//        self.tag = tag
//        return self
//    }
//
//    func representedObjectChain(_ representedObject: Any?) -> Self {
//        self.representedObject = representedObject
//        return self
//    }
//
//    @available(macOS 10.5, *)
//    func viewChain(_ view: NSView?) -> Self {
//        self.view = view
//        return self
//    }
//
//    @available(macOS 10.5, *)
//    func isHiddenChain(_ isHidden: Bool) -> Self {
//        self.isHidden = isHidden
//        return self
//    }
//
//    func toolTipChain(_ toolTip: String?) -> Self {
//        self.toolTip = toolTip
//        return self
//    }
}
