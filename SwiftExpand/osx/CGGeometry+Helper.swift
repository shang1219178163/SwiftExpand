
//
//  CGRect+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/7.
//  Copyright © 2018年 BN. All rights reserved.
//

import Cocoa

/// 自定义NSEdgeInsets
public func NSEdgeInsetsMake(_ top: CGFloat = 0, _ left: CGFloat = 0, _ bottom: CGFloat = 0, _ right: CGFloat = 0) -> NSEdgeInsets{
    return NSEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

/// 自定义CGRect
public func CGRectMake(_ x: CGFloat = 0, _ y: CGFloat = 0, _ w: CGFloat = 0, _ h: CGFloat = 0) -> CGRect{
    return CGRect(x: x, y: y, width: w, height: h)
}

/// 自定义CGPointMake
public func CGPointMake(_ x: CGFloat = 0, _ y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: x, y: y)
}

/// 自定义GGSizeMake
public func GGSizeMake(_ w: CGFloat = 0, _ h: CGFloat = 0) -> CGSize {
    return CGSize(width: w, height: h)
}


public extension Int{
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
}

public extension Double{
    
    /// 转为String类型
    var toString: String { return NSNumber(floatLiteral: self).stringValue; }
    /// 转为NSNumber类型
    var toNSNumber: NSNumber { return NSNumber(floatLiteral: self); }
    
    /// 保留n为小数
    func roundedTo(_ n: Int) -> Double {
        let format = NumberFormatter()
        format.numberStyle = NumberFormatter.Style.decimal
        format.multiplier = 2
        format.roundingMode = .up
        format.maximumFractionDigits = n
        format.number(from: format.string(for: self )! )
        
        return (format.number(from: format.string(for: self )! )) as! Double
    }
    
    /// durationInfo
    func durationInfo(_ type: Int = 0, showAll: Bool = true) -> String {
        var interval = self
        
        var info = ""
        switch type {
        case 1:
            
            if Int(interval/kDateDay) < 10 {
                info += "0\(Int(interval/kDateDay))" + ":"
            } else {
                info += "\(Int(interval/kDateDay))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDateDay);
            
            if Int(interval/kDateHour) < 10 {
                info += "0\(Int(interval/kDateHour))" + ":"
            } else {
                info += "\(Int(interval/kDateHour))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDateHour);
            
            if Int(interval/kDateMinute) < 10 {
                info += "0\(Int(interval/kDateMinute))" + ":"
            } else {
                info += "\(Int(interval/kDateMinute))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDateMinute);
            
            if interval < 10 {
                info += "0\(Int(interval))"
            } else {
                info += "\(Int(interval))"
            }
            
        default:
            
            if showAll == true {
                info = "\(Int(interval/kDateDay))" + "天"
                interval = interval.truncatingRemainder(dividingBy: kDateDay);
                
                info += "\(Int(interval/kDateHour))" + "时"
                interval = interval.truncatingRemainder(dividingBy: kDateHour);
                
                info += "\(Int(interval/kDateMinute))" + "分"
                interval = interval.truncatingRemainder(dividingBy: kDateMinute);
                
                info += "\(Int(interval))" + "秒"
            } else {
                
                if Int(interval/kDateDay) > 0 {
                    info = "\(Int(interval/kDateDay))" + "天"
                }
                interval = interval.truncatingRemainder(dividingBy: kDateDay);
                
                if Int(interval/kDateHour) > 0 {
                    info += "\(Int(interval/kDateHour))" + "时"
                }
                interval = interval.truncatingRemainder(dividingBy: kDateHour);
                
                if Int(interval/kDateMinute) > 0 {
                    info += "\(Int(interval/kDateMinute))" + "分"
                }
                interval = interval.truncatingRemainder(dividingBy: kDateMinute);
                info += "\(Int(interval))" + "秒"
            }
        }
        return info;
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

public extension NSEdgeInsets{
    /// 便利方法
    init(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) {
        self.init(top: top, left: left, bottom: bottom, right: right)
    }
    
    /// 仿OC方法
    static func make(_ top: CGFloat, _ left: CGFloat, _ bottom: CGFloat, _ right: CGFloat) -> Self{
        return Self(top: top, left: left, bottom: bottom, right: right)
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

}
