//
//  NSString+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Foundation
import CommonCrypto

public extension String{

    /// md5字符串
    var md5: String {
        guard let data = self.data(using: .utf8) else { return ""}
        let hash = data.withUnsafeBytes { (bytes: UnsafeRawBufferPointer) -> [UInt8] in
            var hash = [UInt8](repeating: 0, count: Int(CC_MD5_DIGEST_LENGTH))
            CC_MD5(bytes.baseAddress, CC_LONG(data.count), &hash)
            return hash
        }
        return hash.map { String(format: "%02x", $0) }.joined()
    }
    
    var base64: String {
        let strData = self.data(using: .utf8)
        let base64String = strData?.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        return base64String ?? ""
    }
    
    var base64Decode: String {
        let decodedData = NSData(base64Encoded: self, options: NSData.Base64DecodingOptions.init(rawValue: 0))
        let decodedString = NSString(data: decodedData! as Data, encoding: String.Encoding.utf8.rawValue)
        return (decodedString ?? "") as String
    }
    
    var sha1: String {
         guard let data = self.data(using: .utf8) else { return ""}
         var digest = [UInt8](repeating: 0, count: Int(CC_SHA1_DIGEST_LENGTH))
         CC_SHA1([UInt8](data), CC_LONG(data.count), &digest)
         let hexBytes = digest.map { String(format: "%02hhx", $0) }
         return hexBytes.joined()
    }
    
    var sha256: String{
        guard let data = self.data(using: .utf8) else { return ""}
        return String.hexString(from: String.digest(data: data as NSData))
    }

    static func digest(data: NSData) -> NSData {
        let digestLength = Int(CC_SHA256_DIGEST_LENGTH)
        var hash = [UInt8](repeating: 0, count: digestLength)
        CC_SHA256(data.bytes, UInt32(data.length), &hash)
        return NSData(bytes: hash, length: digestLength)
    }

    static func hexString(from data: NSData) -> String {
        var bytes = [UInt8](repeating: 0, count: data.length)
        data.getBytes(&bytes, length: data.length)

        var hexString = ""
        for byte in bytes {
            hexString += String(format:"%02x", UInt8(byte))
        }
        return hexString
    }
    
    /// md5字符串
    var RMB: String {
        if (self.count <= 0) {
            return "-"
        }
        
        if self.cgFloatValue == 0.0 {
            return "¥0.00元"
        }
        return "¥\(self.cgFloatValue * 0.01)元"
    }
    
    ///以千为单位的描述
    var thousandDes: String {
        if self.isEmpty {
            return "0"
        }
        
        if self.intValue <= 1000 {
            return self
        }
        let result = String(format: "%.2fk", Float(self.intValue)/1000)
        return result
    }
    
    /// Int
    var intValue: Int {
        return Int((self as NSString).integerValue)
    }
    /// Float
    var floatValue: Float {
        return (self as NSString).floatValue
    }
    /// CGFloat
    var cgFloatValue: CGFloat {
        return CGFloat(self.floatValue)
    }
    /// Double
    var doubleValue: Double {
        return (self as NSString).doubleValue
    }
    
    var boolValue: Bool? {
        let selfLowercased = trimmingCharacters(in: .whitespacesAndNewlines).lowercased()
        switch selfLowercased {
        case "true", "yes", "1":
            return true
        case "false", "no", "0":
            return false
        default:
            return nil
        }
    }

    /// d字符串翻转
    var reverse: String {
        return String(self.reversed())
    }
    
    /// ->Data
    var jsonData: Data? {
        guard let data = self.data(using: .utf8) else { return nil }
        return data
    }
    
