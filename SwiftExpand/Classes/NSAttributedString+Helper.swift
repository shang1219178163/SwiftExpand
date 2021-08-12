//
//  NSAttributedString+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/7/15.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Foundation

@objc public extension NSAttributedString{
    ///获取所有的 [Range: NSAttributedString] 集合
    var rangeSubAttStringDic: [String: NSAttributedString] {
        var dic = [String: NSAttributedString]()
        enumerateAttributes(in: NSMakeRange(0, self.length), options: .longestEffectiveRangeNotRequired) { (attrs, range, _) in
            let sub = self.attributedSubstring(from: range)
            dic[NSStringFromRange(range)] = sub
        }
        return dic
    }
        
    /// 富文本段落设置
    static func paraDict(_ font: Font = Font.systemFont(ofSize:15), textColor: Color = .theme, alignment: NSTextAlignment = .left, lineSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping) -> [NSAttributedString.Key: Any] {
        let paraStyle = NSMutableParagraphStyle()
            .lineBreakModeChain(lineBreakMode)
            .lineSpacingChain(lineSpacing)
            .alignmentChain(alignment)

        let dic: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: textColor,
            .backgroundColor: Color.clear,
            .paragraphStyle: paraStyle,
        ]
        return dic
    }
    
    /// 创建富文本
    static func createAttString(_ text: String, textTaps: [String], font: Font = Font.systemFont(ofSize: 15), tapFont: Font = Font.systemFont(ofSize: 15), color: Color = .black, tapColor: Color = .theme, alignment: NSTextAlignment = .left, lineSpacing: CGFloat = 0, lineBreakMode: NSLineBreakMode = .byWordWrapping, rangeOptions mask: NSString.CompareOptions = []) -> NSAttributedString {
        let paraDic = paraDict(font, textColor: color, alignment: alignment, lineSpacing: lineSpacing, lineBreakMode: lineBreakMode)
        
        let linkDic: [NSAttributedString.Key: Any] = [
            .font: tapFont,
            .foregroundColor: tapColor,
            .backgroundColor: Color.clear,
        ]

        let attString = NSMutableAttributedString(string: text, attributes: paraDic)
        for e in textTaps {
            let nsRange = (attString.string as NSString).range(of: e, options: mask)
            attString.addAttributes(linkDic, range: nsRange)
        }
        return attString
    }
    
    /// 创建超链接富文本
    static func createLink(_ text: String, linkDic: [String: String], font: Font) -> NSMutableAttributedString {
        let attDic: [NSAttributedString.Key: Any] = [
            .font: font as Any
        ]
        let mattString = NSMutableAttributedString(string: text, attributes: attDic)
        linkDic.forEach { e in
            let linkAttDic: [NSAttributedString.Key: Any] = [
                .font: font,
                .foregroundColor: Color.blue,
                .link: e.value,
                .underlineStyle: NSUnderlineStyle.single.rawValue,
            ]
            
            let attStr = NSAttributedString(string: e.key, attributes: linkAttDic)
            let range = (mattString.string as NSString).range(of: e.key)
            mattString.replaceCharacters(in: range, with: attStr)
        }
        return mattString
    }
    
    /// nsRange范围子字符串差异华显示
    static func attString(_ text: String, nsRange: NSRange, font: Font = Font.systemFont(ofSize: 15), tapColor: Color = .theme) -> NSAttributedString {
        assert((nsRange.location + nsRange.length) <= text.count)

        let attDic: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: tapColor,
        ]

        let attrString = NSMutableAttributedString(string: text)
        attrString.addAttributes(attDic, range: nsRange)
        return attrString
    }
    
    ///  富文本只有同字体大小才能计算高度
    func size(with width: CGFloat) -> CGSize {
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)),
                                     options: [.usesLineFragmentOrigin, .usesFontLeading],
                                     context: nil).size
        size.width = ceil(size.width)
        size.height = ceil(size.height)
        return size
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
    func appendPrefix(_ prefix: String = kAsterisk, color: Color = Color.red, font: Font) -> Self{
        guard let range = self.string.range(of: prefix) else {
            let attr = NSAttributedString(string: prefix,
                                          attributes: [NSAttributedString.Key.foregroundColor: color,
                                                       NSAttributedString.Key.font: font
                                          ])
            self.insert(attr, at: 0)
            return self
        }

        let nsRange = NSRange(range, in: self.string)
        addAttributes([NSAttributedString.Key.foregroundColor: color,
                       NSAttributedString.Key.font: font
        ], range: nsRange)
        return self
    }
    
    /// 字符串添加后缀
    func appendSuffix(_ suffix: String = kAsterisk, color: Color = Color.red, font: Font) -> Self{
        guard let range = self.string.range(of: suffix, options: .backwards) else {
            let attr = NSAttributedString(string: suffix,
                                          attributes: [NSAttributedString.Key.foregroundColor: color,
                                                       NSAttributedString.Key.font: font
                                          ])
            self.append(attr)
            return self
        }
        
        let nsRange = NSRange(range, in: self.string)
        addAttributes([NSAttributedString.Key.foregroundColor: color,
                       NSAttributedString.Key.font: font
        ], range: nsRange)
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



//属性链式编程实现
@objc public extension NSMutableAttributedString {
    
    func fontChain(_ font: Font) -> Self {
        addAttributes([NSAttributedString.Key.font: font], range: NSMakeRange(0, self.length))
        return self
    }
    
    func foregroundColorChain(_ color: Color) -> Self {
        addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func backgroundColorChain(_ color: Color) -> Self {
        addAttributes([NSAttributedString.Key.backgroundColor: color], range: NSMakeRange(0, self.length))
        return self
    }
    
    func linkChain(_ value: String) -> Self {
        return linkURLChain(URL(string: value)!)
    }
    
    func linkURLChain(_ value: URL) -> Self {
        addAttributes([NSAttributedString.Key.link: value], range: NSMakeRange(0, self.length))
        return self
    }
    //设置字体倾斜度，取值为float，正值右倾，负值左倾
    func obliqueChain(_ value: CGFloat = 0.1) -> Self {
        addAttributes([NSAttributedString.Key.obliqueness: value], range: NSMakeRange(0, self.length))
        return self
    }
       
    //字符间距
    func kernChain(_ value: CGFloat) -> Self {
        addAttributes([.kern: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
    func expansionChain(_ value: CGFloat) -> Self {
        addAttributes([.expansion: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置下划线
    func underlineChain(_ style: NSUnderlineStyle = .single, _ color: Color) -> Self {
        addAttributes([
            .underlineColor: color,
            .underlineStyle: style.rawValue
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func strikethroughChain(_ style: NSUnderlineStyle = .single, _ color: Color) -> Self {
        addAttributes([
            .strikethroughColor: color,
            .strikethroughStyle: style.rawValue,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    //设置删除线
    func strokeChain(_ color: Color, _ value: CGFloat = 0) -> Self {
        addAttributes([
            .strokeColor: color,
            .strokeWidth: value,
        ], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置基准位置 (正上负下)
    func baselineChain(_ value: CGFloat) -> Self {
        addAttributes([.baselineOffset: value], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置段落
    func paraStyleChain(_ alignment: NSTextAlignment,
                   lineSpacing: CGFloat = 0,
                   paragraphSpacingBefore: CGFloat = 0,
                   lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> Self {
        let style = NSMutableParagraphStyle()
        style.alignment = alignment
        style.lineBreakMode = lineBreakMode
        style.lineSpacing = lineSpacing
        style.paragraphSpacingBefore = paragraphSpacingBefore
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
        
    ///设置段落
    func paragraphStyleChain(_ style: NSMutableParagraphStyle) -> Self {
        addAttributes([.paragraphStyle: style], range: NSMakeRange(0, self.length))
        return self
    }
    
    ///设置段落
    func textAttachmentChain(_ image: Image, scale: CGFloat = 1.0) -> Self {
        #if os(macOS)
            let attachment = NSTextAttachment()
            let size = NSSize(
              width: image.size.width * scale,
              height: image.size.height * scale
            )
            attachment.image = NSImage(size: size, flipped: false, drawingHandler: { (rect: NSRect) -> Bool in
              NSGraphicsContext.current?.cgContext.translateBy(x: 0, y: size.height)
              NSGraphicsContext.current?.cgContext.scaleBy(x: 1, y: -1)
              image.draw(in: rect)
              return true
            })
            
            self.append(NSAttributedString(attachment: attachment))
        #else
        let size = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            let rect = CGRect(x: 0, y: 0, width: size.width, height: size.height)
            UIGraphicsBeginImageContextWithOptions(size, false, scale)
            image.draw(in: rect)
            let newImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            
            let attachment = NSTextAttachment()
            attachment.image = newImage

            self.append(NSAttributedString(attachment: attachment))
        #endif
//        print(#function, rect, size)
        return self
    }
    
    
}



@objc public extension NSMutableParagraphStyle{
    
    func lineSpacingChain(_ value: CGFloat) -> Self {
        self.lineSpacing = value
        return self
    }
    
    func paragraphSpacingChain(_ value: CGFloat) -> Self {
        self.paragraphSpacing = value
        return self
    }
    
    func alignmentChain(_ value: NSTextAlignment) -> Self {
        self.alignment = value
        return self
    }
    
    func firstLineHeadIndentChain(_ value: CGFloat) -> Self {
        self.firstLineHeadIndent = value
        return self
    }
    
    func headIndentChain(_ value: CGFloat) -> Self {
        self.headIndent = value
        return self
    }
    
    func tailIndentChain(_ value: CGFloat) -> Self {
        self.tailIndent = value
        return self
    }
    
    func lineBreakModeChain(_ value: NSLineBreakMode) -> Self {
        self.lineBreakMode = value
        return self
    }
    
    func minimumLineHeightChain(_ value: CGFloat) -> Self {
        self.minimumLineHeight = value
        return self
    }
    
    func maximumLineHeightChain(_ value: CGFloat) -> Self {
        self.maximumLineHeight = value
        return self
    }
    
    func baseWritingDirectionChain(_ value: NSWritingDirection) -> Self {
        self.baseWritingDirection = value
        return self
    }
    
    func lineHeightMultipleChain(_ value: CGFloat) -> Self {
        self.lineHeightMultiple = value
        return self
    }
    
    func paragraphSpacingBeforeChain(_ value: CGFloat) -> Self {
        self.paragraphSpacingBefore = value
        return self
    }
    
    func hyphenationFactorChain(_ value: Float) -> Self {
        self.hyphenationFactor = value
        return self
    }
    
    func tabStopsChain(_ value: [NSTextTab]) -> Self {
        self.tabStops = value
        return self
    }
    
    func defaultTabIntervalChain(_ value: CGFloat) -> Self {
        self.defaultTabInterval = value
        return self
    }
    
    func allowsDefaultTighteningForTruncationChain(_ value: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = value
        return self
    }
    
    func lineBreakStrategyChain(_ value: NSParagraphStyle.LineBreakStrategy) -> Self {
        self.lineBreakStrategy = value
        return self
    }
        
    func addTabStopChain(_ value: NSTextTab) -> Self {
        self.addTabStop(value)
        return self
    }
    
    func removeTabStopChain(_ value: NSTextTab) -> Self {
        self.removeTabStop(value)
        return self
    }
    
    func setParagraphStyleChain(_ value: NSParagraphStyle) -> Self {
        self.setParagraphStyle(value)
        return self
    }
}
