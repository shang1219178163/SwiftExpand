//
//  UISegmentedControl+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

public extension UISegmentedControl{
    
    /// 控件items
    @objc var itemList: Array<String> {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! Array<String>
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            p_handleSegmentItems(newValue);
        }
    }
    
    /// 配置新item数组
    private func p_handleSegmentItems(_ itemList: Array<String>) -> Void{
        if itemList.count == 0 {
            return
        }
        
        removeAllSegments()
        for e in itemList.enumerated() {
            insertSegment(withTitle: e.element, at: e.offset, animated: false)
        }
        selectedSegmentIndex = 0
    }
    
}
