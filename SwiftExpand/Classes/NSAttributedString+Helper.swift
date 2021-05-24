//
//  NSAttributedString+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/7/15.
//

import SwiftChain

@objc public extension NSAttributedString{
    ///获取所有的 [Range: NSAttributedString] 集合
    var rangeSubAttStringDic: [String: NSAttributedString] {
        var dic = [String: NSAttributedString]()
        enumerateAttributes(in: NSMakeRange(0, self.length), options: .longestEffectiveRangeNotRequired) { (attrs, range, _) in
            let sub = self.attributedSubstring(from: range)
            dic[NSStringFromRange(range)] = sub
        }
        return dic;
    }
    
    /// 富文本特殊部分配置字典
    static func attrDict(_ font: UIFont = UIFont.systemFont(ofSize:15), textColor: UIColor = .theme) -> [NSAttributedString.Key: Any] {
        let dic: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .backgroundColor: UIColor.clear,
        ];
        return dic;
    }
    
    /// 富文本整体设置
    static func paraDict(_ font: UIFont = UIFont.systemFont(ofSize:15),
                         textColor: UIColor = .theme,
                         alignment: NSTextAlignment = .left,
                         lineSpacing: CGFloat = 0,
                         lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> [NSAttributedString.Key: Any] {
        let paraStyle = NSMutableParagraphStyle()
            .lineBreakModeChain(lineBreakMode)
            .lineSpacingChain(lineSpacing)
            .alignmentChain(alignment)

        var dic = attrDict(font, textColor: textColor)
        dic[NSAttributedString.Key.paragraphStyle] = paraStyle
        return dic
    }
    
    /// [源]富文本
    static func attString(_ text: String,
                          textTaps: [String],
                          font: CGFloat = 15,
                          tapFont: CGFloat = 15,
                          color: UIColor = .black,
                          tapColor: UIColor = .theme,
                          alignment: NSTextAlignment = .left,
                          lineSpacing: CGFloat = 0,
                          lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                          rangeOptions mask: NSString.CompareOptions = []) -> NSAttributedString {
        let paraDic = paraDict(UIFont.systemFont(ofSize: font), textColor: color, alignment: alignment, lineSpacing: lineSpacing, lineBreakMode: lineBreakMode)
        let attString = NSMutableAttributedString(string: text, attributes: paraDic)
        textTaps.forEach { ( textTap: String) in
            let nsRange = (text as NSString).range(of: textTap, options: mask)
            let attDic = attrDict(UIFont.systemFont(ofSize: tapFont), textColor: tapColor)
            attString.addAttributes(attDic, range: nsRange)
        }
        return attString
    }
    
    /// [源]富文本二
    static func createAttString(_ text: String,
                                textTaps: [String],
                                font: UIFont = UIFont.systemFont(ofSize: 15),
                                tapFont: UIFont = UIFont.systemFont(ofSize: 15),
                                color: UIColor = .black,
                                tapColor: UIColor = .theme,
                                alignment: NSTextAlignment = .left,
                                lineSpacing: CGFloat = 0,
                                lineBreakMode: NSLineBreakMode = .byTruncatingTail,
                                rangeOptions mask: NSString.CompareOptions = []) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
            .lineBreakModeChain(lineBreakMode)
            .lineSpacingChain(lineSpacing)
            .alignmentChain(alignment)

        let attDic: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
            .backgroundColor: UIColor.clear,
            .paragraphStyle: paraStyle,
        ];
        
        let attString = NSMutableAttributedString(string: text, attributes: attDic)
        textTaps.forEach { ( textTap: String) in
            let nsRange = (text as NSString).range(of: textTap, options: mask)

            let attDic: [NSAttributedString.Key: Any] = [
                .font: tapFont,
                .foregroundColor: tapColor,
                .backgroundColor: UIColor.clear,
            ];
            attString.addAttributes(attDic, range: nsRange)
        }
        return attString
    }
        
    /// 特定范围子字符串差异华显示
    static func attString(_ text: String, offsetStart: Int, offsetEnd: Int) -> NSAttributedString {
        let nsRange = NSRange(location: offsetStart, length: (text.count - offsetStart - offsetEnd))
        let attrString = attString(text, nsRange: nsRange)
        return attrString
    }
    
    /// 字符串差异华显示
    static func attString(_ text: String, textSub: String) -> NSAttributedString {
        let range = text.range(of: textSub)
        let nsRange = text.nsRange(from: range!)
        let attrString = attString(text, nsRange: nsRange)
        return attrString
    }
    
    /// nsRange范围子字符串差异华显示
    static func attString(_ text: String, nsRange: NSRange, font: CGFloat = 15, textColor: UIColor = UIColor.theme) -> NSAttributedString {
        assert((nsRange.location + nsRange.length) <= text.count)
        
        let attDict = [NSAttributedString.Key.foregroundColor: textColor,
                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: font),
        ]
        
        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes(attDict, range: nsRange)
        return attrString
    }
    
    ///  富文本只有同字体大小才能计算高度
    func size(with width: CGFloat) -> CGSize {
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil).size;
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        return size;
    }
    
}

