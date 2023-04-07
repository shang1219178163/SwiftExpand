//
//  CGGeometry+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Foundation

///// 自定义EdgeInsets
//public func UIEdgeInsets(_ top: CGFloat = 0, _ left: CGFloat = 0, _ bottom: CGFloat = 0, _ right: CGFloat = 0) -> EdgeInsets{
//    return EdgeInsets(top: top, left: left, bottom: bottom, right: right)
//}
//
///// 自定义CGRect
//public func CGRectMake(_ x: CGFloat = 0, _ y: CGFloat = 0, _ w: CGFloat = 0, _ h: CGFloat = 0) -> CGRect{
//    return CGRect(x: x, y: y, width: w, height: h)
//}
//
///// 自定义CGPointMake
//public func CGPointMake(_ x: CGFloat = 0, _ y: CGFloat = 0) -> CGPoint {
//    return CGPoint(x: x, y: y)
//}
//
///// 自定义GGSizeMake
//public func GGSizeMake(_ w: CGFloat = 0, _ h: CGFloat = 0) -> CGSize {
//    return CGSize(width: w, height: h)
//}

///角度转弧度
 public func CGRadianFromDegrees(_ value: CGFloat) -> CGFloat{
    return (CGFloat(Double.pi) * (value) / 180.0);
}
///弧度转角度
public func CGDegreesFromRadian(_ value: CGFloat) -> CGFloat{
    return (value * 180.0)/CGFloat((Double.pi));
}

/// 自定义两点之间距离
public func CGDistance(_ pointA: CGPoint, pointB: CGPoint) -> CGFloat {
    let result = sqrt(pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2))
    return result
}


public extension Bool {
    /// Return 1 if true, or 0 if false.
    var intValue: Int {
        return self ? 1 : 0
    }

    /// Return "true" if true, or "false" if false.
    func toString() -> String {
        return self ? "true" : "false"
    }
}


public extension Int {
    
    static var randomCGFloat: CGFloat {
        return CGFloat(arc4random()) / CGFloat(UInt32.max)
    }
    
    static var random: Int {
        return Int(arc4random()) / Int(UInt32.max)
    }
    /// 转为Double类型
    var doubleValue: Double  { return Double(self) }
    /// 转为Float类型
    var floatValue: Float    { return Float(self) }
    // 转为CGFloat类型
    var cgFloatValue: CGFloat { return CGFloat(self) }
    /// 转为 NSNumber
    var numberValue: NSNumber { return NSNumber(integerLiteral: self); }
    
    /// 偶数
    var isEven: Bool     {  return (self % 2 == 0)  }
    /// 奇数
    var isOdd: Bool      {  return (self % 2 != 0)  }
    /// 大于0
    var isPositive: Bool {  return (self > 0)   }
    /// 小于0
    var isNegative: Bool {  return (self < 0)   }

    /// 转为String类型
    func toString() -> String {
        return NSNumber(integerLiteral: self).stringValue;
    }
    
    var digits: Int {
        if (self == 0) {
            return 1
        }
//        if(Int(fabs(Double(self))) <= LONG_MAX){
        return Int(log10(fabs(Double(self)))) + 1
//        }
    }


//    ///返回重复值字符串
//    func repeatString(_ repeatedValue: String) ->String {
//        return String(repeating: repeatedValue, count: self)
//    }
//    ///返回重复值数组
//    func repeatArray<T>(_ repeatedValue: T) -> [T] {
//        return [T](repeating: repeatedValue, count: self)
//    }

    /// 超出取边界值
    func clamp(lowerLimit: Int, upperLimit: Int) -> Int {
        if self < lowerLimit {
            return lowerLimit
        }

        if self > upperLimit {
            return upperLimit
        }
        return self
    }
    
    /// 乘法表打印
    func printChengfaBiao() {
        assert(self > 0)
        var result = ""
        for i in 1...self {
            for j in 1...i {
                result = "\(result)\t\(j) * \(i) = \(j * i)"
            }
            print(result)
            result = ""
        }
    }
}

