//
//  NSDictionary+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/4.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


public extension Dictionary{
    
    /// ->Data
    var jsonData: Data? {
        return (self as NSDictionary).jsonData;
    }
    
    /// ->NSString
    var jsonString: String {
        return (self as NSDictionary).jsonString;
    }
    
    
    var plistData: Data?{
        return (self as NSDictionary).plistData;
    }
    
    func dictionaryFromPlistData(_ plistData: Data) -> Any? {
        return (self as NSDictionary).dictionaryFromPlistData(plistData);
    }
}

public extension Dictionary where Key == String, Value == String {
    /// 键值翻转
    var reversed: [String : String] {
        var dic = [String : String]()
        for (key, value) in self {
            dic[value] = key
        }
        return dic;
    }
    ///根据键数值排序
    func valuesByKeySorted() -> [String] {
        let values = keys.sorted {
            return $0.intValue < $1.intValue
        }.map { self[$0] ?? ""}
        return values
    }
}

@objc public extension NSDictionary{
//    /// 键值翻转
//    var reversed: [String : String] {
//        return (self as! Dictionary).reversed
//    }
//    
    /// ->Data
    var jsonData: Data? {
        var data: Data?
        do {
            data = try JSONSerialization.data(withJSONObject: self, options: []);
        } catch {
            print(error)
        }
        return data;
    }
    
    /// ->NSString
    var jsonString: String {
        guard let jsonData = self.jsonData as Data?,
        let jsonString = String(data: jsonData, encoding: .utf8) as String?
        else { return "" }
        return jsonString
    }
    
//    var valuesByKeySorted: [Any] {
//        let marr = NSMutableArray()
//        let list = (self.allKeys as [NSString]).sorted(by: >)
//
//        for key in list {
//            marr.add(self[key])
//        }
//        return marr.copy() as! [Any]
//    }
    
    var plistData: Data?{
        let result = try? PropertyListSerialization.data(fromPropertyList: self, format: .binary, options: 0)
        return result
    }
    
    func dictionaryFromPlistData(_ plistData: Data) -> Any? {
        let result = try? PropertyListSerialization.propertyList(from: plistData, options: [], format: nil)
        return result
    }
    
    
}
