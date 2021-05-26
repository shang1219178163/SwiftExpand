
//
//  NSPopover+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSPopover {

    // MARK: -funtions
    
    static func create(controller: NSViewController) -> Self {
        let popover = self.init()
        popover.appearance = NSAppearance(named: .vibrantLight)
        popover.behavior = .transient
        popover.contentViewController = controller;
        /**
         applicationDefined : 默认值,不会自动关闭popover,ESC键也不能关闭,应用关闭时,popovoer会关闭
         semitransient: 点击popover以外的界面部分,不会自动关闭,但ESC按键可以关闭popover
         transient:  点击popvoer界面以外的部分,popover会自动关闭,ESC键可以关闭popover
         */
        popover.behavior = .transient
        
        // 4. 显示popover
        /**
         relativeTo : 类型NSRect 显示popover时,相对的那个区域,也就是popover的三角箭头会指向的矩形边界
         of:  NSView类型, 用来说明第一个参数(矩形范围)是属于那个控件的.
         preferredEdge : 枚举类型,用来说明矩形四条边的那一条边界
         */
//        popover.show(relativeTo: view.bounds, of: view, preferredEdge: .maxX)
        return popover
    }
    
    func show(_ view: NSView, preferredEdge: NSRectEdge) {
        if isShown == true {
            close()
        }
        show(relativeTo: view.bounds, of: view, preferredEdge: preferredEdge)
    }
}
