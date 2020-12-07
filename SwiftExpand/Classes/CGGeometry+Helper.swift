//
//  CGGeometry+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

public extension CGRect{
    ///中心点
    var center: CGPoint {
        get {
            let centerX = origin.x + (size.width / 2)
            let centerY = origin.y + (size.height / 2)
            return CGPoint(x: centerX, y: centerY)
        }
        set{
            //`newValue`便是所赋新值的点,系统的默认值
            origin.x = newValue.x - (size.width / 2)
            origin.y = newValue.y - (size.height / 2)
        }
    }
    
    /// 便利方法
    init(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) {
        self.init(x: x, y: y, width: w, height: h)
    }
    
    init(center: CGPoint, size: CGSize) {
        let originX = center.x - (size.width / 2)
        let originY = center.y - (size.height / 2)
        self.init(origin: CGPoint(x: originX, y: originY), size: size)
    }
    /// 仿OC方法
    static func make(_ x: CGFloat, _ y: CGFloat, _ w: CGFloat, _ h: CGFloat) -> CGRect{
        return self.init(x: x, y: y, width: w, height: h)
    }
    
    var pointLeftTop: CGPoint {
        return CGPoint(x: minX, y: minY)
    }
    
    var pointLeftBtm: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var pointRightTop: CGPoint {
        return CGPoint(x: maxY, y: minX)
    }
    
    var pointRightBtm: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

}

public extension CGPoint{
    /// 便利方法
    init(_ x: CGFloat = 0, _ y: CGFloat = 0) {
        self.init(x: x, y: y)
    }
    
    /// 仿OC方法
    static func make(_ x: CGFloat = 0, _ y: CGFloat = 0) -> Self{
        return Self(x: x, y: y)
    }

    static func distance(from point1: CGPoint, to point2: CGPoint) -> CGFloat {
        // http://stackoverflow.com/questions/6416101/calculate-the-distance-between-two-cgpoints
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
    
}

public extension CGSize{
    /// 便利方法
    init(_ w: CGFloat = 0, _ h: CGFloat = 0) {
        self.init(width: w, height: h)
    }
    
    /// 仿OC方法
    static func make(_ w: CGFloat = 0, _ h: CGFloat = 0) -> Self{
        return Self(width: w, height: h)
    }

    
    ///Add two CGSize
    /// - Parameters:
    ///   - lhs: CGSize to add to.
    ///   - rhs: CGSize to add.
    /// - Returns: The result comes from the addition of the two given CGSize struct.
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }
    
    /// Add a CGSize to self.
    /// - Parameters:
    ///   - lhs: self
    ///   - rhs: CGSize to add.
    static func += (lhs: inout CGSize, rhs: CGSize) -> CGSize {
        lhs.width += rhs.width
        lhs.height += rhs.height
        return lhs
    }
}

public extension UIOffset{
    /// 便利方法
    init(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) {
        self.init(horizontal: horizontal, vertical: vertical)
    }
    
    /// 仿OC方法
    static func make(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> Self{
        return Self(horizontal: horizontal, vertical: vertical)
    }

    ///Add two UIOffset
    /// - Parameters:
    ///   - lhs: UIOffset to add to.
    ///   - rhs: UIOffset to add.
    /// - Returns: The result comes from the addition of the two given UIOffset struct.
    static func + (lhs: UIOffset, rhs: UIOffset) -> UIOffset {
        return UIOffset(horizontal: lhs.horizontal + rhs.vertical, vertical: lhs.horizontal + rhs.vertical)
    }
}


public extension UIEdgeInsets{
    
    var vertical: CGFloat {
        return top + bottom
    }

    var horizontal: CGFloat {
        return left + right
    }

    /// 便利方法
    init(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    /// 仿OC方法
    static func make(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self{
        return Self(top: top, left: left, bottom: bottom, right: right)
    }
    ///Add two UIEdgeInsets
    static func + (_ lhs: UIEdgeInsets, _ rhs: UIEdgeInsets) -> UIEdgeInsets {
        return UIEdgeInsets(top: lhs.top + rhs.top,
                            left: lhs.left + rhs.left,
                            bottom: lhs.bottom + rhs.bottom,
                            right: lhs.right + rhs.right)
    }
}