    /// 字符串->数组/字典
    var objValue: Any? {
        guard let data = self.data(using: .utf8),
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return nil }
        return json
    }
    ///移除两端空白
    var trimmed: String {
        return trimmingCharacters(in: .whitespacesAndNewlines)
    }
    
    var urlDecoded: String {
        return removingPercentEncoding ?? self
    }

    var urlEncoded: String {
//        return addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
        return addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
    }
    
    var isValidUrl: Bool {
        return URL(string: self) != nil
    }
    
    var isValidHttpUrl: Bool {
        guard let url = URL(string: self) else { return false }
        return url.scheme == "http" || url.scheme == "https"
    }
    
    var isValidFileUrl: Bool {
        return URL(string: self)?.isFileURL ?? false
    }
    
    ///以1开头的11位数字
    var isValidPhone: Bool{
        let pattern = "^1[0-9]{10}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", pattern)
        return predicate.evaluate(with: self)
    }
        
    ///验证邮箱
    var isValidEmail: Bool {
        if self.count == 0 {
            return false
        }
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    
    var isIPAddress: Bool {
        let regex: String = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@", regex)
        let rc: Bool = pre.evaluate(with: self)
        if rc {
            let componds: [String] = components(separatedBy: ",")
            var v: Bool = true
            for s in componds {
                if s.intValue > 255 {
                    v = false
                    break
                }
            }
            return v
        }
        return false
    }
    
    
    var isImageSuffix: Bool {
        var result = false;
        for e in ["BMP", "JPG", "JPEG", "PNG", "GIF"] {
            result = self.hasSuffix(".\(e)") || self.hasSuffix(".\(e.lowercased())")
            if result == true {
                break
            }
        }
        return result
    }
    
    ///****-**-** 00:00:00
    var dayBegin: String{
        return (self as NSString).dayBegin
    }
    
    ///****-**-** 23:59:59
    var dayEnd: String{
        return (self as NSString).dayEnd
    }
    
    /// 转驼峰
    func toCamelCase(_ separator: String = "-") -> String {
        if !self.contains(separator) {
            return self;
        }
        let result = self.components(separatedBy: separator)
            .reduce("", { $0 + $1.capitalized })
        return result;
    }
    
    /// 首字母小写
    func firstLetterLowercased() -> String {
        let result = self[0].lowercased() + self[1...];
        return result;
    }
    
    func hasPrefixs(_ prefixs: [String]) -> Bool{
        var result = false;
        for e in prefixs {
            result = self.hasPrefix("\(e)") || self.hasPrefix("\(e.lowercased())")
            if result == true {
                break
            }
        }
        return result
    }

    func hasSuffixs(_ suffixs: [String]) -> Bool{
        var result = false;
        for e in suffixs {
            result = self.hasSuffix("\(e)") || self.hasSuffix("\(e.lowercased())")
            if result == true {
                break
            }
        }
        return result
    }
    
    /// (填充字符到最大长度)padding [value] to [width]
    func padLeft(_ width: Int, _ padding: String = " ") -> String {
        if width <= self.count {
            return self
        }
        return String(repeating: padding, count: width - count) + self
    }
    
    /// (填充字符到最大长度)padding [value] to [width]
    func padRight(_ width: Int, _ padding: String = " ") -> String {
        if width <= self.count {
            return self
        }
        return self + String(repeating: padding, count: width - count)
    }
    
    /// 字符串开始到第index
    func substringTo(_ index: Int) -> String {
        guard index < self.count else {
            assertionFailure("index beyound the length of the string")
            return ""
        }
        
        let theIndex = self.index(self.startIndex, offsetBy: index)
        return String(self[startIndex...theIndex])
    }
    
    /// 从第index个开始到结尾的字符
    func substringFrom(_ index: Int) -> String {
        guard index < self.count else {
            assertionFailure("index beyound the length of the string")
            return ""
        }
        
        guard index >= 0 else {
            assertionFailure("index can't be lower than 0")
            return ""
        }
        
        let theIndex = self.index(self.endIndex, offsetBy: index - self.count)
        return String(self[theIndex..<endIndex])
    }
    
    func isValidByRegex(_ regex: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: self)
    }
    ///移除两端对应的字符
    func trimmedBy(_ string: String) -> String {
        return trimmingCharacters(in: CharacterSet(charactersIn: string))
    }
    
    func replacingOccurrences(of targets: [String], replacement: String) -> String {
        var result = self
        targets.forEach { (value) in
            result = result.replacingOccurrences(of: value, with: replacement)
        }
        return result
    }

    /// 计算高度
    func size(with width: CGFloat, font: Font = Font.systemFont(ofSize: 17)) -> CGSize {
        return (self as NSString).size(with: width, font: font)
    }
    
    // MARK: -funtions
    func substring(_ location: Int, length: Int) -> String {
        let result = (self as NSString).substring(with: NSMakeRange(location, length))
        return result
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
    
    ///获取两个字符串中间的部分(含这两部分)
    func substring(_ pref: String, suffix: String, isContain: Bool = false) -> String {
        return (self as NSString).substring(pref, suffix: suffix, isContain: isContain)
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange (0, self.count),
                                              withTemplate: with)
    }
    
    /// 通过集合字符的字母分割字符串
    func componentsSeparatedByCharacters(_ aString: String) -> [String]{
        let result = self.components(separatedBy: CharacterSet(charactersIn: aString))
        return result
    }
    
    func filterHTML() -> String {
        var html = self
        
        let scanner = Scanner(string: html)
        var text: NSString?
        while scanner.isAtEnd == false {
            scanner.scanUpTo("<", into: nil)
            scanner.scanUpTo(">", into: &text)
            html = html.replacingOccurrences(of: "\(text ?? "")>", with: "")
        }
        return html
    }
    
    /// 大于version
    func isBig(_ value: String) -> Bool {
        return (self as NSString).isBig(value)
    }

    /// 小于version
    func isSmall(_ value: String) -> Bool {
        return (self as NSString).isSmall(value)
    }
    /// 汉字转为拼音
    func transformToPinyin() -> String {
       return (self as NSString).transformToPinyin()
    }
    
    /// 汉字链接处理
    func handleHanzi() -> String {
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        let encodingURL = self.addingPercentEncoding(withAllowedCharacters: charSet)
        return encodingURL ?? ""
    }

    /// 整形判断
    func isPureInteger() -> Bool{
        return (self as NSString).isPureInteger()
    }
    /// 浮点形判断
    func isPureFloat() -> Bool{
        return (self as NSString).isPureFloat()
    }
    
    func replacingOccurrences(_ loc: Int, _ len: Int, with replacement: String) -> String{
        if self.count < loc + len {
            return self
        }
        var tmp = (self as NSString).substring(with: NSRange(location: loc, length: len))
        tmp = replacingOccurrences(of: tmp, with: replacement)
        return tmp
    }
    
    func replacingCharacters(_ loc: Int, _ len: Int, with replacement: String) -> String{
        if self.count < loc + len {
            return self
        }
        let result = (self as NSString).replacingCharacters(in: NSRange(location: loc, length: len), with: replacement)
        return result
    }
    
    func substring(from: Int) -> String{
        return (self as NSString).substring(from: from)
    }

    func substring(to: Int) -> String{
        if self.count < to {
            return self
        }
        return (self as NSString).substring(to: to)
    }

    func substring(with range: NSRange) -> String{
        return (self as NSString).substring(with: range)
    }
    
    func substring(_ loc: Int, _ len: Int) -> String{
        if self.count < loc {
            return self
        }
        return (self as NSString).substring(with: NSRange(location: loc, length: len))
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
    
    func toCamelCase() -> String {
        return String(self).toCamelCase()
    }

    func firstLetterLowercased() -> String {
        return String(self).firstLetterLowercased()
    }
}

