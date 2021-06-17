//
//  NSWindow+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSWindow {
    ///便利方法
    convenience init(vc: NSViewController?, rect: CGRect = NSWindow.defaultRect) {
        let style: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable]
        self.init(contentRect: rect, styleMask: style, backing: .buffered, defer: false)
//        self.contentMinSize = CGSize(width: rect.width * minSizeScale, height: rect.height * minSizeScale)
        self.contentViewController = vc;
        self.titlebarAppearsTransparent = true
        self.center()
    }

    // MARK: -funtions
    /// 默认大小
    static var defaultRect: CGRect {
        return CGRectMake(0, 0, kScreenWidth*0.5, kScreenHeight*0.5)
    }
    
    /// 打开弹窗
    static func showSheet(with controller: NSViewController, size: CGSize, handler: ((NSApplication.ModalResponse) -> Void)? = nil) {
        controller.preferredContentSize = size
        let rect = CGRectMake(0, 0, size.width, size.height)
        let window = NSWindow(vc: controller, rect: rect)
        NSApp.mainWindow?.beginSheet(window, completionHandler: handler)
    }
    /// 关闭弹窗
    static func endSheet(with controller: NSViewController, response: NSApplication.ModalResponse) {
        guard let window = controller.view.window else { return }
        NSApp.mainWindow?.endSheet(window, returnCode: response)
    }
}

