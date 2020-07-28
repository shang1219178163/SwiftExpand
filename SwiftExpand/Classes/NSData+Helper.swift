//
//  NSData+Helper.swift
//  CloudCustomerService
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2019 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import UIKit

@objc public extension NSData{
    /// NSData -> 转数组/字典
    var objValue: Any? {
        if JSONSerialization.isValidJSONObject(self) {
           return nil;
        }
        
        do {
            let obj: Any = try JSONSerialization.jsonObject(with: self as Data, options: [])
            return obj;
        } catch {
           print(error)
        }
        return nil;
    }
    /// NSData -> 转字符串
    var stringValue: String {
        if let result = String(data: self as Data, encoding: .utf8) {
            return result
        }
        return ""
    }
}

public extension Data{
    /// 转数组/字典
    var objValue: Any? {
        return (self as NSData).objValue;
    }
    /// NSData -> 转字符串
    var stringValue: String? {
        return (self as NSData).stringValue;

    }
}
