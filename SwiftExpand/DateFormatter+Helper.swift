
//
//  NSDateFormatter+Helper.swift
//  SwiftTemplet
//
//  Created by hsf on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

public let kDate_minute : Double = 60 ;
public let kDate_hour : Double  = 3600 ;
public let kDate_day : Double   = 86400 ;
public let kDate_week : Double   = 604800 ;
public let kDate_year : Double   = 31556926 ;

public let kDateFormat = "yyyy-MM-dd HH:mm:ss";
public let kDateFormat_one = "yyyy-MM-dd";
public let kDateFormat_two = "yyyyMMdd";
public let kDateFormat_three = "yyyy-MM-dd HH:mm";

public extension DateFormatter{
    
    public static func format(_ formatStr:String) -> DateFormatter {
        
        let dic = Thread.current.threadDictionary;
        if dic.object(forKey: formatStr) != nil {
            return dic.object(forKey: formatStr) as! DateFormatter;
        }

        let fmt = DateFormatter();
        fmt.dateFormat = formatStr;
        fmt.locale = .current;
        fmt.timeZone = NSTimeZone.local;
        dic.setObject(fmt, forKey: formatStr as NSCopying)
        return fmt;
    }
    
    public static func format(_ date:Date, fmt:String) -> String {
        let formatter = DateFormatter.format(fmt);
        return formatter.string(from: date);
    }
    
    public static func format(dateStr:String, fmt:String) -> Date? {
        let fmt = DateFormatter.format(fmt);
        return fmt.date(from: dateStr);
    }
    
    public static func format(_ interval:TimeInterval, fmt:String) -> String? {
        let timeInterval: TimeInterval = TimeInterval(interval)
        let date = Date(timeIntervalSince1970: timeInterval)
        return DateFormatter.format(date, fmt: fmt);
    }
    
    public static func format(_ interval:String, fmt:String) -> String? {
        return DateFormatter.format(interval.doubleValue(), fmt: fmt);
    }
}
