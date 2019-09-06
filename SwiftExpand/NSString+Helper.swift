//
//  NSString+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension String{
    
    func valid() -> Bool! {
        let array = ["","nil","null"];
        if array.contains(self){
            return false;
        }
        return true;
    }
    
    func intValue() -> Int {
        return Int((self as NSString).intValue)
    }

    func floatValue() -> Float {
        return (self as NSString).floatValue
    }
    
    func cgFloatValue() -> CGFloat {
        return CGFloat(self.floatValue())
    }

    func doubleValue() -> Double {
        return (self as NSString).doubleValue
    }
    
    func reverse() -> String {
        return String(self.reversed())
    }
    /// range转换为NSRange
    func nsRange(from range: Range<String.Index>) -> NSRange {
        return NSRange(range, in: self)
    }
    
    /// NSRange转化为range
    func range(from nsRange: NSRange) -> Range<String.Index>? {
        guard
            let from16 = utf16.index(utf16.startIndex, offsetBy: nsRange.location, limitedBy: utf16.endIndex),
            let to16 = utf16.index(from16, offsetBy: nsRange.length, limitedBy: utf16.endIndex),
            let from = String.Index(from16, within: self),
            let to = String.Index(to16, within: self)
            else { return nil }
        return from ..< to
    }
    
    /// 读取本地json文件
    func jsonFileToJSONString() -> String {
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
    func toAsterisk() -> NSAttributedString{
        return (self as NSString).toAsterisk()
    }
    
    /// 复制到剪切板
    func copyToPasteboard(_ showTips: Bool) -> Void {
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

public extension Substring {
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


public extension NSString{
    
    /// 获取子字符串
    @objc func substring(loc: Int, len: Int) -> String {
        return self.substring(with: NSRange(location: loc, length: len))
    }
    
    /// 字符串本身大于string
    @objc func isCompare(_ string: NSString) -> Bool {
        if self.isEqual(to: "") {
            return false
        }
        
        var strSelf = self
        if strSelf.contains(".") {
            strSelf = strSelf.replacingOccurrences(of: ".", with: "") as NSString
        }
        return strSelf.integerValue > string.integerValue;
    }
    
    /// 大于version
    @objc func isNewer(version: String) -> Bool {
        return compare(version, options: .numeric) == .orderedDescending
    }
    /// 等于version
    @objc func isSame(version: String) -> Bool {
        return compare(version, options: .numeric) == .orderedSame
    }
    /// 小于version
    @objc func isOlder(version: String) -> Bool {
        return compare(version, options: .numeric) == .orderedAscending
    }
    
    /// 字符串首位加*
    @objc func toAsterisk() -> NSAttributedString{
        let isMust = self.contains(kAsterisk)
        return (self as NSString).getAttringByPrefix(kAsterisk, content: self as String, isMust: isMust)
    }
    
    /// 读取本地json文件
    @objc func jsonFileToJSONString() -> String {
        assert(self.contains(".geojson") == true);
        
        if self.contains(".geojson") == true {
            let array: Array = self.components(separatedBy: ".");
            let path = Bundle.main.path(forResource: array.first, ofType: array.last);
            if path == nil {
                return "";
            }
            if let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path!)) {
                
                if let jsonObj = try? JSONSerialization.jsonObject(with: jsonData, options: []) {
                    let jsonString = ((jsonObj as! NSDictionary).jsonValue()!).removingPercentEncoding!;
                    print(jsonString);
                    return jsonString;
                }
                return "";
            }
            return "";
        }
        return "";
    }
    
    /// 复制到剪切板
    @objc func copyToPasteboard(_ showTips: Bool) -> Void {
        UIPasteboard.general.string = self as String
        if showTips == true {
            let _ = UIAlertController.showAlert("提示", placeholders: nil, msg: "已复制'\(self)'到剪切板!", actionTitles: nil, handler: nil)
        }
    }
    
    /// isEnd 为真,秒追加为:59,为假 :00
    @objc static func dateTime(_ time: NSString, isEnd: Bool) -> NSString {
        if time.length < 10 {
            return time;
        }
        let sufix = isEnd == true ? " 23:59:59" : " 00:00:00";
        var tmp: NSString = time.substring(to: 10) as NSString;
        tmp = tmp.appending(sufix) as NSString
        return tmp;
    }
    
    /// 判断是否时间戳字符串
    @objc func isTimeStamp() -> Bool{
        if self.contains(" ") || self.contains("-") || self.contains(":") {
            return false;
        }
        
        if self.isPureInteger() == false || self.doubleValue < NSDate().timeIntervalSince1970 {
            return false;
        }
        return true
    }
    /// 整形判断
    @objc func isPureInteger() -> Bool{
        let scan = Scanner(string: self as String);
        var val: Int = 0;
        return (scan.scanInt(&val) && scan.isAtEnd);
    }
    /// 浮点形判断
    @objc func isPureFloat() -> Bool{
        let scan = Scanner(string: self as String);
        var val: Float = 0.0;
        return (scan.scanFloat(&val) && scan.isAtEnd);
    }
    
    /// (短时间)yyyy-MM-dd
    @objc func toDateShort() -> String{
        assert(self.length >= 10);
        return self.substring(to: 10);
    }
    
    /// 起始时间( 00:00:00时间戳)
    @objc func toTimestampShort() -> String{
        assert(self.length >= 10);
        
        let tmp = self.substring(to: 10) + " 00:00:00";
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormat_start)
        return result;
    }
    
    /// 截止时间( 23:59:59时间戳)
    @objc func toTimestampFull() -> String{
        assert(self.length >= 10);
        
        let tmp = self.substring(to: 10) + " 23:59:59";
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormat_end)
        return result;
    }
    /// 过滤特殊字符集
    @objc func filter(_ string: String) -> String{
        assert(self.length > 0);
        let chartSet = NSCharacterSet(charactersIn: string).inverted;
        let result = self.addingPercentEncoding(withAllowedCharacters: chartSet)
        return result!;
    }
    
    /// 删除首尾空白字符
    @objc func deleteWhiteSpaceBeginEnd(_ string: String) -> String{
        assert(self.length > 0);
        let chartSet = NSCharacterSet.whitespacesAndNewlines;
        let result = self.trimmingCharacters(in: chartSet)
        return result;
    }
    /// 取代索引处字符
    @objc func replacingCharacter(_ index: Int) -> String{
        assert(self.length > 0);
        let result = self.replacingCharacters(in: NSMakeRange(index, 1), with: self as String)
        return result;
    }
    
}
