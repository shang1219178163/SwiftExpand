//
//  UIFont+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/7/13.
//  Copyright © 2019 BN. All rights reserved.
//


@objc public extension Font{
    static let kPingFang           = "PingFang SC";
    static let kPingFangMedium     = "PingFangSC-Medium";
    static let kPingFangSemibold   = "PingFangSC-Semibold";
    static let kPingFangLight      = "PingFangSC-Light";
    static let kPingFangUltralight = "PingFangSC-Ultralight";
    static let kPingFangRegular    = "PingFangSC-Regular";
    static let kPingFangThin       = "PingFangSC-Thin";

    func withWeight(_ fontWeight: Font.Weight) -> UIFont{
        guard fontName.contains("-") == false,
              let name = fontName.components(separatedBy: "-").first else {
            return self }
        
        var weight: String = ""
        
        switch fontWeight {
        case .ultraLight:
            weight = "ultraLight"
            
        case .thin:
            weight = "thin"

        case .regular:
            weight = "regular"

        case .medium:
            weight = "medium"

        case .semibold:
            weight = "semibold"
            
        case .bold:
            weight = "bold"
            
        case .heavy:
            weight = "heavy"
            
        case .black:
            weight = "black"
            
        default:
            break
        }
        guard let font = UIFont(name: name + "-\(weight.uppercased())", size: pointSize) else { return self}
        return font
    }

}