public extension String{
    
    static func * (lhs: String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }
    
    static func *= (lhs: inout String, rhs: Int) -> String {
        guard rhs > 0 else { return "" }
        return String(repeating: lhs, count: rhs)
    }
}

//Range/nsRange 相互转换
//  let string = "Hello USA 🇺🇸 !!! Hello World !!!"
//  if let nsRange = string.range(of: "Hello World")?.nsRange(in: string) {
//      (string as NSString).substring(with: nsRange) //  "Hello World"
//  }
//
//  if let nsRange = string.nsRange(of: "Hello World") {
//    (string as NSString).substring(with: nsRange) //  "Hello World"
//  }
//  let nsRanges = string.nsRanges(of: "Hello")
//  print(nsRanges)   // "[{0, 5}, {19, 5}]\n"
//
public extension RangeExpression where Bound == String.Index  {
    func nsRange<S: StringProtocol>(in string: S) -> NSRange { .init(self, in: string) }
}

public extension StringProtocol {
    
    func nsRange<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> NSRange? {
        self.range(of: string,
                   options: options,
                   range: range ?? startIndex..<endIndex,
                   locale: locale ?? .current)?
            .nsRange(in: self)
    }
    
    func nsRanges<S: StringProtocol>(of string: S, options: String.CompareOptions = [], range: Range<Index>? = nil, locale: Locale? = nil) -> [NSRange] {
        var start = range?.lowerBound ?? startIndex
        let end = range?.upperBound ?? endIndex
        var ranges: [NSRange] = []
        while start < end,
            let range = self.range(of: string,
                                   options: options,
                                   range: start..<end,
                                   locale: locale ?? .current) {
            ranges.append(range.nsRange(in: self))
            start = range.lowerBound < range.upperBound ? range.upperBound :
            index(range.lowerBound, offsetBy: 1, limitedBy: endIndex) ?? endIndex
        }
        return ranges
    }
}



