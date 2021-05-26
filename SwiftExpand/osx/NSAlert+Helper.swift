//
//  NSAlert+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import SwiftChain

@objc public extension NSAlert {
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
    ///兼容 OC
    static func show(_ title: String, message: String, btnTitles: [String]?, handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        NSAlert()
            .messageTextChain(title)
            .informativeTextChain(message)
            .addButtonsChain(btnTitles)
            .beginSheetChain(handler)
    }
    
    func suppressionButtonActionChain(_ handler: @escaping ((NSButton) -> Void)) -> Self {
        suppressionButton?.addActionHandler(handler)
        return self
    }
}
