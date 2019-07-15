
//
//  NSObject+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

extension NSObject{
    
    public var runtimeKey: UnsafeRawPointer {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! UnsafeRawPointer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }

    /// 带有命名空间的类名
    public func BNClassName(_ className: String) -> AnyClass {
        let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String;
        let cls : AnyClass = NSClassFromString(appName + "." + className)!;
        return cls;
    }
    
    /// nsRange范围子字符串差异华显示
//    @objc public func attString(_ text: String!, nsRange: NSRange) -> NSAttributedString! {
//        assert(text.count > (nsRange.location + nsRange.length))
//
//        let attrString = NSMutableAttributedString(string: text)
//
//        let attDict = [NSAttributedString.Key.foregroundColor: UIColor.theme,
//                       NSAttributedString.Key.font:UIFont.systemFont(ofSize: 30),
//                       ]
//        attrString.addAttributes(attDict, range: nsRange)
//        return attrString
//    }
//
//    /// 特定范围子字符串差异华显示
//    @objc public func attString(_ text: String!, offsetStart: Int, offsetEnd: Int) -> NSAttributedString! {
//        let nsRange = NSRange(location: offsetStart, length: (text.count - offsetStart - offsetEnd))
//        let attrString = attString(text, nsRange: nsRange)
//        return attrString
//    }
//
//    /// 字符串差异华显示
//    @objc public func attString(_ text: String!, textSub: String) -> NSAttributedString! {
//        let range = text.range(of: textSub)
//        let nsRange = text.nsRange(from: range!)
//        let attrString = attString(text, nsRange: nsRange)
//        return attrString
//    }
//
//    /// 富文本特殊部分设置
//    @objc public func attrDict(_ font: CGFloat, textColor: UIColor) -> Dictionary<NSAttributedString.Key, Any> {
//        let dic = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:font),
//                   NSAttributedString.Key.foregroundColor: textColor];
//        return dic;
//    }
//
//    /// 富文本整体设置
//    @objc public func attrParaDict(_ font: CGFloat, textColor: UIColor, alignment: NSTextAlignment) -> Dictionary<NSAttributedString.Key, Any> {
//        let paraStyle = NSMutableParagraphStyle();
//        paraStyle.lineBreakMode = .byCharWrapping;
//        paraStyle.alignment = alignment;
//
//        let mdic = NSMutableDictionary(dictionary: self.attrDict(font, textColor: textColor));
//        mdic.setObject(paraStyle, forKey:kCTParagraphStyleAttributeName as! NSCopying);
//        return mdic.copy() as! Dictionary<NSAttributedString.Key, Any>;
//    }
    
    ///  富文本只有同字体大小才能计算高度
    @objc public func sizeWithText(_ text: String!, font: CGFloat, width: CGFloat) -> CGSize {
        let attDic = NSAttributedString.paraDict(font, textColor: .black, alignment: .left);
        let options : NSStringDrawingOptions = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)))
        
        var size = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options , attributes: attDic, context: nil).size;
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        return size;
    }
    
    /// 密集小视图的尺寸布局
    public func itemSize(_ items: [String], numberOfRow: Int, width: CGFloat, itemHeight: inout CGFloat, padding: CGFloat = kPadding) -> CGSize {
        let rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1
        let tmp = CGFloat(numberOfRow) - 1.0
        let itemWith = (width - tmp*padding)/CGFloat(numberOfRow)
        itemHeight = itemHeight <= 0.0 ? itemWith : itemHeight
        let height = CGFloat(rowCount) * itemHeight + CGFloat(rowCount) - 1.0 * padding
        let size = CGSize(width: width, height: height)
        return size
    }
    
