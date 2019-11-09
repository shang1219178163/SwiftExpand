//
//  UISwitch+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc public extension UISwitch{

    /// [源]UISwitch创建
    static func create(_ rect: CGRect = .zero, isOn: Bool = true) -> UISwitch {
        let view = UISwitch(frame: rect)
        view.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        view.isOn = isOn
        view.onTintColor = UIColor.theme
        return view
    }
}
