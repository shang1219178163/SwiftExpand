
//
//  Color+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/24.
//  Copyright © 2018年 BN. All rights reserved.
//



@objc public extension Color{
    private struct AssociateKeys {
        static var theme   = "Color" + "theme"
    }
        
    convenience init(r: Int = 0, g: Int = 0, b: Int = 0, a: CGFloat = 1) {
        assert(r >= 0 && r <= 255, "Invalid red component")
        assert(g >= 0 && g <= 255, "Invalid green component")
        assert(b >= 0 && b <= 255, "Invalid blue component")
        self.init(red: CGFloat(r)/255, green: CGFloat(g)/255, blue: CGFloat(b)/255, alpha: a)
    }
    
    /// 获取某种颜色Alpha下的色彩
    func alpha(_ a: CGFloat = 1.0) -> Color{
        return withAlphaComponent(a)
    }
    
    ///判断颜色深浅
    var isDark: Bool{
        var vRed: CGFloat = 0
        var vGreen: CGFloat  = 0
        var vBlue: CGFloat = 0
        var valpha: CGFloat  = 0
        getRed(&vRed, green: &vGreen, blue: &vBlue, alpha: &valpha)
        
        let brightness = 0.299 * vRed + 0.587 * vGreen + 0.114 * vBlue
        let result = (brightness < 0.5)
//        DDLog(result ? "深色" : "浅色")
        return result
    }

    
    //MARK: - -属性    
    static var theme: Color {
        get{
            if let obj = objc_getAssociatedObject(self,  &AssociateKeys.theme) as? Color {
                return obj
            }
            return Color.hexValue(0x0082e0)
        }
        set{
            objc_setAssociatedObject(self,  &AssociateKeys.theme, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    static var random: Color {
        return Color.randomColor();
    }
    
    /// 通用背景色
    static var background: Color {
        return Color.hexValue(0xe9e9e9);
    }
    
    /// 半透明蒙版
    static var dim: Color {
        return Color(white: 0, alpha: 0.2)
    }
    
    /// 线条默认颜色(同cell分割线颜色)
    static var line: Color {
        return Color.hexValue(0xe4e4e4)
    }
    
    static var excel: Color {
        return Color(red: 238/255.0, green: 238/255.0, blue: 238/255.0, alpha: 1.0);
    }
    /// 青蓝
    static var lightBlue: Color {
        return Color.hexValue(0x29B5FE);
    }
    /// 亮橙
    static var lightOrange: Color {
        return Color.hexValue(0xFFBB50);
    }
    /// 浅绿
    static var lightGreen: Color {
        return Color.hexValue(0x1AC756);
    }
    /// 浅红
    static var lightRed: Color {
        return Color.hexValue(0xFA6D5B);
    }
    
    static var textColor3: Color {
        return Color.hexValue(0x333333);
    }
    
    static var textColor6: Color {
        return Color.hexValue(0x666666);
    }
    
    static var textColor9: Color {
        return Color.hexValue(0x999999);
    }
    
    static var textColorExpired: Color {
        return Color.hexValue(0xCCCCCC);
    }
    
    static var placeholder: Color {
        return Color.gray.withAlphaComponent(0.7)
    }

    /// [源]0x开头的16进制Int数字(无#前缀十六进制数表示，开头就是0x)
    static func hexValue(_ hex: Int, a: CGFloat = 1.0) -> Color {
        return Color(red: CGFloat((hex & 0xFF0000) >> 16)/255.0, green: CGFloat((hex & 0xFF00) >> 8)/255.0, blue: CGFloat(hex & 0xFF)/255.0, alpha: a)
    }
    
    /// [源]十六进制颜色字符串
    static func hex(_ hex: String, a: CGFloat = 1.0) -> Color {
        var cString = hex.trimmingCharacters(in: CharacterSet.whitespaces).uppercased()
        if cString.hasPrefix("#") {
            let index = cString.index(cString.startIndex, offsetBy:1)
            cString = String(cString[index...])
        } else if cString.hasPrefix("0X") {
            let index = cString.index(cString.startIndex, offsetBy:2)
            cString = String(cString[index...])
        }
        
        if cString.count != 6 {
            return .red
        }
        
        let rIndex = cString.index(cString.startIndex, offsetBy: 2)
        let rString = String(cString[..<rIndex])
        
        let otherString = String(cString[rIndex...])
        let gIndex = otherString.index(otherString.startIndex, offsetBy: 2)
        let gString = String(otherString[..<gIndex])
        
        let bIndex = cString.index(cString.endIndex, offsetBy: -2)
        let bString = String(cString[bIndex...])
        
        var r: CUnsignedInt = 0, g: CUnsignedInt = 0, b: CUnsignedInt = 0
        Scanner(string: rString).scanHexInt32(&r)
        Scanner(string: gString).scanHexInt32(&g)
        Scanner(string: bString).scanHexInt32(&b)
        
        //        print(hex,rString,gString,bString,otherString)
        return Color(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: a)
    }
    /// 灰色背景
    static func dim(_ white: CGFloat, a: CGFloat = 0.2) -> Color{
        return .init(white: white, alpha: a)
    }
    
    static func randomColor() -> Color {
        let r = arc4random_uniform(256)
        let g = arc4random_uniform(256)
        let b = arc4random_uniform(256)
        return Color(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: CGFloat(1.0))
    }
}

