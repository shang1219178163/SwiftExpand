//
//  NSAlert+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//


@objc public extension NSAlert {
    @discardableResult
    func addButtonsChain(_ titles: [String]?) -> Self {
        titles?.forEach { (obj) in
            addButton(withTitle: obj)
        }
        return self
    }
    
    @discardableResult
    func beginSheetChain(_ handler: ((NSApplication.ModalResponse) -> Void)? = nil) -> Self {
        guard let window = NSApplication.shared.mainWindow else { return self }
        NSApp.activate(ignoringOtherApps: true)
        beginSheetModal(for: window, completionHandler: handler)
        return self
    }
    
    @discardableResult
    func suppressionButtonActionChain(_ handler: @escaping ((NSButton) -> Void)) -> Self {
        suppressionButton?.addActionHandler(handler)
        return self
    }
    
    ///兼容 OC
    static func create(_ title: String, message: String, btnTitles: [String]?) -> Self {
        let alert = self.init()
        alert.messageText = title
        alert.informativeText = message
        alert.alertStyle = .informational
        if let titles = btnTitles {
            for e in titles {
                alert.addButton(withTitle: e)
            }
        }
        return alert
    }

}
