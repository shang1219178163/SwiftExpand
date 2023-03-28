//
//  NSAlert+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import AppKit

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
    
    convenience init(title: String, message: String, btnTitles: [String], style: NSAlert.Style = .informational) {
        self.init()
        self.messageText = title
        self.informativeText = message
        self.alertStyle = style
        for e in btnTitles {
            self.addButton(withTitle: e)
        }
    }

}