@objc public extension NSString{

    var isEmpty: Bool {
        let tmp = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let result = ["", "nil", "null"].contains(tmp.lowercased())
        return result
    }
    
    var md5: String {
        return (self as String).md5
    }
    
    var base64: String {
        return (self as String).base64
    }

    var base64Decode: String {
        return (self as String).base64Decode
    }
    
    var sha1: String{
        return (self as String).sha1
    }
    
    var sha256: String{
        return (self as String).sha256
    }
    
    var RMB: String {
        return (self as String).RMB
    }
    
    var thousandDes: String {
        return (self as String).thousandDes
    }
    ///移除两端空白
    var trimmed: String {
        return (self as String).trimmed
    }
    
    var urlDecoded: String {
        return (self as String).urlDecoded
    }

    var urlEncoded: String {
        return (self as String).urlEncoded
    }
    
    var isValidUrl: Bool {
        return (self as String).isValidUrl
    }
    
    var isValidHttpUrl: Bool {
        return (self as String).isValidHttpUrl
    }
    
    var isValidFileUrl: Bool {
        return (self as String).isValidFileUrl
    }
    
    ///以1开头的11位数字
    var isValidPhone: Bool{
        return (self as String).isValidPhone

    }
    ///验证邮箱
    var isValidEmail: Bool {
        return (self as String).isValidEmail
    }
    
    ///验证IP
    var isIPAddress: Bool {
        return (self as String).isIPAddress
    }
    
    ///****-**-** 00:00:00
    var dayBegin: String{
        if length != 19 || !contains(":") {
            return self as String
        }
        
        let result = self.substring(to: 10).appending(" 00:00:00")
        return result
    }
    
    ///****-**-** 23:59:59
    var dayEnd: String{
        if length != 19 || !contains(":") {
            return self as String
        }

        let result = self.substring(to: 10).appending(" 23:59:59")
        return result
    }
    
    var objValue: Any? {
        return (self as String).objValue
    }

        
    func isValidByRegex(_ regex: String) -> Bool {
        return (self as String).isValidByRegex(regex)
    }
    ///移除两端对应的字符
    func trimmedBy(_ string: String) -> String {
        return (self as String).trimmedBy(string)
    }
    
    /// 获取子字符串
    func substring(loc: Int, len: Int) -> String {
        return self.substring(with: NSRange(location: loc, length: len))
    }
        
    /// 通过集合字符的字母分割字符串
    func componentsSeparatedByCharacters(_ aString: String) -> [String]{
        let result = self.components(separatedBy: CharacterSet(charactersIn: aString))
        return result
    }
    
    /// 取代索引处字符
    func replacingCharacter(_ aString: String, at index: Int) -> String{
        assert(self.length > 0)
        let result = self.replacingCharacters(in: NSMakeRange(index, 1), with: aString)
        return result
    }
    
    ///获取两个字符串中间的部分(含这两部分)
    func substring(_ pre: String, preOptions: NSString.CompareOptions = [],
                   suffix: String, subfixOptions: NSString.CompareOptions = .backwards,
                   isContain: Bool = false) -> String {
        let beginLocation = self.range(of: pre, options: preOptions).location
        let endLocation = self.range(of: suffix, options: subfixOptions).location
        if beginLocation == NSNotFound || endLocation == NSNotFound {
            return self as String
        }
        
        let beginIdx = isContain == true ? beginLocation : beginLocation + 1
        let endIdx = isContain == true ? endLocation - beginLocation + 1 : endLocation - beginLocation
        let result = self.substring(with: NSRange(location: beginIdx, length: endIdx))
        return result
    }
    
