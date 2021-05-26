//
//  NSOutlineView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/4/9.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import Cocoa

@objc extension NSOutlineView {

    /// expand/Collapse
    public func expandOrCollapseItem(item: Any?, children: Bool = true) {
        let isItemExpanded = self.isItemExpanded(item)
        let animator = self.animator() as NSOutlineView;

        if isItemExpanded == true {
            animator.collapseItem(item, collapseChildren: children)
        } else {
            animator.expandItem(item, expandChildren: children)
        }
    }
    
}
