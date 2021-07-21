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
    func setTextColor(_ color: UIColor) {
        tintColor = color
        titleTextAttributes = [NSAttributedString.Key.foregroundColor: color,]
    }
    
    func setColors(withTint text: UIColor = .white, background: UIColor = .clear) {
        setBackgroundImage(UIImage(), for: .default)
        shadowImage = UIImage()
        isTranslucent = (background == .clear)
        backgroundColor = background
        barTintColor = background
        tintColor = text
        titleTextAttributes = [.foregroundColor: text]
    }
}