public extension NSAttributedString{
    convenience init(data: Data, documentType: DocumentType, encoding: String.Encoding = .utf8) throws {
        try self.init(data: data,
                      options: [.documentType: documentType,
                                .characterEncoding: encoding.rawValue],
                      documentAttributes: nil)
    }
    convenience init(html data: Data) throws {
        try self.init(data: data, documentType: .html)
    }
    convenience init(txt data: Data) throws {
        try self.init(data: data, documentType: .plain)
    }
    convenience init(rtf data: Data) throws {
        try self.init(data: data, documentType: .rtf)
    }
    convenience init(rtfd data: Data) throws {
        try self.init(data: data, documentType: .rtfd)
    }
    
    func attributes(at index: Int) -> (NSRange, [NSAttributedString.Key: Any]) {
        var nsRange = NSMakeRange(0, 0)
        let dic = attributes(at: index, effectiveRange: &nsRange)
        return (nsRange, dic)
    }
}

// MARK: - Operators

public extension NSAttributedString {
    /// Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
    
    /// Add a NSAttributedString to another NSAttributedString.
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    /// Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
    
    /// Add a NSAttributedString to another NSAttributedString.
    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs += NSAttributedString(string: rhs)
    }
}

public extension NSMutableAttributedString{
    ///获取或者替换某一段NSAttributedString
    subscript(index: NSInteger) -> NSAttributedString?{
        get {
            let keys = rangeSubAttStringDic.keys.sorted()
            if index < 0 || index >= keys.count {
                return nil
            }
            let key = keys[index]
            return rangeSubAttStringDic[key]
        }
        set {
            guard let newValue = newValue else { return }
            let keys = rangeSubAttStringDic.keys.sorted()
            if index < 0 || index >= keys.count {
                return
            }
            let key = keys[index]
            replaceCharacters(in: NSRangeFromString(key), with: newValue)
        }
    }
    
    /// 字符串添加前缀
    func insertPrefix(_ prefix: String = kAsterisk, prefixColor: UIColor = UIColor.red, font: UIFont) -> Self{
        let attr = NSAttributedString(string: prefix,
                                      attributes: [NSAttributedString.Key.foregroundColor: prefixColor,
                                                   NSAttributedString.Key.font: font
                                      ])
        self.insert(attr, at: 0)
        return self
    }
    
    
    /// 字符串添加后缀
    func appendSuffix(_ suffix: String = kAsterisk, prefixColor: UIColor = UIColor.red, font: UIFont) -> Self{
        let attr = NSAttributedString(string: suffix,
                                      attributes: [NSAttributedString.Key.foregroundColor: prefixColor,
                                                   NSAttributedString.Key.font: font
                                      ])
        self.append(attr)
        return self
    }
}


public extension String {
    
    /// -> NSMutableAttributedString
    var matt: NSMutableAttributedString{
        return NSMutableAttributedString(string: self)
    }
    
}


@objc public extension NSAttributedString {
    
    /// -> NSMutableAttributedString
    var matt: NSMutableAttributedString{
        return NSMutableAttributedString(attributedString: self)
    }
    
}