//    /// [源]富文本
//    @objc public func getAttString(_ text: String!, textTaps: [String]!, font: CGFloat = 16.0, tapFont: CGFloat = 16.0, color: UIColor = .black, tapColor: UIColor, alignment: NSTextAlignment = .left) -> NSAttributedString {
//        let paraDic = attrParaDict(font, textColor: color, alignment: alignment)
//        let attString = NSMutableAttributedString(string: text, attributes: paraDic)
//        textTaps.forEach { ( textTap: String) in
//            let nsRange = (text as NSString).range(of: textTap)
//            let attDic = self.attrDict(font, textColor: tapColor)
//            attString.addAttributes(attDic, range: nsRange)
//        }
//        return attString
//    }
//
    /// 标题前缀差异化显示
    @objc public func getAttringByPrefix(_ prefix: String!, content: String!, isMust: Bool) -> NSAttributedString {
        let string = content.hasPrefix(prefix) == true ? content : prefix + content
        let colorMust = isMust == true ? UIColor.red : UIColor.clear
        let attString = NSAttributedString.attString(string, textTaps: [prefix], font: 15, tapFont: 15, color: .black, tapColor: colorMust, alignment: .left)
        return attString
    }
    
    ///MARK: NSObject转json字符串
    @objc public func jsonValue() -> String! {
        
        if JSONSerialization.isValidJSONObject(self) == false {
            return "";
        }
     
        do {
            let data: Data! = try JSONSerialization.data(withJSONObject: self, options: []);
            let jsonString: String! = String(data: data, encoding: .utf8);
            let string: String! = jsonString.removingPercentEncoding!;
            return string;
        } catch {
            print(error)

        }
        return "";
    }
    
    /// NSObject->NSData
    @objc public func jsonData() -> NSData? {
        var data: NSData?
        
        switch self {
        case is NSData:
            data = (self as! NSData);
            
        case is NSString:
            data = (self as! NSString).data(using: String.Encoding.utf8.rawValue) as NSData?;
            
        case is UIImage:
            
            data = (self as! UIImage).jpegData(compressionQuality: 1.0) as NSData?;
        case is NSDictionary:
            fallthrough
        case is NSArray:
            data = try? JSONSerialization.data(withJSONObject: self, options: []) as NSData?;
            
        default:
            break;
        }
        return data;
    }
    
    /// NSObject->NSString
    @objc public func jsonString() -> String {
        guard let data = self.jsonData() else {
            return "";
        }
        let jsonString: String = String(data: data as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
        return jsonString;
    }
    
    /// NSString/NSData->NSObject/NSDiction/NSArray
    @objc public func objValue() -> NSObject? {
        assert(self.isKind(of: NSString.classForCoder()) || self.isKind(of: NSData.classForCoder()) || self.isKind(of: NSDictionary.classForCoder()) || self.isKind(of: NSArray.classForCoder()))
        
        if self.isKind(of: NSDictionary.classForCoder()) || self.isKind(of: NSArray.classForCoder()) {
            return self;
        }
        
        if let str = self as? NSString {
            do {
                let data = str.data(using: String.Encoding.utf8.rawValue)
                let obj: NSObject = try JSONSerialization.data(withJSONObject: data as Any, options: []) as NSObject;
                return obj;
                
            } catch {
                print(error)
            }
           
        } else if let data = self as? NSData {
            do {
                let obj: NSObject = try JSONSerialization.data(withJSONObject: data as Any, options: []) as NSObject;
                return obj;
                
            } catch {
                print(error)
            }
        }
        return nil;
    }
    
    /// NSString/NSData->NSDictionary
    @objc public func dictValue() -> Dictionary<String, Any>? {
        guard let dic = self.objValue() as? Dictionary<String, Any> else { return nil }
        return dic as Dictionary<String, Any>;
    }
    
    /// NSString/NSData->NSArray
    @objc public func arrayValue() -> [AnyObject]?{
        guard let arr = self.objValue() as? [AnyObject] else { return nil }
        return arr as [AnyObject];
    }
    
     //MARK:数据解析通用化封装
//   public static func modelWithJSONFile(_ fileName: String) -> AnyObject? {
//
//        let jsonString = fileName.jsonFileToJSONString();
//        let rootModel = Mapper<self.classForCoder()>().map(JSONString: jsonString);
//        return rootModel;
//    }

}


