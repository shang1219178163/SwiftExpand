//
//  UISwitch+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc public extension UISwitch{

    /// [源]UISwitch创建
    static func create(_ rect: CGRect = .zero, isOn: Bool = true) -> Self {
        let view = self.init(frame: rect)
        view.autoresizingMask = .flexibleWidth
        view.isOn = isOn
        view.onTintColor = UIColor.theme
        return view
    }
}

@objc public extension UIDatePicker{

    /// [源]UIDatePicker创建
    static func create(_ rect: CGRect = .zero) -> Self {
        let view = self.init(frame: rect)
        view.datePickerMode = .date;
        view.locale = Locale(identifier: "zh_CN");
        view.backgroundColor = UIColor.white;
        if #available(iOS 13.4, *) {
            view.preferredDatePickerStyle = .wheels
        }
        return view
    }
}
