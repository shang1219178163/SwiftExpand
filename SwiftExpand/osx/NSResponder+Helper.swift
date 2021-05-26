//
//  NSResponder+Helper.swift
//  Swift-NSToolBar
//
//  Created by Bin Shang on 2020/3/31.
//  Copyright © 2020 Knowstack. All rights reserved.
//

import Cocoa

public extension NSResponder {
    /// 鼠标状态
    @objc enum MouseState: Int {
        case down = 0
        case up = 1
        case entered = 2
        case exited = 3
    }
}
