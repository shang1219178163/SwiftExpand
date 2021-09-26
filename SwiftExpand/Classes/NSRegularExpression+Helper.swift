//
//  NSRegularExpression+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/3/16.
//  Copyright © 2019 BN. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Foundation


@objc public extension NSRegularExpression{
    
    ///匹配 input 中匹配 pattern 的字符串
    static func matchString(_ pattern: String, input: String, options: NSRegularExpression.Options = []) -> String {
        let tuples = NSRegularExpression.matchTuple(pattern, input: input, options: options)
        let result = tuples.map { $0.1 }.joined(separator: "")
        return result
    }
    
    ///匹配 input 中匹配 pattern 的字典集合(NSStringFromRange, String)
    static func matchDic(_ pattern: String, input: String, options: NSRegularExpression.Options = []) -> [String: String] {
        let tuples = NSRegularExpression.matchTuple(pattern, input: input, options: options)
        var dic = [String: String]()
        tuples.forEach { e in
            dic[NSStringFromRange(e.0)] = e.1
        }
        return dic
    }
}


public extension NSRegularExpression{
    
    ///正则匹配模式
    enum Pattern: String {
        ///汉字匹配表达式
        case hanzi = "[\\u4E00-\\u9FA5]+"
        ///非汉字匹配表达式
        case nonHanzi = "[^\\u4E00-\\u9FA5]+"
        ///英文字母匹配表达式
        case alphabet = "[a-zA-Z]+"
        ///非英文字母匹配表达式
        case nonAlphabet = "[^a-zA-Z]+"
        ///数字匹配表达式
        case number = "[0-9]+"
        ///非数字匹配表达式
        case nonNumber = "[^0-9]+"
        ///浮点数匹配表达式
        case float = "[0-9.]+"
        ///非浮点数匹配表达式
        case nonFloat = "[^0-9.]+"
    }
    
    static func regex(_ pattern: String, options: NSRegularExpression.Options = []) -> NSRegularExpression? {
        let regex = try? NSRegularExpression(pattern: pattern, options: options)
        return regex
    }
    
    ///匹配 input 中匹配 pattern 的元祖集合(NSStringFromRange, String)
    static func matchTuple(_ pattern: String, input: String, options: NSRegularExpression.Options = []) -> [(NSRange, String)] {
        guard let regex = NSRegularExpression.regex(pattern, options: options) else {
            return [] }
        let matches = regex.matches(in: input, options: [], range: NSRange(location: 0, length: input.utf16.count))
        return matches.map { match -> (NSRange, String) in
            guard let swiftRange = Range(match.range, in: input) else {
                return (match.range, "")
            }
//            DDLog("\(match.range)_\(input[swiftRange])")
            return (match.range, String(input[swiftRange]))
        }
    }
    
    ///input 中匹配 NSRegularExpression.Pattern 的元祖集合(NSStringFromRange, String)
    static func matchTuple2(_ pattern: NSRegularExpression.Pattern, input: String, options: NSRegularExpression.Options = []) -> [(NSRange, String)] {
        return matchTuple(pattern.rawValue, input: input, options: options)
    }
    
    ///input 中匹配 NSRegularExpression.Pattern 的字符串
    static func matchString2(_ pattern: NSRegularExpression.Pattern, input: String, options: NSRegularExpression.Options = []) -> String {
        return matchString(pattern.rawValue, input: input, options: options)
    }

}



@objc public extension NSPredicate{
    /// SELF MATCHES 匹配正则和字符串
    static func evaluateMatches(_ regex: String, aString: String) -> Bool {
        let predicate = NSPredicate(format: "SELF MATCHES %@", regex)
        return predicate.evaluate(with: aString)
    }
    
}


public extension NSPredicate{

//    ///正则匹配模式
//    enum Pattern: String {
//        ///jian
//        case simplePhone = "^1[0-9]{10}$"
//        /// email
//        case email = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
//        /// IPAddress
//        case IPAddress = "^(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})\\.(\\d{1,3})$"
//        /// 密码是否符合彼标准 8-14位字母数组的组合
//        case password_6_14 = "^(?![0-9]+$)(?![a-zA-Z]+$)[0-9A-Za-z]{6,14}$";
//    }
}


public extension String{

    ///验证
    func valid(_ regex: String) -> Bool {
        return NSPredicate.evaluateMatches(regex, aString: self)
    }
    
    
    ///验证金额,默认两位小数
    func validMoney(_ maxFractionDigits: Int = 1) -> Bool {
        let regex = "^\\-?([1-9]\\d*|0)(\\.\\d{0,\(maxFractionDigits)})?$"
        return NSPredicate.evaluateMatches(regex, aString: self)
    }
}
