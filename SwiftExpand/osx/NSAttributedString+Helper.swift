//
//  NSAttributedString+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension NSAttributedString{
    
    
    /// 富文本特殊部分配置字典
     static func attrDict(_ font: CGFloat = 15, textColor: NSColor = .theme) -> [NSAttributedString.Key: Any] {
        let dic: [NSAttributedString.Key: Any] = [
            .font: NSFont.systemFont(ofSize:font),
            .foregroundColor: textColor,
            .backgroundColor: NSColor.clear,
        ];
         return dic;
     }
     
     /// 富文本整体设置
     static func paraDict(_ font: CGFloat = 15,
                          textColor: NSColor = .theme,
                          alignment: NSTextAlignment = .left) -> [NSAttributedString.Key: Any] {
         let paraStyle = NSMutableParagraphStyle();
         paraStyle.lineBreakMode = .byCharWrapping;
         paraStyle.alignment = alignment;
         
         let mdic = NSMutableDictionary(dictionary: attrDict(font, textColor: textColor));
         mdic.setObject(paraStyle, forKey:kCTParagraphStyleAttributeName as! NSCopying);
         return mdic.copy() as! [NSAttributedString.Key: Any];
     }
     
     /// [源]富文本
     static func attString(_ text: String!,
                                 textTaps: [String]!,
                                 font: CGFloat = 15,
                                 tapFont: CGFloat = 15,
                                 color: NSColor = .black,
                                 tapColor: NSColor = .theme,
                                 alignment: NSTextAlignment = .left) -> NSAttributedString {
         let paraDic = paraDict(font, textColor: color, alignment: alignment)
         let attString = NSMutableAttributedString(string: text, attributes: paraDic)
         textTaps.forEach { ( textTap: String) in
             let nsRange = (text as NSString).range(of: textTap)
             let attDic = attrDict(tapFont, textColor: tapColor)
             attString.addAttributes(attDic, range: nsRange)
         }
         return attString
     }
     
     /// 特定范围子字符串差异华显示
     static func attString(_ text: String!, offsetStart: Int, offsetEnd: Int) -> NSAttributedString! {
         let nsRange = NSRange(location: offsetStart, length: (text.count - offsetStart - offsetEnd))
         let attrString = attString(text, nsRange: nsRange)
         return attrString
     }
     
     /// 字符串差异华显示
     static func attString(_ text: String!, textSub: String) -> NSAttributedString! {
         let range = text.range(of: textSub)
         let nsRange = text.nsRange(from: range!)
         let attrString = attString(text, nsRange: nsRange)
         return attrString
     }
     
     /// nsRange范围子字符串差异华显示
     static func attString(_ text: String!, nsRange: NSRange, font: CGFloat = 15, textColor: NSColor = NSColor.theme) -> NSAttributedString! {
         assert(text.count >= (nsRange.location + nsRange.length))
         
         let attDic: [NSAttributedString.Key: Any] = [
            .foregroundColor: textColor,
            .font: NSFont.systemFont(ofSize: font),
         ]
        
        let attrString = NSMutableAttributedString(string: text)
         attrString.addAttributes(attDic, range: nsRange)
         return attrString
     }
    
    static func attrString(_ text: String, font: CGFloat = 14, textColor: NSColor = NSColor.black, alignment: NSTextAlignment = .left) -> NSAttributedString {
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.alignment = alignment;
        
        let attDic: [NSAttributedString.Key: Any] = [
            .font:  NSFont.systemFont(ofSize: font),
            .foregroundColor:  textColor,
            .paragraphStyle:  paraStyle,
        ]
        let attString = NSAttributedString(string: text, attributes: attDic)
        return attString;
    }
    
    ///  富文本只有同字体大小才能计算高度
    func size(_ width: CGFloat) -> CGSize {
        let options: NSString.DrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
        var size = self.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, context: nil).size;
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        return size;
    }
    
    /// 定义超链接文本颜色样式
    static func hyperlink(_ string: String, url: URL, font: CGFloat = 14) -> NSAttributedString {
        let attDic: [NSAttributedString.Key : Any] = [
            .font:  NSFont.systemFont(ofSize: font),
            .foregroundColor:  NSColor.blue,
            .link:  url.absoluteURL,
            .underlineStyle:  NSUnderlineStyle.single.rawValue,
//              .baselineOffset:  15,
            ]
        
        let attString = NSMutableAttributedString(string: string)
        attString.beginEditing()
        attString.addAttributes(attDic, range: NSMakeRange(0, attString.length))
        attString.endEditing()
        return attString;
    }
    /// 包含超链接的全部内容
    static func hyperlink(dic: [String : String], text: String, font: NSFont) -> NSMutableAttributedString {
        let attDic: [NSAttributedString.Key : Any] = [.font: font as Any]
        let mattStr = NSMutableAttributedString(string: text, attributes: attDic)
        for e in dic {
            let url = URL(string: e.value)
            let attStr = NSAttributedString.hyperlink(e.key, url: url!, font: font.pointSize)
            let range = (mattStr.string as NSString).range(of: e.key)
            mattStr.replaceCharacters(in: range, with: attStr)
        }
        return mattStr;
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


