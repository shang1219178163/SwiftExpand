//
//  UIDatePicker+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


public extension UIDatePicker {

    var textColor: UIColor? {
        get {
            value(forKeyPath: "textColor") as? UIColor
        }
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
    }
    
    convenience init(rect: CGRect = .zero, isOn: Bool = true) {
        self.init(frame: rect)
        self.datePickerMode = .date;
        self.locale = Locale(identifier: "zh_CN");
        self.backgroundColor = UIColor.white;
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
    }
}

