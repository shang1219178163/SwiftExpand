//
//  NSWindow+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSWindow {

    // MARK: -funtions
    /// 默认大小
    static var defaultRect: CGRect {
        return CGRectMake(0, 0, kScreenWidth*0.5, kScreenHeight*0.5)
    }

    static func create(_ rect: CGRect = NSWindow.defaultRect, title: String = NSApplication.appName) -> Self {
        let style: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable]
        let window = self.init(contentRect: rect, styleMask: style, backing: .buffered, defer: false)
        window.title = title
        window.titlebarAppearsTransparent = true
        return window;
    }

    static func create(_ rect: CGRect = NSWindow.defaultRect, controller: NSViewController) -> Self {
        let window = self.create(rect, title: controller.title ?? "")
        window.contentViewController = controller;
        return window;
    }
    
    static func createMain(_ rect: CGRect = NSWindow.defaultRect, title: String = NSApplication.appName) -> Self {
        let window = self.create(rect, title: title)
        window.contentMinSize = window.frame.size;
        window.makeKeyAndOrderFront(self)
        window.center()
        return window;
    }
    
    /// 下拉弹窗
    static func showSheet(with controller: NSViewController, size: CGSize, handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        controller.preferredContentSize = size
        let rect = CGRectMake(0, 0, size.width, size.height)

        let window = self.create(rect, controller: controller)
        NSApp.mainWindow?.beginSheet(window, completionHandler: handler)
    }
    /// 下拉弹窗关闭
    static func endSheet(with controller: NSViewController, response: NSApplication.ModalResponse) {
        guard let window = controller.view.window else { return }
        NSApp.mainWindow?.endSheet(window, returnCode: response)
    }
}

