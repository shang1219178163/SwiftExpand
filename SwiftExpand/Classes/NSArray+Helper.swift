
//
//  NSArray+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/6.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension Array{
    
    /// ->Data
    var jsonData: Data? {
        return (self as NSArray).jsonData;
    }
    
    /// ->NSString
    var jsonString: String? {
        return (self as NSArray).jsonString;
    }
    
    func subarray(_ range: NSRange) -> Array {
        return self.subarray(range.location, range.length)
    }
    
    func subarray(_ loc: Int, _ len: Int) -> Array {
        assert(loc < self.count);
        return Array(self[loc...len]);
    }

    static func itemPrefix(prefix: String, count: Int, type: Int) -> Array! {
        var marr: [Any] = [];
        for i in 0...count {
            let item = String(format: "%@%d", prefix,i);
            
            switch type {
            case 1:
                let image = UIImage(named: item)!;
                marr.append(image);
            default:
                marr.append(item);
            }
        }
        return (marr as! Array<Element>);
    }
    
    ///添加多个相同元素到数组
    mutating func appendSame(_ item: Element, count: Int) {
        for _ in self.enumerated() {
            append(item)
        }
    }
    
}

@objc public extension NSArray{

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
    var jsonString: String? {
        guard let jsonData = self.jsonData as Data?,
        let jsonString = String(data: jsonData, encoding: .utf8) as String?
        else { return nil }
        return jsonString
    }
    
    /// 快速生成一个数组(step代表步长)
    static func range(_ start: Int = 0, _ end: Int, _ step: Int = 1) -> [Int] {
        assert(start < end);
        
        var list: [Int] = [];
        
        let count = end - start + 1;
        var k = 0;
        
        for i in 0..<count {
            k = start + step*i;
            if k < end {
                list.append(k)
            }
        }
        return list
    }
    
}
