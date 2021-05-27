
//
//  NSPopover+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSPopover {

    // MARK: -funtions
    ///遍历方法
    convenience init(vc: NSViewController) {
        self.init()
        self.appearance = NSAppearance(named: .vibrantLight)
        self.behavior = .transient
        self.contentViewController = vc;
        /**
         applicationDefined : 默认值,不会自动关闭popover,ESC键也不能关闭,应用关闭时,popovoer会关闭
         semitransient: 点击popover以外的界面部分,不会自动关闭,但ESC按键可以关闭popover
         transient:  点击popvoer界面以外的部分,popover会自动关闭,ESC键可以关闭popover
         */
        self.behavior = .transient
        
        // 4. 显示popover
        /**
         relativeTo : 类型NSRect 显示popover时,相对的那个区域,也就是popover的三角箭头会指向的矩形边界
         of:  NSView类型, 用来说明第一个参数(矩形范围)是属于那个控件的.
         preferredEdge : 枚举类型,用来说明矩形四条边的那一条边界
         */
//        self.show(relativeTo: view.bounds, of: view, preferredEdge: .maxX)
    }
    
    func show(_ view: NSView, preferredEdge: NSRectEdge) {
        if isShown == true {
            close()
        }
        show(relativeTo: view.bounds, of: view, preferredEdge: preferredEdge)
    }
}