    ///获取两个字符串中间的部分(含这两部分)
//    func substring(_ prefix: String, prefixOptions: String.CompareOptions = [], suffix: String, suffixOptions: String.CompareOptions = .backwards, isContain: Bool = false) -> String {
//        guard let range = self.range(of: prefix),
//              let range1 = self.range(of: suffix, options: .backwards) else {
//                  return ""
//              }
//
//        let location = self.distance(from: self.startIndex, to:range.lowerBound)
//        let location1 = self.distance(from: self.startIndex, to:range1.lowerBound)
//
//        if isContain {
//            return String(self[location...location1])
//        }
//        let result = self[(location + prefix.count)..<location1]
//        return String(result)
//    }
    
    
    func filterHTML() -> String {
        return (self as String).filterHTML()
    }
        
    /// 大于version
    func isBig(_ value: String) -> Bool {
        return compare(value, options: .numeric) == .orderedDescending
    }

    /// 小于version
    func isSmall(_ value: String) -> Bool {
        return compare(value, options: .numeric) == .orderedAscending
    }
    
    /// 转为拼音
    func transformToPinyin() -> String {
        let chinese: String = self as String
        let mutableStr = NSMutableString(string: chinese) as CFMutableString
        let canTransform: Bool = CFStringTransform(mutableStr, nil, kCFStringTransformToLatin, false) &&
            CFStringTransform(mutableStr, nil, kCFStringTransformStripCombiningMarks, false)
        if canTransform == true {
            return mutableStr as String
        }
        return ""
    }

    /// 判断是否时间戳字符串
    func isTimeStamp() -> Bool{
        if [" ", "-", ":"].contains(self) {
            return false
        }
        
        if isPureInteger() == false || doubleValue < NSDate().timeIntervalSince1970 {
            return false
        }
        return true
    }
    /// 整形判断
    func isPureInteger() -> Bool{
        let scan = Scanner(string: self as String)
        var val: Int = 0
        return (scan.scanInt(&val) && scan.isAtEnd)
    }
    /// 浮点形判断
    func isPureFloat() -> Bool{
        let scan = Scanner(string: self as String)
        var val: Float = 0.0
        return (scan.scanFloat(&val) && scan.isAtEnd)
    }
    
    /// (短时间)yyyy-MM-dd
    func toDateShort() -> String{
        if length <= 10 {
            return self as String
        }
        return self.substring(to: 10)
    }
    
    /// 起始时间( 00:00:00时间戳)
    func toTimestampShort() -> String{
        assert(self.length >= 10)
        
        let tmp = self.substring(to: 10) + " 00:00:00"
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormatBegin)
        return result
    }
    
    /// 截止时间( 23:59:59时间戳)
    func toTimestampFull() -> String{
        assert(self.length >= 10)
        
        let tmp = self.substring(to: 10) + " 23:59:59"
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormatEnd)
        return result
    }
    ///截止到天
    func timeToDay() -> String {
        if self.contains(" ") == false {
            return self as String
        }
        if let result = self.components(separatedBy: " ").first as String?{
            return result
        }
        return ""
    }
    
    /// 过滤特殊字符集
    func filter(_ string: String) -> String{
        assert(self.length > 0)
        let chartSet = NSCharacterSet(charactersIn: string).inverted
        let result = addingPercentEncoding(withAllowedCharacters: chartSet)
        return result!
    }
    
    /// 通过集合字符的字母分割字符串
    func componentsSeparatedByCharactersInString(_ aString: String) -> [String]{
        let result = (self as NSString).components(separatedBy: CharacterSet(charactersIn: aString))
        return result
    }
    
    /// 删除首尾空白字符
    func deleteWhiteSpaceBeginEnd() -> String{
        assert(self.length > 0)
        let chartSet = NSCharacterSet.whitespacesAndNewlines
        let result = self.trimmingCharacters(in: chartSet)
        return result
    }
    
    /// 取代索引处字符
    func replacingCharacter(_ index: Int) -> String{
        assert(self.length > 0)
        let result = self.replacingCharacters(in: NSMakeRange(index, 1), with: self as String)
        return result
    }
    
    func isValidEmailAddress() -> Bool {
        let emailID: String = self as String
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: emailID)
    }
    
    ///计算高度
    func size(with width: CGFloat, font: Font = Font.systemFont(ofSize: 17)) -> CGSize {
        let attDic = [NSAttributedString.Key.font: font,]
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     attributes: attDic,
                                     context: nil).size
        size.width = ceil(size.width)
        size.height = ceil(size.height)
        return size
    }
}
