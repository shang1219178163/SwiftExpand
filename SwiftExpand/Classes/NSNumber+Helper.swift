
//
//  Number+Helper.swift
//  IntelligentOfParking
//
//  Created by Bin Shang on 2018/12/22.
//  Copyright © 2018 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import Foundation

/// ¥###,##0.00
public let kNumFormat = "¥###,##0.00";

//MARK: -NumberFormatter
@objc public extension NumberFormatter{
    
//    convenience init(_ style: NumberFormatter.Style) {
//        self.init()
//        self.numberStyle = style
//    }
    
    /// 根据 NumberFormatter.Style 生成/获取 NumberFormatter, 避免多次创建(效果如下)
    /// none_              0.6767 -> 1              123456789.6767 -> 123456790
    /// decimal_           0.6767 -> 0.677          123456789.6767 -> 123,456,789.677
    /// currency_          0.6767 -> ¥0.68          123456789.6767 -> ¥123,456,789.68
    /// currencyISOCode_   0.6767 -> CNY 0.68       123456789.6767 -> CNY 123,456,789.68
    /// currencyPlural_    0.6767 -> 0.68 人民币     123456789.6767 -> 123,456,789.68 人民币
    /// currencyAccounting_0.6767 -> ¥0.68          123456789.6767 -> ¥123,456,789.68
    /// percent_           0.6767 -> 68%            123456789.6767 -> 12,345,678,968%
    /// scientific_        0.6767 -> 6.767E-1       123456789.6767 -> 1.234567896767E8
    /// spellOut_          0.6767 -> 〇点六七六七     123456789.6767 -> 一亿二千三百四十五万六千七百八十九点六七六七
    /// ordinal_           0.6767 -> 第1            123456789.6767 -> 第123,456,790
    static func number(_ style: NumberFormatter.Style = .currency) -> NumberFormatter {
        let dic = Thread.current.threadDictionary
        
        let key = "NumberFormatter.Style.RawValue.\(style.rawValue)"
        if let formatter = dic.object(forKey: key) as? NumberFormatter {
            return formatter
        }
        
        let fmt = NumberFormatter()
//        fmt.locale = .current
//        fmt.minimumIntegerDigits = 1
//        fmt.minimumFractionDigits = style == .none ? 0 : 2
//        fmt.roundingMode = .up

        fmt.numberStyle = style
        dic.setObject(fmt, forKey: (key as NSString))
        return fmt
    }
    
    /// 数值格式化
    /// - Parameters:
    ///   - style: NumberFormatter.Style
    ///   - minFractionDigits: minimumFractionDigits = 2
    ///   - maxFractionDigits: maximumFractionDigits = 2
    /// - Returns: NumberFormatter
    static func format(_ style: NumberFormatter.Style = .none,
                       minFractionDigits: Int = 2,
                       maxFractionDigits: Int = 2,
                       positivePrefix: String = "¥",
                       groupingSeparator: String = ",",
                       groupingSize: Int = 3) -> NumberFormatter {
        let fmt = NumberFormatter.number(style)
        fmt.minimumIntegerDigits = 1
        fmt.minimumFractionDigits = minFractionDigits
        fmt.maximumFractionDigits = maxFractionDigits

        fmt.positivePrefix = positivePrefix
//        fmt.positiveSuffix = ""

        fmt.usesGroupingSeparator = true //分隔设true
        fmt.groupingSeparator = groupingSeparator //分隔符
        fmt.groupingSize = groupingSize  //分隔位数
        return fmt
    }

    /// 保留小数,默认四舍五入[弃用,代替者: format( _ style:, minFractionDigits:, maxFractionDigits:, positivePrefix:, groupingSeparator: , groupingSize:) -> NumberFormatter]
    static func fractionDigits(obj: CGFloat,
                               min: Int = 2,
                               max: Int = 2,
                               roundingMode: NumberFormatter.RoundingMode = .halfUp,
                               numberStyle: NumberFormatter.Style = .currency) -> String? {
        let fmt = NumberFormatter.number(numberStyle)
        fmt.minimumFractionDigits = min
        fmt.maximumFractionDigits = max
        fmt.roundingMode = roundingMode
        return fmt.string(for: obj)
    }
    
    /// format 格式金钱显示
    /// - Parameters:
    ///   - obj: number
    ///   - format: @",###.##"...
    /// - Returns: String?
    static func positiveFormat(_ style: NumberFormatter.Style = .none,
                               obj: CGFloat,
                               format: String = kNumFormat,
                               defalut: String = "-") -> String? {
        let fmt = NumberFormatter.number(style)
        fmt.positiveFormat = format
        return fmt.string(for: obj)
    }
    
    /// number为NSNumber/String
    static func localizedString(_ style: NumberFormatter.Style = .none, from number: Any) -> String? {
        if let obj = number as? NSNumber {
            return NumberFormatter.localizedString(from: obj, number: style);
        }

        guard let obj = number as? String else { return nil }

        let set = CharacterSet(charactersIn: kSetFloat).inverted
        let result = obj.components(separatedBy: set).joined(separator: "")
        if result.count > 0 {
            return NumberFormatter.localizedString(from: NSNumber(value: result.floatValue), number: style);
        }
        return nil
    }
   
    
    func digits(_ miniIntegerDigits: Int = 1,
                      minFractionDigits: Int = 2,
                      maxFractionDigits: Int = 2) -> Self {
        minimumIntegerDigits = miniIntegerDigits
        minimumFractionDigits = minFractionDigits
        maximumFractionDigits = maxFractionDigits
        return self
    }
    
    func formatGroup(_ groupingSeparator: String = ",",
                     groupingSize: Int = 3) -> Self {
        self.usesGroupingSeparator = true //分隔设true
        self.groupingSeparator = groupingSeparator //分隔符
        self.groupingSize = groupingSize  //分隔位数
        return self
    }
    
    func positivePrefix(_ prefix: String = "") -> Self {
        self.positivePrefix = positivePrefix
        return self
    }
    
    func positiveSuffix(_ suffix: String = "") -> Self {
        self.positiveSuffix = suffix
        return self
    }
    
    func negativePrefix(_ prefix: String = "") -> Self {
        self.negativePrefix = prefix
        return self
    }
    
    func negativeSuffix(_ suffix: String = "") -> Self {
        self.negativeSuffix = suffix
        return self
    }
    
    func positiveFormat(_ format: String = kNumFormat) -> Self {
        self.positiveFormat = format
        return self
    }
    
    func negativeFormat(_ format: String) -> Self {
        self.negativeFormat = format
        return self
    }

    func paddingCharacter(_ character: String) -> Self {
        self.paddingCharacter = character
        return self
    }
}

public extension String.StringInterpolation {
    /// 插值 NumberFormatter
    mutating func appendInterpolation(_ obj: Any?, fmt: NumberFormatter) {
        guard let value = fmt.string(for: obj) else { return }
        appendLiteral(value)
    }
}


//MARK: -Number
@objc public extension NSNumber{
    
    var decNumer: NSDecimalNumber {
        return NSDecimalNumber(decimal: self.decimalValue)
    }
     
    /// 获取对应的字符串
    func toString(_ max: Int = 2) -> String{
        let result = NumberFormatter.fractionDigits(obj: CGFloat(self.floatValue), min: 2, max: max, roundingMode: .up)
        return result ?? ""
    }
  
}


