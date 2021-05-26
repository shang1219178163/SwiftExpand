//
//  NSScreen+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension NSScreen {
    
    static var sizeWidth: CGFloat {
        return NSScreen.main!.frame.size.width
    }
    
    static var sizeHeight: CGFloat {
        return NSScreen.main!.frame.size.height
    }
    
}
