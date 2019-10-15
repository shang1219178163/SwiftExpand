//
//  Int+Helper.swift
//  SwiftTemplet
//
//  Created by dev on 2018/12/11.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension Int{
    var isEven: Bool     {  return (self % 2 == 0)  }
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
            
            if Int(interval/kDate_day) < 10 {
                info += "0\(Int(interval/kDate_day))" + ":"
            } else {
                info += "\(Int(interval/kDate_day))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDate_day);
            
            if Int(interval/kDate_hour) < 10 {
                info += "0\(Int(interval/kDate_hour))" + ":"
            } else {
                info += "\(Int(interval/kDate_hour))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDate_hour);
            
            if Int(interval/kDate_minute) < 10 {
                info += "0\(Int(interval/kDate_minute))" + ":"
            } else {
                info += "\(Int(interval/kDate_minute))" + ":"
            }
            interval = interval.truncatingRemainder(dividingBy: kDate_minute);
            
            if interval < 10 {
                info += "0\(Int(interval))"
            } else {
                info += "\(Int(interval))"
            }
            
        default:
            
            if showAll == true {
                info = "\(Int(interval/kDate_day))" + "天"
                interval = interval.truncatingRemainder(dividingBy: kDate_day);
                
                info += "\(Int(interval/kDate_hour))" + "时"
                interval = interval.truncatingRemainder(dividingBy: kDate_hour);
                
                info += "\(Int(interval/kDate_minute))" + "分"
                interval = interval.truncatingRemainder(dividingBy: kDate_minute);
                
                info += "\(Int(interval))" + "秒"
            } else {
                
                if Int(interval/kDate_day) > 0 {
                    info = "\(Int(interval/kDate_day))" + "天"
                }
                interval = interval.truncatingRemainder(dividingBy: kDate_day);
                
                if Int(interval/kDate_hour) > 0 {
                    info += "\(Int(interval/kDate_hour))" + "时"
                }
                interval = interval.truncatingRemainder(dividingBy: kDate_hour);
                
                if Int(interval/kDate_minute) > 0 {
                    info += "\(Int(interval/kDate_minute))" + "分"
                }
                interval = interval.truncatingRemainder(dividingBy: kDate_minute);
                info += "\(Int(interval))" + "秒"
            }
        }
        return info;
    }
}



