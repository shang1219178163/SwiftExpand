
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
   
    
//    func digits(_ miniIntegerDigits: Int = 1,
//                      minFractionDigits: Int = 2,
//                      maxFractionDigits: Int = 2) -> Self {
//        minimumIntegerDigits = miniIntegerDigits
//        minimumFractionDigits = minFractionDigits
//        maximumFractionDigits = maxFractionDigits
//        return self
//    }
//    
//    func formatGroup(_ groupingSeparator: String = ",",
//                     groupingSize: Int = 3) -> Self {
//        self.usesGroupingSeparator = true //分隔设true
//        self.groupingSeparator = groupingSeparator //分隔符
//        self.groupingSize = groupingSize  //分隔位数
//        return self
//    }
//    // MARK: -chain
//
//    func numberStyleChain(_ numberStyle: NumberFormatter.Style) -> Self {
//        self.numberStyle = numberStyle
//        return self
//    }
//
//    func localeChain(_ locale: Locale!) -> Self {
//        self.locale = locale
//        return self
//    }
//
//    func generatesDecimalNumbersChain(_ generatesDecimalNumbers: Bool) -> Self {
//        self.generatesDecimalNumbers = generatesDecimalNumbers
//        return self
//    }
//
//    func formatterBehaviorChain(_ formatterBehavior: NumberFormatter.Behavior) -> Self {
//        self.formatterBehavior = formatterBehavior
//        return self
//    }
//
//    func negativeFormatChain(_ negativeFormat: String!) -> Self {
//        self.negativeFormat = negativeFormat
//        return self
//    }
//
//    func textAttributesForNegativeValuesChain(_ textAttributesForNegativeValues: [String : Any]) -> Self {
//        self.textAttributesForNegativeValues = textAttributesForNegativeValues
//        return self
//    }
//
//    func positiveFormatChain(_ positiveFormat: String!) -> Self {
//        self.positiveFormat = positiveFormat
//        return self
//    }
//
//    func textAttributesForPositiveValuesChain(_ textAttributesForPositiveValues: [String : Any]) -> Self {
//        self.textAttributesForPositiveValues = textAttributesForPositiveValues
//        return self
//    }
//
//    func allowsFloatsChain(_ allowsFloats: Bool) -> Self {
//        self.allowsFloats = allowsFloats
//        return self
//    }
//
//    func decimalSeparatorChain(_ decimalSeparator: String!) -> Self {
//        self.decimalSeparator = decimalSeparator
//        return self
//    }
//
//    func alwaysShowsDecimalSeparatorChain(_ alwaysShowsDecimalSeparator: Bool) -> Self {
//        self.alwaysShowsDecimalSeparator = alwaysShowsDecimalSeparator
//        return self
//    }
//
//    func currencyDecimalSeparatorChain(_ currencyDecimalSeparator: String!) -> Self {
//        self.currencyDecimalSeparator = currencyDecimalSeparator
//        return self
//    }
//
//    func usesGroupingSeparatorChain(_ usesGroupingSeparator: Bool) -> Self {
//        self.usesGroupingSeparator = usesGroupingSeparator
//        return self
//    }
//
//    func groupingSeparatorChain(_ groupingSeparator: String!) -> Self {
//        self.groupingSeparator = groupingSeparator
//        return self
//    }
//
//    func zeroSymbolChain(_ zeroSymbol: String?) -> Self {
//        self.zeroSymbol = zeroSymbol
//        return self
//    }
//
//    func textAttributesForZeroChain(_ textAttributesForZero: [String : Any]) -> Self {
//        self.textAttributesForZero = textAttributesForZero
//        return self
//    }
//
//    func nilSymbolChain(_ nilSymbol: String) -> Self {
//        self.nilSymbol = nilSymbol
//        return self
//    }
//
//    func textAttributesForNilChain(_ textAttributesForNil: [String : Any]) -> Self {
//        self.textAttributesForNil = textAttributesForNil
//        return self
//    }
//
//    func notANumberSymbolChain(_ notANumberSymbol: String!) -> Self {
//        self.notANumberSymbol = notANumberSymbol
//        return self
//    }
//
//    func textAttributesForNotANumberChain(_ textAttributesForNotANumber: [String : Any]) -> Self {
//        self.textAttributesForNotANumber = textAttributesForNotANumber
//        return self
//    }
//
//    func positiveInfinitySymbolChain(_ positiveInfinitySymbol: String) -> Self {
//        self.positiveInfinitySymbol = positiveInfinitySymbol
//        return self
//    }
//
//    func textAttributesForPositiveInfinityChain(_ textAttributesForPositiveInfinity: [String : Any]) -> Self {
//        self.textAttributesForPositiveInfinity = textAttributesForPositiveInfinity
//        return self
//    }
//
//    func negativeInfinitySymbolChain(_ negativeInfinitySymbol: String) -> Self {
//        self.negativeInfinitySymbol = negativeInfinitySymbol
//        return self
//    }
//
//    func textAttributesForNegativeInfinityChain(_ textAttributesForNegativeInfinity: [String : Any]) -> Self {
//        self.textAttributesForNegativeInfinity = textAttributesForNegativeInfinity
//        return self
//    }
//
//    func positivePrefixChain(_ positivePrefix: String!) -> Self {
//        self.positivePrefix = positivePrefix
//        return self
//    }
//
//    func positiveSuffixChain(_ positiveSuffix: String!) -> Self {
//        self.positiveSuffix = positiveSuffix
//        return self
//    }
//
//    func negativePrefixChain(_ negativePrefix: String!) -> Self {
//        self.negativePrefix = negativePrefix
//        return self
//    }
//
//    func negativeSuffixChain(_ negativeSuffix: String!) -> Self {
//        self.negativeSuffix = negativeSuffix
//        return self
//    }
//
//    func currencyCodeChain(_ currencyCode: String!) -> Self {
//        self.currencyCode = currencyCode
//        return self
//    }
//
//    func currencySymbolChain(_ currencySymbol: String!) -> Self {
//        self.currencySymbol = currencySymbol
//        return self
//    }
//
//    func internationalCurrencySymbolChain(_ internationalCurrencySymbol: String!) -> Self {
//        self.internationalCurrencySymbol = internationalCurrencySymbol
//        return self
//    }
//
//    func percentSymbolChain(_ percentSymbol: String!) -> Self {
//        self.percentSymbol = percentSymbol
//        return self
//    }
//
//    func perMillSymbolChain(_ perMillSymbol: String!) -> Self {
//        self.perMillSymbol = perMillSymbol
//        return self
//    }
//
//    func minusSignChain(_ minusSign: String!) -> Self {
//        self.minusSign = minusSign
//        return self
//    }
//
//    func plusSignChain(_ plusSign: String!) -> Self {
//        self.plusSign = plusSign
//        return self
//    }
//
//    func exponentSymbolChain(_ exponentSymbol: String!) -> Self {
//        self.exponentSymbol = exponentSymbol
//        return self
//    }
//
//    func groupingSizeChain(_ groupingSize: Int) -> Self {
//        self.groupingSize = groupingSize
//        return self
//    }
//
//    func secondaryGroupingSizeChain(_ secondaryGroupingSize: Int) -> Self {
//        self.secondaryGroupingSize = secondaryGroupingSize
//        return self
//    }
//
//    func multiplierChain(_ multiplier: NSNumber?) -> Self {
//        self.multiplier = multiplier
//        return self
//    }
//
//    func formatWidthChain(_ formatWidth: Int) -> Self {
//        self.formatWidth = formatWidth
//        return self
//    }
//
//    func paddingCharacterChain(_ paddingCharacter: String!) -> Self {
//        self.paddingCharacter = paddingCharacter
//        return self
//    }
//
//    func paddingPositionChain(_ paddingPosition: NumberFormatter.PadPosition) -> Self {
//        self.paddingPosition = paddingPosition
//        return self
//    }
//
//    func roundingModeChain(_ roundingMode: NumberFormatter.RoundingMode) -> Self {
//        self.roundingMode = roundingMode
//        return self
//    }
//
//    func roundingIncrementChain(_ roundingIncrement: NSNumber!) -> Self {
//        self.roundingIncrement = roundingIncrement
//        return self
//    }
//
//    func minimumIntegerDigitsChain(_ minimumIntegerDigits: Int) -> Self {
//        self.minimumIntegerDigits = minimumIntegerDigits
//        return self
//    }
//
//    func maximumIntegerDigitsChain(_ maximumIntegerDigits: Int) -> Self {
//        self.maximumIntegerDigits = maximumIntegerDigits
//        return self
//    }
//
//    func minimumFractionDigitsChain(_ minimumFractionDigits: Int) -> Self {
//        self.minimumFractionDigits = minimumFractionDigits
//        return self
//    }
//
//    func maximumFractionDigitsChain(_ maximumFractionDigits: Int) -> Self {
//        self.maximumFractionDigits = maximumFractionDigits
//        return self
//    }
//
//    func minimumChain(_ minimum: NSNumber?) -> Self {
//        self.minimum = minimum
//        return self
//    }
//
//    func maximumChain(_ maximum: NSNumber?) -> Self {
//        self.maximum = maximum
//        return self
//    }
//
//    func currencyGroupingSeparatorChain(_ currencyGroupingSeparator: String!) -> Self {
//        self.currencyGroupingSeparator = currencyGroupingSeparator
//        return self
//    }
//
//    func isLenientChain(_ isLenient: Bool) -> Self {
//        self.isLenient = isLenient
//        return self
//    }
//
//    func usesSignificantDigitsChain(_ usesSignificantDigits: Bool) -> Self {
//        self.usesSignificantDigits = usesSignificantDigits
//        return self
//    }
//
//    func minimumSignificantDigitsChain(_ minimumSignificantDigits: Int) -> Self {
//        self.minimumSignificantDigits = minimumSignificantDigits
//        return self
//    }
//
//    func maximumSignificantDigitsChain(_ maximumSignificantDigits: Int) -> Self {
//        self.maximumSignificantDigits = maximumSignificantDigits
//        return self
//    }
//
//    func isPartialStringValidationEnabledChain(_ isPartialStringValidationEnabled: Bool) -> Self {
//        self.isPartialStringValidationEnabled = isPartialStringValidationEnabled
//        return self
//    }
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
    func toString(_ max: Int = 2) -> String?{
        let fmt = NumberFormatter.format(.currency, minFractionDigits: 0, maxFractionDigits: 2, positivePrefix: "¥", groupingSeparator: ",", groupingSize: 3)
        return fmt.string(for: self)
    }
  
}


