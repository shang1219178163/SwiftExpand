//
//  NSDate+Helper.swift
//  SwiftTemplet
//
//  Created by dev on 2018/12/11.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension NSDate{
    
    public func hourInfoBetween(_ date: NSDate,_ type: Int) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        switch type {
            case 1://分钟
                diff = fabs(diff/60)

            case 2://小时
                diff = fabs(diff/3600)

            case 3://天
                diff = fabs(diff/86400)

            default://秒
                diff = fabs(diff)
        }
        return diff;
    }
    
    public func daysInBetween(_ date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/86400)
        return diff
    }
    
    public func hoursInBetween(_ date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/3600)
        return diff
    }
    
    public func minutesInBetween(_ date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff/60)
        return diff
    }
    
    public func secondsInBetween(_ date: NSDate) -> Double {
        var diff = self.timeIntervalSinceNow - date.timeIntervalSinceNow
        diff = fabs(diff)
        return diff
    }
    
    
}
