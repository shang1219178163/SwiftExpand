//
//  NSAttributedString+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/7/15.
//

import UIKit

@objc public extension NSAttributedString {
        
    func addAttributes(_ attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
        let mattr = NSMutableAttributedString(attributedString: self)
        mattr.addAttributes(attributes, range: NSMakeRange(0, self.length))
        return mattr
    }
    
    func font(_ font: UIFont) -> NSAttributedString {
        return addAttributes([NSAttributedString.Key.font: font])
    }
    
    func color(_ color: UIColor) -> NSAttributedString {
        return addAttributes([NSAttributedString.Key.foregroundColor: color])
    }
    
    func bgColor(_ color: UIColor) -> NSAttributedString {
        return addAttributes([NSAttributedString.Key.backgroundColor: color])
    }
    
    func link(_ value: String) -> NSAttributedString {
        return linkURL(URL(string: value)!)
    }
    
    func linkURL(_ value: URL) -> NSAttributedString {
        return addAttributes([NSAttributedString.Key.link: value])
    }
    //设置字体倾斜度，取值为float，正值右倾，负值左倾
    func oblique(_ value: CGFloat = 0.1) -> NSAttributedString {
        return addAttributes([NSAttributedString.Key.obliqueness: value])
    }
       
    //字符间距
    func kern(_ value: CGFloat) -> NSAttributedString {
        return addAttributes([.kern: value])
    }
    
    //设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
    func expansion(_ value: CGFloat) -> NSAttributedString {
        return addAttributes([.expansion: value])
    }
    
    //设置下划线
    func underline(_ color: UIColor, _ style: NSUnderlineStyle = .single) -> NSAttributedString {
        return addAttributes([
            .underlineColor: color,
            .underlineStyle: style.rawValue
        ])
    }
    
    //设置删除线
    func strikethrough(_ color: UIColor, _ style: NSUnderlineStyle = .single) -> NSAttributedString {
        return addAttributes([
            .strikethroughColor: color,
            .strikethroughStyle: style.rawValue,
        ])
    }
    
    ///设置基准位置 (正上负下)
    func baseline(_ value: CGFloat) -> NSAttributedString {
        return addAttributes([.baselineOffset: value])
    }
    
    ///设置段落
    func paraStyle(_ alignment: NSTextAlignment,
                          lineSpacing: CGFloat = 0,
                          paragraphSpacingBefore: CGFloat = 0,
                          lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSAttributedString {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        style.paragraphSpacingBefore = paragraphSpacingBefore
        return addAttributes([.paragraphStyle: style])
    }
        
    ///设置段落
    func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
        return addAttributes([.paragraphStyle: style])
    }
}

@objc public extension NSAttributedString{
    ///获取所有的 [Range: NSAttributedString] 集合
    var rangeSubAttStringDic: [String: NSAttributedString]{
        get{
            var dic = [String: NSAttributedString]()
            enumerateAttributes(in: NSMakeRange(0, self.length), options: .longestEffectiveRangeNotRequired) { (attrs, range, _) in
                let sub = self.attributedSubstring(from: range)
                dic[NSStringFromRange(range)] = sub
            }
            return dic;
        }
    }
                
    /// 富文本特殊部分配置字典
    static func attrDict(_ font: CGFloat = 15, textColor: UIColor = .theme) -> [NSAttributedString.Key: Any] {
        let dic = [NSAttributedString.Key.font: UIFont.systemFont(ofSize:font),
                   NSAttributedString.Key.foregroundColor: textColor,
                   NSAttributedString.Key.backgroundColor: UIColor.clear,
                   ];
        return dic;
    }
    
    /// 富文本整体设置
    static func paraDict(_ font: CGFloat = 15,
                         textColor: UIColor = .theme,
                         alignment: NSTextAlignment = .left,
                         lineSpacing: CGFloat = 0,
                         lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> [NSAttributedString.Key: Any] {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = lineBreakMode
        paraStyle.lineSpacing = lineSpacing
        paraStyle.alignment = alignment

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
        let paraDic = paraDict(font, textColor: color, alignment: alignment, lineSpacing: lineSpacing, lineBreakMode: lineBreakMode)
        let attString = NSMutableAttributedString(string: text, attributes: paraDic)
        textTaps.forEach { ( textTap: String) in
            let nsRange = (text as NSString).range(of: textTap, options: mask)
            let attDic = attrDict(tapFont, textColor: tapColor)
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
        paraStyle.lineSpacing = lineSpacing
        paraStyle.lineBreakMode = lineBreakMode
        paraStyle.alignment = alignment

        let attDic = [NSAttributedString.Key.font: font,
                      NSAttributedString.Key.foregroundColor: color,
                      NSAttributedString.Key.backgroundColor: UIColor.clear,
                      NSAttributedString.Key.paragraphStyle: paraStyle,
                    ];
        
        let attString = NSMutableAttributedString(string: text, attributes: attDic)
        textTaps.forEach { ( textTap: String) in
            let nsRange = (text as NSString).range(of: textTap, options: mask)

            let attDic = [NSAttributedString.Key.font: tapFont,
                          NSAttributedString.Key.foregroundColor: tapColor,
                          NSAttributedString.Key.backgroundColor: UIColor.clear,
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
        
        let attrString = NSMutableAttributedString(string: text)
        
        let attDict = [NSAttributedString.Key.foregroundColor: textColor,
                       NSAttributedString.Key.font: UIFont.systemFont(ofSize: font),
        ]
        attrString.addAttributes(attDict, range: nsRange)
        return attrString
    }
    
    ///  富文本只有同字体大小才能计算高度
    func size(_ width: CGFloat) -> CGSize {
        let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
         
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, context: nil).size;
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
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add.
    ///   - rhs: NSAttributedString to add.
    /// - Returns: New instance with added NSAttributedString.
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        return NSAttributedString(attributedString: string)
    }
    
    /// Add a NSAttributedString to another NSAttributedString.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add to.
    ///   - rhs: NSAttributedString to add.
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        let string = NSMutableAttributedString(attributedString: lhs)
        string.append(rhs)
        lhs = string
    }

    /// Add a NSAttributedString to another NSAttributedString and return a new NSAttributedString instance.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add.
    ///   - rhs: String to add.
    /// - Returns: New instance with added NSAttributedString.
    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + NSAttributedString(string: rhs)
    }
    
    /// Add a NSAttributedString to another NSAttributedString.
    ///
    /// - Parameters:
    ///   - lhs: NSAttributedString to add to.
    ///   - rhs: String to add.
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
    
    ///添加
    func append(_ string: String, attributes attrs: [NSAttributedString.Key: Any]? = nil) -> NSMutableAttributedString{
        self.append(NSAttributedString(string: string, attributes: attrs))
        return self
    }
    
    

}