public extension Double {
    /// 转为 int
    var intValue: Int { return Int(self) }
    /// 转为 Float
    var floatValue: Float { return Float(self) }
    /// 转为 CGFloat
    var cgFloatValue: CGFloat { return CGFloat(self) }
    /// 转为 NSNumber
    var numberValue: NSNumber { return NSNumber(floatLiteral: self); }

    /// 转为String类型
    func toString() -> String { return NSNumber(floatLiteral: self).stringValue; }
    
    /// 保留n为小数
    func roundedTo(_ n: Int) -> Double {
        let divisor = pow(10.0, Double(n))
        let result = (self * divisor).rounded() / divisor
        return result
    }
    /// 超出取边界值
    func clamp(lowerLimit: Double, upperLimit: Double) -> Double {
        if self < lowerLimit {
            return lowerLimit
        }

        if self > upperLimit {
            return upperLimit
        }
        return self
    }

}

public extension Float {
    /// 转为 int
    var intValue: Int { return Int(self) }
    /// 转为Double类型
    var doubleValue: Double { return Double(self) }
    /// 转为 CGFloat
    var cgFloatValue: CGFloat { return CGFloat(self) }
}

public extension CGFloat {

    var abs: CGFloat {
        return Swift.abs(self)
    }
    /// Radian value of degree input.
    var degreesToRadians: CGFloat {
        return .pi * self / 180.0
    }
    
    /// Degree value of radian input.
    var radiansToDegrees: CGFloat {
        return self * 180 / CGFloat.pi
    }
    
    var floor: CGFloat {
        return Foundation.floor(self)
    }
    
    var ceil: CGFloat {
        return Foundation.ceil(self)
    }
    
    func toString(_ fractionDigits: Int = 2) -> String {
        return String.init(format: "%.\(fractionDigits)f", self)
    }
    
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
    
    var leftTop: CGPoint {
        return CGPoint(x: minX, y: minY)
    }
    
    var leftBtm: CGPoint {
        return CGPoint(x: minX, y: maxY)
    }
    
    var rightTop: CGPoint {
        return CGPoint(x: maxY, y: minX)
    }
    
    var rightBtm: CGPoint {
        return CGPoint(x: maxX, y: maxY)
    }

    func toString(_ fractionDigits: Int = 2) -> String {
        let xString = String.init(format: "%.\(fractionDigits)f", origin.x)
        let yString = String.init(format: "%.\(fractionDigits)f", origin.y)
        let wString = String.init(format: "%.\(fractionDigits)f", size.width)
        let hString = String.init(format: "%.\(fractionDigits)f", size.height)
        return "(\(xString), \(yString), \(wString), \(hString))"
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
        return sqrt(pow(point2.x - point1.x, 2) + pow(point2.y - point1.y, 2))
    }
    
    /// Add two CGPoints.
    ///     let point = point1 + point2
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }

    /// Add a CGPoints to self.
    ///     point1 += point2
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x += rhs.x
        lhs.y += rhs.y
    }

    /// Subtract two CGPoints.
    ///     let point = point1 - point2
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }

    /// Subtract a CGPoints from self.
    ///     point1 -= point2
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs.x -= rhs.x
        lhs.y -= rhs.y
    }

    /// Multiply a CGPoint with a scalar.
    ///     let scalar = point1 * 5
    static func * (point: CGPoint, scalar: CGFloat) -> CGPoint {
        return CGPoint(x: point.x * scalar, y: point.y * scalar)
    }

    /// Multiply self with a scalar.
    ///     point *= 5
    static func *= (point: inout CGPoint, scalar: CGFloat) {
        point.x *= scalar
        point.y *= scalar
    }
    
    
    func toString(_ fractionDigits: Int = 2) -> String {
        let xString = String.init(format: "%.\(fractionDigits)f", x)
        let yString = String.init(format: "%.\(fractionDigits)f", y)
        return "(\(xString), \(yString))"
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

    
    /// Add two CGSize.
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    /// Add a CGSize to self.
    static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }

    /// Subtract two CGSize.
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    /// Subtract a CGSize from self.
    static func -= (lhs: inout CGSize, rhs: CGSize) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }

    /// Multiply two CGSize.
    static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    /// Multiply a CGSize with a scalar.
    ///     let result = sizeA * 5
    static func * (lhs: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * scalar, height: lhs.height * scalar)
    }


    /// Multiply self with a CGSize.
    ///     sizeA *= sizeB
    static func *= (lhs: inout CGSize, rhs: CGSize) {
        lhs.width *= rhs.width
        lhs.height *= rhs.height
    }

    /// Multiply self with a scalar.
    ///     sizeA *= 3
    static func *= (lhs: inout CGSize, scalar: CGFloat) {
        lhs.width *= scalar
        lhs.height *= scalar
    }
    
    
    func toString(_ fractionDigits: Int = 2) -> String {
        let wString = String.init(format: "%.\(fractionDigits)f", width)
        let hString = String.init(format: "%.\(fractionDigits)f", height)
        return "(\(wString), \(hString))"
    }
}


