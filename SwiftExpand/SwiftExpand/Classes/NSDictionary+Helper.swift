//
//  NSDictionary+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/4.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


public extension Dictionary{
    

}

public extension Dictionary where Key == String, Value == String {
    /// 键值翻转
    var reversed: [String : String] {
        var dic: [String : String] = [:]
        for (key, value) in self {
            dic[value] = key
        }
        return dic;
    }
}

@objc public extension NSDictionary{
    /// 键值翻转
    var reversed: [String : String] {
        return (self as! Dictionary).reversed
    }
    
}
