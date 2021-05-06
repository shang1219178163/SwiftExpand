//
//  CGGeometry+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


public extension Int {

    var double: Double  { return Double(self) }

    var float: Float    { return Float(self) }

    var cgFloat: CGFloat { return CGFloat(self) }
    
    /// 偶数
    var isEven: Bool     {  return (self % 2 == 0)  }
    /// 奇数
    var isOdd: Bool      {  return (self % 2 != 0)  }
    /// 大于0
    var isPositive: Bool {  return (self > 0)   }
    /// 小于0
    var isNegative: Bool {  return (self < 0)   }
    /// 转为Double类型
    var toDouble: Double {  return Double(self) }
    /// 转为Float类型
    var toFloat: Float   {  return Float(self)  }
    /// 转为CGFloat类型
    var toCGFloat: CGFloat   {  return CGFloat(self)  }
    /// 转为String类型
    var toString: String { return NSNumber(integerLiteral: self).stringValue; }
    /// 转为NSNumber类型
    var toNumber: NSNumber { return NSNumber(integerLiteral: self); }
    
    var digits: Int {
        if (self == 0) {
            return 1
        }
//        if(Int(fabs(Double(self))) <= LONG_MAX){
        return Int(log10(fabs(Double(self)))) + 1
//        }
    }
    
    static var randomCGFloat: CGFloat { return CGFloat(arc4random()) / CGFloat(UInt32.max) }
    
    static var random: Int { return Int(arc4random()) / Int(UInt32.max) }

    ///返回重复值字符串
    func repeatString(_ repeatedValue: String) ->String { return String(repeating: repeatedValue, count: self) }
    ///返回重复值数组
    func repeatArray<T>(_ repeatedValue: T) -> [T] { return [T](repeating: repeatedValue, count: self) }
}

public extension Double {
    var int: Int { return Int(self) }

    /// SwifterSwift: Float.
    var float: Float { return Float(self) }

    var cgFloat: CGFloat { return CGFloat(self) }
    
    /// 转为String类型
    var toString: String { return NSNumber(floatLiteral: self).stringValue; }
    /// 转为NSNumber类型
    var toNumber: NSNumber { return NSNumber(floatLiteral: self); }
    
    /// 保留n为小数
    func roundedTo(_ n: Int) -> Double {
        let divisor = pow(10.0, Double(n))
        let result = (self * divisor).rounded() / divisor
        return result
    }
}

public extension Float {

    var int: Int { return Int(self) }

    /// SwifterSwift: Double.
    var double: Double { return Double(self) }

    var cgFloat: CGFloat { return CGFloat(self) }
}


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