public extension EdgeInsets{
    
    /// 便利方法
    init(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    init(all: CGFloat) {
        self.init(top: all, left: all, bottom: all, right: all)
    }
    /// 仿OC方法
    static func make(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self {
        return Self(top: top, left: left, bottom: bottom, right: right)
    }
    
    /// 对称声明
    static func symmetric(_ vertical: CGFloat, _ horizontal: CGFloat) -> Self {
        return Self(top: vertical, left: horizontal, bottom: vertical, right: horizontal)
    }

    
    ///Add two EdgeInsets
    static func + (_ lhs: EdgeInsets, _ rhs: EdgeInsets) -> EdgeInsets {
        return EdgeInsets(top: lhs.top + rhs.top,
                          left: lhs.left + rhs.left,
                          bottom: lhs.bottom + rhs.bottom,
                          right: lhs.right + rhs.right)
    }
    
    
    func toString(_ fractionDigits: Int = 2) -> String {
        let topString = String.init(format: "%.\(fractionDigits)f", top)
        let leftString = String.init(format: "%.\(fractionDigits)f", self.left)
        let bottomString = String.init(format: "%.\(fractionDigits)f", bottom)
        let rightString = String.init(format: "%.\(fractionDigits)f", self.right)
        return "(\(topString), \(leftString), \(bottomString), \(rightString))"
    }
}


public extension CGVector {
    /// The angle of rotation (in radians) of the vector. The range of the angle is -π to π; an angle of 0 points to the right.
    var angle: CGFloat {
        return atan2(dy, dx)
    }

    /// The magnitude (or length) of the vector.
    var magnitude: CGFloat {
        return sqrt((dx * dx) + (dy * dy))
    }
}

// MARK: - Initializers

public extension CGVector {
    /// Creates a vector with the given magnitude and angle.
    ///     let vector = CGVector(angle: .pi, magnitude: 1)
    init(angle: CGFloat, magnitude: CGFloat) {
        // https://www.grc.nasa.gov/WWW/K-12/airplane/vectpart.html
        self.init(dx: magnitude * cos(angle), dy: magnitude * sin(angle))
    }

    /// Multiplies a scalar and a vector (commutative).
    ///     let largerVector = vector * 2
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    /// Compound assignment operator for vector-scalar multiplication.
    ///     vector *= 2
    static func *= (vector: inout CGVector, scalar: CGFloat) {
        vector.dx *= scalar
        vector.dy *= scalar
    }

    /// Negates the vector. The direction is reversed, but magnitude remains the same.
    ///     let reversedVector = -vector
    static prefix func - (vector: CGVector) -> CGVector {
        return CGVector(dx: -vector.dx, dy: -vector.dy)
    }
}


/// 自定义元祖
public struct Tuple5<T0, T1, T2, T3, T4> {
    public let t0: T0
    public let t1: T1
    public let t2: T2
    public let t3: T3
    public let t4: T4

    public init(_ t0: T0, _ t1: T1, _ t2: T2, _ t3: T3, _ t4: T4) {
        self.t0 = t0
        self.t1 = t1
        self.t2 = t2
        self.t3 = t3
        self.t4 = t4
    }
}
