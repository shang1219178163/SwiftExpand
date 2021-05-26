//
//  NSStatusItem+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension NSStatusItem {


    // MARK: -funtions
    static func create(imageName: String?) -> NSStatusItem {
        var image = NSApplication.appIcon.resize(CGSize(width: 40, height: 30), isPixels: true);
        if let imageName = imageName, let newImage = NSImage(named: imageName) {
            image = newImage
        }
        
        let statusItem: NSStatusItem = {
            let item = NSStatusBar.system.statusItem(withLength: -2)
            item.button?.cell?.isHighlighted = false;
            item.button?.image = image;
            item.button?.toolTip = NSApplication.appName;
            
            return item;
        }()
        return statusItem;
    }
}

