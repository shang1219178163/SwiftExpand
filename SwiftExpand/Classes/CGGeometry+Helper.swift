//
//  CGGeometry+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


public extension Bool {
    /// Return 1 if true, or 0 if false.
    var int: Int {
        return self ? 1 : 0
    }

    /// Return "true" if true, or "false" if false.
    var string: String {
        return self ? "true" : "false"
    }
}


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

    /// Float.
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

    /// Double.
    var double: Double { return Double(self) }

    var cgFloat: CGFloat { return CGFloat(self) }
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

    
    /// Add two CGSize.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     let result = sizeA + sizeB
    ///     // result = CGSize(width: 8, height: 14)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to add to.
    ///   - rhs: CGSize to add.
    /// - Returns: The result comes from the addition of the two given CGSize struct.
    static func + (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width + rhs.width, height: lhs.height + rhs.height)
    }

    /// Add a tuple to CGSize.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let result = sizeA + (5, 4)
    ///     // result = CGSize(width: 10, height: 14)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to add to.
    ///   - tuple: tuple value.
    /// - Returns: The result comes from the addition of the given CGSize and tuple.
    static func + (lhs: CGSize, tuple: (width: CGFloat, height: CGFloat)) -> CGSize {
        return CGSize(width: lhs.width + tuple.width, height: lhs.height + tuple.height)
    }

    /// Add a CGSize to self.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     sizeA += sizeB
    ///     // sizeA = CGPoint(width: 8, height: 14)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - rhs: CGSize to add.
    static func += (lhs: inout CGSize, rhs: CGSize) {
        lhs.width += rhs.width
        lhs.height += rhs.height
    }

    /// Add a tuple to self.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     sizeA += (3, 4)
    ///     // result = CGSize(width: 8, height: 14)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - tuple: tuple value.
    static func += (lhs: inout CGSize, tuple: (width: CGFloat, height: CGFloat)) {
        lhs.width += tuple.width
        lhs.height += tuple.height
    }

    /// Subtract two CGSize.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     let result = sizeA - sizeB
    ///     // result = CGSize(width: 2, height: 6)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to subtract from.
    ///   - rhs: CGSize to subtract.
    /// - Returns: The result comes from the subtract of the two given CGSize struct.
    static func - (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width - rhs.width, height: lhs.height - rhs.height)
    }

    /// Subtract a tuple from CGSize.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let result = sizeA - (3, 2)
    ///     // result = CGSize(width: 2, height: 8)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to subtract from.
    ///   - tuple: tuple value.
    /// - Returns: The result comes from the subtract of the given CGSize and tuple.
    static func - (lhs: CGSize, tuple: (width: CGFloat, heoght: CGFloat)) -> CGSize {
        return CGSize(width: lhs.width - tuple.width, height: lhs.height - tuple.heoght)
    }

    /// Subtract a CGSize from self.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     sizeA -= sizeB
    ///     // sizeA = CGPoint(width: 2, height: 6)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - rhs: CGSize to subtract.
    static func -= (lhs: inout CGSize, rhs: CGSize) {
        lhs.width -= rhs.width
        lhs.height -= rhs.height
    }

    /// Subtract a tuple from self.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     sizeA -= (2, 4)
    ///     // result = CGSize(width: 3, height: 6)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - tuple: tuple value.
    static func -= (lhs: inout CGSize, tuple: (width: CGFloat, height: CGFloat)) {
        lhs.width -= tuple.width
        lhs.height -= tuple.height
    }

    /// Multiply two CGSize.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     let result = sizeA * sizeB
    ///     // result = CGSize(width: 15, height: 40)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to multiply.
    ///   - rhs: CGSize to multiply with.
    /// - Returns: The result comes from the multiplication of the two given CGSize structs.
    static func * (lhs: CGSize, rhs: CGSize) -> CGSize {
        return CGSize(width: lhs.width * rhs.width, height: lhs.height * rhs.height)
    }

    /// Multiply a CGSize with a scalar.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let result = sizeA * 5
    ///     // result = CGSize(width: 25, height: 50)
    ///
    /// - Parameters:
    ///   - lhs: CGSize to multiply.
    ///   - scalar: scalar value.
    /// - Returns: The result comes from the multiplication of the given CGSize and scalar.
    static func * (lhs: CGSize, scalar: CGFloat) -> CGSize {
        return CGSize(width: lhs.width * scalar, height: lhs.height * scalar)
    }

    /// Multiply a CGSize with a scalar.
    ///
    ///     let sizeA = CGSize(width: 5, height: 10)
    ///     let result = 5 * sizeA
    ///     // result = CGSize(width: 25, height: 50)
    ///
    /// - Parameters:
    ///   - scalar: scalar value.
    ///   - rhs: CGSize to multiply.
    /// - Returns: The result comes from the multiplication of the given scalar and CGSize.
    static func * (scalar: CGFloat, rhs: CGSize) -> CGSize {
        return CGSize(width: scalar * rhs.width, height: scalar * rhs.height)
    }

    /// Multiply self with a CGSize.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     let sizeB = CGSize(width: 3, height: 4)
    ///     sizeA *= sizeB
    ///     // result = CGSize(width: 15, height: 40)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - rhs: CGSize to multiply.
    static func *= (lhs: inout CGSize, rhs: CGSize) {
        lhs.width *= rhs.width
        lhs.height *= rhs.height
    }

    /// Multiply self with a scalar.
    ///
    ///     var sizeA = CGSize(width: 5, height: 10)
    ///     sizeA *= 3
    ///     // result = CGSize(width: 15, height: 30)
    ///
    /// - Parameters:
    ///   - lhs: `self`.
    ///   - scalar: scalar value.
    static func *= (lhs: inout CGSize, scalar: CGFloat) {
        lhs.width *= scalar
        lhs.height *= scalar
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


public extension CGVector {
    /// The angle of rotation (in radians) of the vector. The range of the angle is -π to π; an angle of 0 points to the right.
    ///
    /// https://en.wikipedia.org/wiki/Atan2
    var angle: CGFloat {
        return atan2(dy, dx)
    }

    /// The magnitude (or length) of the vector.
    ///
    /// https://en.wikipedia.org/wiki/Euclidean_vector#Length
    var magnitude: CGFloat {
        return sqrt((dx * dx) + (dy * dy))
    }
}

// MARK: - Initializers

public extension CGVector {
    /// Creates a vector with the given magnitude and angle.
    ///
    ///     let vector = CGVector(angle: .pi, magnitude: 1)
    ///
    /// - Parameters:
    ///     - angle: The angle of rotation (in radians) counterclockwise from the positive x-axis.
    ///     - magnitude: The length of the vector.
    ///
    init(angle: CGFloat, magnitude: CGFloat) {
        // https://www.grc.nasa.gov/WWW/K-12/airplane/vectpart.html
        self.init(dx: magnitude * cos(angle), dy: magnitude * sin(angle))
    }

    /// Multiplies a scalar and a vector (commutative).
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let largerVector = vector * 2
    ///
    /// - Parameters:
    ///   - vector: The vector to be multiplied.
    ///   - scalar: The scale by which the vector will be multiplied.
    /// - Returns: The vector with its magnitude scaled.
    static func * (vector: CGVector, scalar: CGFloat) -> CGVector {
        return CGVector(dx: vector.dx * scalar, dy: vector.dy * scalar)
    }

    /// Multiplies a scalar and a vector (commutative).
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let largerVector = 2 * vector
    ///
    /// - Parameters:
    ///   - scalar: The scalar by which the vector will be multiplied.
    ///   - vector: The vector to be multiplied.
    /// - Returns: The vector with its magnitude scaled.
    static func * (scalar: CGFloat, vector: CGVector) -> CGVector {
        return CGVector(dx: scalar * vector.dx, dy: scalar * vector.dy)
    }

    /// Compound assignment operator for vector-scalar multiplication.
    ///
    ///     var vector = CGVector(dx: 1, dy: 1)
    ///     vector *= 2
    ///
    /// - Parameters:
    ///   - vector: The vector to be multiplied.
    ///   - scalar: The scale by which the vector will be multiplied.
    static func *= (vector: inout CGVector, scalar: CGFloat) {
        vector.dx *= scalar
        vector.dy *= scalar
    }

    /// Negates the vector. The direction is reversed, but magnitude remains the same.
    ///
    ///     let vector = CGVector(dx: 1, dy: 1)
    ///     let reversedVector = -vector
    ///
    /// - Parameter vector: The vector to be negated.
    /// - Returns: The negated vector.
    static prefix func - (vector: CGVector) -> CGVector {
        return CGVector(dx: -vector.dx, dy: -vector.dy)
    }
}
