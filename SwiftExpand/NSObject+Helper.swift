
//
//  NSObject+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension NSObject{
    
    var runtimeKey: UnsafeRawPointer {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! UnsafeRawPointer
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }

    /// 类的字符串名称
    @objc static var identifier: String {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? String;
            if obj == nil {
                obj = String(describing: self);// return "\(type(of: self))"
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 带有命名空间的类名
    func NNClassFromName(_ className: String) -> AnyClass {
        let appName = Bundle.main.infoDictionary!["CFBundleName"] as! String;
        let cls : AnyClass = NSClassFromString(appName + "." + className)!;
        return cls;
    }
    
    /// nsRange范围子字符串差异华显示
//    @objc func attString(_ text: String!, nsRange: NSRange) -> NSAttributedString! {
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
//    @objc func attString(_ text: String!, offsetStart: Int, offsetEnd: Int) -> NSAttributedString! {
//        let nsRange = NSRange(location: offsetStart, length: (text.count - offsetStart - offsetEnd))
//        let attrString = attString(text, nsRange: nsRange)
//        return attrString
//    }
//
//    /// 字符串差异华显示
//    @objc func attString(_ text: String!, textSub: String) -> NSAttributedString! {
//        let range = text.range(of: textSub)
//        let nsRange = text.nsRange(from: range!)
//        let attrString = attString(text, nsRange: nsRange)
//        return attrString
//    }
//
//    /// 富文本特殊部分设置
//    @objc func attrDict(_ font: CGFloat, textColor: UIColor) -> Dictionary<NSAttributedString.Key, Any> {
//        let dic = [NSAttributedString.Key.font:UIFont.systemFont(ofSize:font),
//                   NSAttributedString.Key.foregroundColor: textColor];
//        return dic;
//    }
//
//    /// 富文本整体设置
//    @objc func attrParaDict(_ font: CGFloat, textColor: UIColor, alignment: NSTextAlignment) -> Dictionary<NSAttributedString.Key, Any> {
//        let paraStyle = NSMutableParagraphStyle();
//        paraStyle.lineBreakMode = .byCharWrapping;
//        paraStyle.alignment = alignment;
//
//        let mdic = NSMutableDictionary(dictionary: self.attrDict(font, textColor: textColor));
//        mdic.setObject(paraStyle, forKey:kCTParagraphStyleAttributeName as! NSCopying);
//        return mdic.copy() as! Dictionary<NSAttributedString.Key, Any>;
//    }
    
    ///  富文本只有同字体大小才能计算高度
    @objc func sizeWithText(_ text: String!, font: CGFloat = 15, width: CGFloat) -> CGSize {
        let attDic = NSAttributedString.paraDict(font, textColor: .black, alignment: .left);
        let options : NSStringDrawingOptions = NSStringDrawingOptions(rawValue: NSStringDrawingOptions.RawValue(UInt8(NSStringDrawingOptions.usesLineFragmentOrigin.rawValue) | UInt8(NSStringDrawingOptions.usesFontLeading.rawValue)))
        
        var size = text.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options , attributes: attDic, context: nil).size;
        size.width = ceil(size.width);
        size.height = ceil(size.height);
        return size;
    }
    
    /// 密集小视图的尺寸布局
    @objc func itemSize(_ items: [String], numberOfRow: Int, width: CGFloat = UIScreen.width, itemHeight: CGFloat = 60, padding: CGFloat = kPadding) -> CGSize {
        let rowCount = items.count % numberOfRow == 0 ? items.count/numberOfRow : items.count/numberOfRow + 1
//        let tmp = CGFloat(numberOfRow) - 1.0
//        let itemWith = (width - tmp*padding)/CGFloat(numberOfRow)
//        let tmpHeight = itemHeight <= 0.0 ? itemWith : itemHeight;
        let height = CGFloat(rowCount) * itemHeight + CGFloat(rowCount) - 1.0 * padding
        let size = CGSize(width: width, height: height)
        return size
    }
    
//    /// [源]富文本
//    @objc func getAttString(_ text: String!, textTaps: [String]!, font: CGFloat = 16.0, tapFont: CGFloat = 16.0, color: UIColor = .black, tapColor: UIColor, alignment: NSTextAlignment = .left) -> NSAttributedString {
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
    @objc func getAttringByPrefix(_ prefix: String!, content: String!, isMust: Bool = false) -> NSAttributedString {
        let string = content.hasPrefix(prefix) == true ? content : prefix + content
        let colorMust = isMust == true ? UIColor.red : UIColor.clear
        let attString = NSAttributedString.attString(string, textTaps: [prefix], font: 15, tapFont: 15, color: .black, tapColor: colorMust, alignment: .left)
        return attString
    }
    
    ///MARK: NSObject转json字符串
    @objc func jsonValue() -> String! {
        
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
    @objc func jsonData() -> NSData? {
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
    @objc func jsonString() -> String {
        guard let data = self.jsonData() else {
            return "";
        }
        let jsonString: String = String(data: data as Data, encoding: String.Encoding(rawValue: String.Encoding.utf8.rawValue)) ?? ""
        return jsonString;
    }
    
    /// NSString/NSData->NSObject/NSDiction/NSArray
    @objc func objValue() -> NSObject? {
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
    @objc func dictValue() -> Dictionary<String, Any>? {
        guard let dic = self.objValue() as? Dictionary<String, Any> else { return nil }
        return dic as Dictionary<String, Any>;
    }
    
    /// NSString/NSData->NSArray
    @objc func arrayValue() -> [AnyObject]?{
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


