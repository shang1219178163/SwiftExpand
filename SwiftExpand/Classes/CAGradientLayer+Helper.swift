//
//  CAGradientLayer+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/2/26.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension CAGradientLayer{
    private struct AssociateKeys {
        static var defaultColors   = "CAGradientLayer" + "defaultColors"
    }
    
    convenience init(colors: [Any], start: CGPoint, end: CGPoint) {
        self.init()
        self.colors = colors
        self.startPoint = start
        self.endPoint = end
    }
    
//    /// 十六进制字符串
//    static func gradientColorHex(_ from: String, fromAlpha: CGFloat, to: String, toAlpha: CGFloat = 1.0) -> [Any] {
//        return [UIColor.hex(from, a: fromAlpha).cgColor, UIColor.hex(to, a: toAlpha).cgColor]
//    }
//    
//    /// 0x开头的十六进制数字
//    static func gradientColorHexValue(_ from: Int, fromAlpha: CGFloat, to: Int, toAlpha: CGFloat = 1.0) -> [Any] {
//        return [UIColor.hexValue(from, a: fromAlpha).cgColor, UIColor.hexValue(to, a: toAlpha).cgColor]
//    }
    
    static var defaultColors: [Any] {
        get {
            if let obj = objc_getAssociatedObject(self,  &AssociateKeys.defaultColors) as? [Any] {
                return obj;
            }
            
            let list = [UIColor.hexValue(0x6cda53, a: 0.9).cgColor, UIColor.hexValue(0x1a965a, a: 0.9).cgColor]
                objc_setAssociatedObject(self,  &AssociateKeys.defaultColors, list, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return list
        }
        set {
            objc_setAssociatedObject(self,  &AssociateKeys.defaultColors, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    func colorsChain(_ colors: [Any]) -> Self {
        self.colors = colors
        return self
    }

    func locationsChain(_ locations: [NSNumber]) -> Self {
        self.locations = locations
        return self
    }

    func startPointChain(_ startPoint: CGPoint) -> Self {
        self.startPoint = startPoint
        return self
    }

    func endPointChain(_ endPoint: CGPoint) -> Self {
        self.endPoint = endPoint
        return self
    }

    func typeChain(_ type: CAGradientLayerType) -> Self {
        self.type = type
        return self
    }
}
