//
//  NSString+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
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
            return "-";
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
    
    /// 是否是"","nil","null"
    var isValid: Bool {
        return !["","nil","null"].contains(self);
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
    /// 为空返回默认值"--"
    var valueText: String {
        return self != "" ? self : "--"
    }
    /// d字符串翻转
    var reverse: String {
        return String(self.reversed())
    }
    
    /// ->Data
    var jsonData: Data? {
        guard let data = self.data(using: .utf8) else { return nil }
        return data;
    }
    
    /// 字符串->数组/字典
    var objValue: Any? {
        guard let data = self.data(using: .utf8),
        let json = try? JSONSerialization.jsonObject(with: data, options: [])
            else { return nil }
        return json
    }
    
    /// 计算高度
    func size(_ font: CGFloat, width: CGFloat) -> CGSize {
        return (self as NSString).size(font, width: width)
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
    
    ///过滤字符集
    func replacingOccurrences(of String: String, withSet: String) -> String {
        return (self as NSString).replacingOccurrences(of: String, withSet: withSet)
    }
    
    ///获取两个字符串中间的部分(含这两部分)
    func substring(_ prefix: String, subfix: String, isContain: Bool = false) -> String {
        return (self as NSString).substring(prefix, subfix: subfix, isContain: isContain)
    }
    
    //使用正则表达式替换
    func pregReplace(pattern: String, with: String, options: NSRegularExpression.Options = []) -> String {
        let regex = try! NSRegularExpression(pattern: pattern, options: options)
        return regex.stringByReplacingMatches(in: self, options: [],
                                              range: NSMakeRange (0, self.count),
                                              withTemplate: with)
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
    
    ///获取 URL 的参数字典
    func urlParms() -> [String: Any]? {
        guard self.hasPrefix("http") else {
            return nil }
                
        let index = (self as NSString).range(of: "?", options: .backwards).location
        let tmp = (self as NSString).substring(from: index + 1)
        let list = tmp.components(separatedBy: "&")
            
        var dic = [String: Any]()
        list.forEach {
            let list = $0.components(separatedBy: "=")
            dic["\(list[0])"] = list[1]
        }
        return dic
    }
    
    /// 大于version
    func isBig(_ value: String) -> Bool {
        return (self as NSString).isBig(value)
    }
    /// 等于version
//    func isSame(version: String) -> Bool {
//        return (self as NSString).isSame(value)
//    }
    /// 小于version
    func isSmall(_ value: String) -> Bool {
        return (self as NSString).isSmall(value)
    }
    /// 汉字转为拼音
    func transformToPinyin() -> String {
       return (self as NSString).transformToPinyin();
    }
    
    /// 汉字链接处理
    func handleHanzi() -> String {
        var charSet = CharacterSet.urlQueryAllowed
        charSet.insert(charactersIn: "#")
        let encodingURL = self.addingPercentEncoding(withAllowedCharacters: charSet)
        return encodingURL ?? ""
    }
    
    /// 字符串首位加*
    func toAsterisk(_ textColor: UIColor = .black, font: CGFloat = 15) -> NSAttributedString{
        return (self as NSString).toAsterisk(textColor, font: font)
    }
    
    /// 复制到剪切板
    func copyToPasteboard(_ showTips: Bool) {
        (self as NSString).copyToPasteboard(showTips)
    }
    
    /// 整形判断
    func isPureInteger() -> Bool{
        return (self as NSString).isPureInteger()
    }
    /// 浮点形判断
    func isPureFloat() -> Bool{
        return (self as NSString).isPureFloat()
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
}


@objc public extension NSString{

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

    /// 地址字符串(hostname + port)
    static func UrlAddress(_ hostname: String, port: String) ->String {
        var webUrl: String = hostname;
        if !hostname.contains("http://") {
            webUrl = "http://" + hostname;
        }
        if port != "" {
            webUrl = webUrl + ":\(port)";
        }
        return webUrl;
    }
    
    /// 获取子字符串
    func substring(loc: Int, len: Int) -> String {
        return self.substring(with: NSRange(location: loc, length: len))
    }
        
    ///过滤字符集
    func replacingOccurrences(of String: String, withSet: String) -> String {
        let items: [String] = self.components(separatedBy: CharacterSet(charactersIn: withSet))
        return items.joined(separator: "")
    }
    
    ///获取两个字符串中间的部分(含这两部分)
    func substring(_ prefix: String, subfix: String, isContain: Bool = false) -> String {
        let beginLocation = self.range(of: prefix).location
        let endLocation = self.range(of: subfix, options: .backwards).location
        if beginLocation == NSNotFound || endLocation == NSNotFound {
            return self as String
        }
        
        let beginIdx = isContain == true ? beginLocation : beginLocation + 1
        let endIdx = isContain == true ? endLocation - beginLocation + 1 : endLocation - beginLocation
        let result = self.substring(with: NSRange(location: beginIdx, length: endIdx))
        return result
    }
    
    func filterHTML() -> String {
        return (self as String).filterHTML()
    }
    
    ///获取 URL 的参数字典
    func urlParms() -> [String: Any]? {
        return (self as String).urlParms()
    }
    
    /// 大于version
    func isBig(_ value: String) -> Bool {
        return compare(value, options: .numeric) == .orderedDescending
    }
//    /// 等于version
//    func isSame(version: String) -> Bool {
//        return compare(version, options: .numeric) == .orderedSame
//    }
    /// 小于version
    func isSmall(_ value: String) -> Bool {
        return compare(value, options: .numeric) == .orderedAscending
    }
    
    /// 转为拼音
    func transformToPinyin() -> String {
        let chinese: String = self as String;
        let mutableStr = NSMutableString(string: chinese) as CFMutableString
        let canTransform: Bool = CFStringTransform(mutableStr, nil, kCFStringTransformToLatin, false) &&
            CFStringTransform(mutableStr, nil, kCFStringTransformStripCombiningMarks, false);
        if canTransform == true {
            return mutableStr as String
        }
        return ""
    }
    
    /// 字符串首位加*
    func toAsterisk(_ textColor: UIColor = .black, font: CGFloat = 15) -> NSAttributedString{
        let isMust = self.contains(kAsterisk)
        return (self as NSString).getAttringByPrefix(kAsterisk, content: self as String, color: textColor, font: font, isMust: isMust)
    }
    
    /// 复制到剪切板
    func copyToPasteboard(_ showTips: Bool) {
        UIPasteboard.general.string = self as String
        if showTips == true {
            UIAlertController(title: nil, message: "已复制'\(self)'到剪切板!", preferredStyle: .alert)
                .present(true, completion: nil)
        }
    }
    
    /// isEnd 为真,秒追加为:59,为假 :00
    static func dateTime(_ time: NSString, isEnd: Bool) -> NSString {
        if time.length < 10 {
            return time;
        }
        let sufix = isEnd == true ? " 23:59:59" : " 00:00:00";
        var tmp: NSString = time.substring(to: 10) as NSString;
        tmp = tmp.appending(sufix) as NSString
        return tmp;
    }
    
    /// 判断是否时间戳字符串
    func isTimeStamp() -> Bool{
        if [" ", "-", ":"].contains(self) {
            return false;
        }
        
        if isPureInteger() == false || doubleValue < NSDate().timeIntervalSince1970 {
            return false;
        }
        return true
    }
    /// 整形判断
    func isPureInteger() -> Bool{
        let scan = Scanner(string: self as String);
        var val: Int = 0;
        return (scan.scanInt(&val) && scan.isAtEnd);
    }
    /// 浮点形判断
    func isPureFloat() -> Bool{
        let scan = Scanner(string: self as String);
        var val: Float = 0.0;
        return (scan.scanFloat(&val) && scan.isAtEnd);
    }
    
    /// (短时间)yyyy-MM-dd
    func toDateShort() -> String{
        assert(self.length >= 10);
        return self.substring(to: 10);
    }
    
    /// 起始时间( 00:00:00时间戳)
    func toTimestampShort() -> String{
        assert(self.length >= 10);
        
        let tmp = self.substring(to: 10) + " 00:00:00";
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormatBegin)
        return result;
    }
    
    /// 截止时间( 23:59:59时间戳)
    func toTimestampFull() -> String{
        assert(self.length >= 10);
        
        let tmp = self.substring(to: 10) + " 23:59:59";
        let result = DateFormatter.intervalFromDateStr(tmp, fmt: kDateFormatEnd)
        return result;
    }
    ///截止到天
    func timeToDay() -> String {
        if self.contains(" ") == false {
            return self as String;
        }
        if let result = self.components(separatedBy: " ").first as String?{
            return result;
        }
        return ""
    }
    
    /// 过滤特殊字符集
    func filter(_ string: String) -> String{
        assert(self.length > 0);
        let chartSet = NSCharacterSet(charactersIn: string).inverted;
        let result = self.addingPercentEncoding(withAllowedCharacters: chartSet)
        return result!;
    }
    
    /// 通过集合字符的字母分割字符串
    func componentsSeparatedByCharactersInString(_ aString: String) -> [String]{
        let result = self.components(separatedBy: CharacterSet(charactersIn: aString))
        return result;
    }
    
    /// 删除首尾空白字符
    func deleteWhiteSpaceBeginEnd() -> String{
        assert(self.length > 0);
        let chartSet = NSCharacterSet.whitespacesAndNewlines;
        let result = self.trimmingCharacters(in: chartSet)
        return result;
    }
    
    /// 取代索引处字符
    func replacingCharacter(_ aString: String, at index: Int) -> String{
        assert(self.length > 0);
        let result = self.replacingCharacters(in: NSMakeRange(index, 1), with: aString)
        return result;
    }
    
    ///计算高度
    func size(_ font: CGFloat, width: CGFloat) -> CGSize {
        let attDic = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: font),];
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        
        let size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: attDic, context: nil).size;
        return CGSize(width: ceil(size.width), height: ceil(size.height))
    }
    
    
    func isValidateByRegex(_ regex: String) -> Bool {
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@",regex)
        return pre.evaluate(with: self)
    }
    
    func isMobileNumber() -> Bool {
        if hasPrefix("1") {
            if length == 11 {
                if self.trimmingCharacters(in: .decimalDigits).count == 0 {
                    return true
                }
            }
        }
        return false
    }
    
    func isEmailAddress() -> Bool {
        let emailRegex: String = "[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        return isValidateByRegex(emailRegex)
    }
    
    func isIPAddress() -> Bool {
        let regex: String = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
        let pre: NSPredicate = NSPredicate(format: "SELF MATCHES %@",regex)
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
    
    func isValidUrl() -> Bool {
        let regex = "^((http)|(https))+:[^\\s]+\\.[^\\s]*$";
        return isValidateByRegex(regex)
    }
    
}
