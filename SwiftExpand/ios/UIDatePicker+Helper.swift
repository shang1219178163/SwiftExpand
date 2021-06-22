//
//  UIDatePicker+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


@objc public extension UIDatePicker {
    private struct AssociateKeys {
        static var closure   = "UIDatePicker" + "closure"

    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UIDatePicker) ->Void), for controlEvents: UIControl.Event = .valueChanged) {
        addTarget(self, action:#selector(p_handleActionDatePicker(_:)), for:controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 点击回调
    @objc private func p_handleActionDatePicker(_ sender: UIDatePicker) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIDatePicker) ->Void) {
            block(sender)
        }
    }
    
    var textColor: UIColor? {
        get {
            value(forKeyPath: "textColor") as? UIColor
        }
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
    }
    /// 初始化
    convenience init(rect: CGRect = .zero, isOn: Bool = true) {
        self.init(frame: rect)
        self.datePickerMode = .date
        self.locale = Locale(identifier: "zh_CN")
        self.backgroundColor = UIColor.white
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
    }
}

