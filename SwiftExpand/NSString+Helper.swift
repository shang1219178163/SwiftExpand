//
//  NSString+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

extension String{
    
    public func valid() -> Bool! {
        let array = ["","nil","null"];
        if array.contains(self){
            return false;
        }
        return true;
    }
    
    public func intValue() -> Int {
        return Int((self as NSString).intValue)
    }

    public func floatValue() -> Float {
        return (self as NSString).floatValue
    }
    
    public func cgFloatValue() -> CGFloat {
        return CGFloat(self.floatValue())
    }

    public func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }
    
    public func reverse() -> String {
        return String(self.reversed())
    }
    /// range转换为NSRange
    public func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /// NSRange转化为range
    public func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    /// 读取本地json文件
    public func jsonFileToJSONString() -> String {
        return (self as NSString).jsonFileToJSONString();
    }
    
    /// 大于version
    func isNewer(version: String) -> Bool {
        return (self as NSString).isNewer(version:version)
    }
    /// 等于version
    func isSame(version: String) -> Bool {
        return (self as NSString).isSame(version:version)
    }
    /// 小于version
    func isOlder(version: String) -> Bool {
        return (self as NSString).isOlder(version:version)
    }
    
    /// 字符串首位加*
    public func toAsterisk() -> NSAttributedString{
        return (self as NSString).toAsterisk()
    }
    
    /// 复制到剪切板
    public func copyToPasteboard(_ showTips: Bool) -> Void {
        (self as NSString).copyToPasteboard(showTips)
    }
    
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }

}

extension Substring {
    subscript (i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    subscript (bounds: CountableRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ..< end]
    }
    subscript (bounds: CountableClosedRange<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[start ... end]
    }
    subscript (bounds: CountablePartialRangeFrom<Int>) -> Substring {
        let start = index(startIndex, offsetBy: bounds.lowerBound)
        let end = index(endIndex, offsetBy: -1)
        return self[start ... end]
    }
    subscript (bounds: PartialRangeThrough<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ... end]
    }
    subscript (bounds: PartialRangeUpTo<Int>) -> Substring {
        let end = index(startIndex, offsetBy: bounds.upperBound)
        return self[startIndex ..< end]
    }
}


extension NSString{
    
    /// 获取子字符串
    @objc public func substring(loc: Int, len: Int) -> String {
        return self.substring(with: NSRange(location: loc, length: len))
    }
    
    /// 字符串本身大于string
    @objc public func isCompare(_ string: NSString) -> Bool {
        if self.isEqual(to: "") {
            return false
        }
        
        var strSelf = self
        if strSelf.contains(".") {
            strSelf = strSelf.replacingOccurrences(of: ".", with: "") as NSString
        }
        return strSelf.integerValue > string.integerValue;
    }
    
    /// 读取本地json文件
    @objc public func jsonFileToJSONString() -> String {
        return (self as NSString).jsonFileToJSONString();
    }
    
    /// 大于version
    @objc func isNewer(version: String) -> Bool {
        return (self as NSString).isNewer(version:version)
    }
    /// 等于version
    @objc func isSame(version: String) -> Bool {
        return (self as NSString).isSame(version:version)
    }
    /// 小于version
    @objc func isOlder(version: String) -> Bool {
        return (self as NSString).isOlder(version:version)
    }
    
    /// 字符串首位加*
    @objc public func toAsterisk() -> NSAttributedString{
        return (self as NSString).toAsterisk()
    }
    
    /// 复制到剪切板
    @objc public func copyToPasteboard(_ showTips: Bool) -> Void {
        (self as NSString).copyToPasteboard(showTips)
    }
    
    /// isEnd 为真,秒追加为:59,为假 :00
    @objc public static func dateTime(_ time: NSString, isEnd: Bool) -> NSString {
        var tmp: NSString = time;
        let sufix = isEnd == true ? ":59" : ":00";
        switch time.length {
        case 16:
            tmp = time.appending(sufix) as NSString
            
        case 19:
            tmp = time.replacingCharacters(in: NSRange(location: time.length - sufix.count, length: sufix.count), with: sufix) as NSString
            
        default:
            break
        }
        return tmp;
    }
}
