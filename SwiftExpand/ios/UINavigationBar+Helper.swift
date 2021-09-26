//
//  UINavigationBar+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/7/30.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UINavigationBar {
    
    ///设置背景色
    @available(iOS, introduced: 10, deprecated: 15, message: "replace by setColor(_ tintColor:, background:, shadowColor:)")
    func setBackgroudColor(_ color: UIColor?, for barMetrics: UIBarMetrics) {
        guard let color = color else {
            setBackgroundImage(nil, for: barMetrics)
            shadowImage = nil
            barTintColor = nil
            return
        }
        let image = color == UIColor.clear ? UIImage() : UIImage(color: color)
        setBackgroundImage(image, for: barMetrics)
        shadowImage = image
    }
    
    ///设置标题颜色
    @available(iOS, introduced: 10, deprecated: 15, message: "replace by setColor(_ tintColor:, background:, shadowColor:)")
    func setTextColor(_ color: UIColor) {
        tintColor = color
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,]
    }
        
    func setColor(_ tintColor: UIColor, background: UIColor, shadowColor: UIColor? = nil, font: UIFont = UIFont.systemFont(ofSize: 15)) {        
//        setBackgroundImage(UIImage(), for: .default)
//        shadowImage = UIImage()
//        isTranslucent = (background == .clear)
        setBackgroundImage(UIImage(color: background), for: .default)

        barTintColor = background
        self.tintColor = tintColor
        titleTextAttributes = [.foregroundColor: tintColor,
                                .font: font]
        
        if #available(iOS 13, *) {
            let barAppearance = UINavigationBarAppearance.create(tintColor, background: background, shadowColor: shadowColor, font: font)
            
            standardAppearance = barAppearance
            scrollEdgeAppearance = barAppearance
        }
    }
}


@available(iOS 13.0, *)
@objc public extension UINavigationBarAppearance{
    
    /// 创建
    static func create(_ color: UIColor, background: UIColor, shadowColor: UIColor? = nil, font: UIFont = UIFont.systemFont(ofSize: 15)) -> UINavigationBarAppearance {
        let barAppearance = UINavigationBarAppearance()
        barAppearance.configureWithOpaqueBackground()
        barAppearance.backgroundColor = background
        
        barAppearance.titleTextAttributes = [.foregroundColor: color, ]
        
        let buttonAppearanceNormal = barAppearance.buttonAppearance.normal
        buttonAppearanceNormal.titleTextAttributes = [.foregroundColor: color,
                                                      .backgroundColor: background,
                                                      .font: font
        ]

        let doneButtonAppearanceNormal = barAppearance.doneButtonAppearance.normal
        doneButtonAppearanceNormal.titleTextAttributes = [.foregroundColor: color,
                                                          .backgroundColor: background,
                                                          .font: font
        ]
        
        
        if let shadowColor = shadowColor {
            barAppearance.shadowColor = shadowColor
        }
        return barAppearance
    }
}
