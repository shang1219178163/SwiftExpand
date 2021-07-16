//
//  NSWindow+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSWindow {
    ///便利方法
    convenience init(vc: NSViewController?, size: CGSize = NSWindow.defaultSize) {
        let style: NSWindow.StyleMask = [.titled, .closable, .miniaturizable, .resizable]
        self.init(contentRect: CGRect(origin: .zero, size: size), styleMask: style, backing: .buffered, defer: false)
//        self.contentMinSize = CGSize(width: rect.width * minSizeScale, height: rect.height * minSizeScale)
        self.contentViewController = vc
        self.titlebarAppearsTransparent = true
        self.center()
    }


    /// 默认大小
    static var defaultSize: CGSize {
        return CGSize(width: kScreenWidth*0.5, height: kScreenHeight*0.5)
    }
}

