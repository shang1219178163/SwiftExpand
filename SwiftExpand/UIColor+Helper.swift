
//
//  UIColor+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/24.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

extension UIColor{
    
    //MARK: - -属性
    @objc public static var random : UIColor {
        get{
            return UIColor.randomColor();
        }
    }
    
    @objc public static var theme : UIColor {
        get{
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIColor;
            obj = obj ?? UIColorHexValue(0x0082e0)
            return obj!;
        }
        set{
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
        
    @objc public static var background : UIColor {
        get{
            return UIColorHexValue(0xe9e9e9);
        }
    }
    
    @objc public static var line : UIColor {
        get{
            return UIColorHexValue(0xe0e0e0);
        }
    }
    
    @objc public static var btnN : UIColor {
        get{
            return UIColorHexValue(0xfea914);
        }
    }
    
    @objc public static var btnH : UIColor {
        get{
            return UIColorHexValue(0xf1a013);
        }
    }
    
    @objc public static var btnD : UIColor {
        get{
            return UIColorHexValue(0x999999);
        }
    }
    
    @objc public static var excel : UIColor {
        get{
            return UIColor(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0);
        }
    }
    
    //MARK:  -项目定制
    @objc public static var textColorTitle : UIColor {
        get{
            return UIColorHexValue(0x333333);
        }
    }
    
    @objc public static var textColorSub : UIColor {
        get{
            return UIColorHexValue(0x999999);
        }
    }
    
    //MARK: - -方法
    @objc public static func hex(_ hex:String) -> UIColor {
        return UIColor.hex(hex, a: 1.0);
    }
    
    /// [源]十六进制颜色字符串
    @objc public static func hex(_ hex: String, a: CGFloat = 1.0) -> UIColor {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespaces).uppercased();
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy:1);
            cString = String(cString[index...]);
        }
        
        if cString.count != 6 {
            return .red;
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2);
        let rString = String(cString[..<rIndex]);
        
        let otherString = String(cString[rIndex...]);
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2);
        let gString = String(otherString[..<gIndex]);
        
        let bIndex = cString.index(cString.endIndex, offsetBy: -2);
        let bString = String(cString[bIndex...]);
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r);
        Scanner(string: gString).scanHexInt32(&g);
        Scanner(string: bString).scanHexInt32(&b);
        
        //        print(hex,rString,gString,bString,otherString)
        return UIColor(red:CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a);
    }
    
    @objc public static func randomColor() -> UIColor {
        let r = arc4random_uniform(256);
        let g = arc4random_uniform(256);
        let b = arc4random_uniform(256);
        return UIColor(red:CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1.0));
    }
    
    
    /// 两个颜色是否相等
    @objc public func equalTo(_ c2: UIColor) -> Bool{
        // some kind of weird rounding made the colors unequal so had to compare like this
        let c1 = self;
        var red:CGFloat = 0
        var green:CGFloat  = 0
        var blue:CGFloat = 0
        var alpha:CGFloat  = 0
        c1.getRed(&red, green: &green, blue: &blue, alpha: &alpha)
        
        var red2:CGFloat = 0
        var green2:CGFloat  = 0
        var blue2:CGFloat = 0
        var alpha2:CGFloat  = 0
        c2.getRed(&red2, green: &green2, blue: &blue2, alpha: &alpha2)
        
        return (Int(red*255) == Int(red*255) && Int(green*255) == Int(green2*255) && Int(blue*255) == Int(blue*255))
    }
}

