//
//  CGGeometry+Ext.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

///// 自定义GGSizeMake
//public func UIOffsetMake(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> UIOffset {
//    return UIOffset(horizontal: horizontal, vertical: vertical)
//}

public extension UIOffset{
    /// 便利方法
    init(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) {
        self.init(horizontal: horizontal, vertical: vertical)
    }
    
//    /// 仿OC方法
//    static func make(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> Self{
//        return Self(horizontal: horizontal, vertical: vertical)
//    }

    ///Add two UIOffset
    static func + (lhs: UIOffset, rhs: UIOffset) -> UIOffset {
        return UIOffset(horizontal: lhs.horizontal + rhs.vertical, vertical: lhs.horizontal + rhs.vertical)
    }
}
