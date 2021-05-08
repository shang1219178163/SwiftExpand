//
//  UISwitch+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc public extension UISwitch{
    
    private struct AssociateKeys {
        static var closure   = "UISwitch" + "closure"
    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UISwitch) ->Void), for controlEvents: UIControl.Event = .valueChanged) {
        addTarget(self, action:#selector(p_handleActionSwitch(_:)), for:controlEvents);
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /// 点击回调
    private func p_handleActionSwitch(_ sender: UISwitch) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UISwitch) ->Void) {
            block(sender);
        }
    }

    /// [源]UISwitch创建
    convenience init(rect: CGRect = .zero, isOn: Bool = true) {
        self.init(frame: rect)
        self.autoresizingMask = .flexibleWidth
        self.isOn = isOn
        self.onTintColor = UIColor.theme
    }
    
    func onTintColorChain(_ onTintColor: UIColor?) -> Self {
        self.onTintColor = onTintColor
        return self
    }

    func thumbTintColorChain(_ thumbTintColor: UIColor?) -> Self {
        self.thumbTintColor = thumbTintColor
        return self
    }

    func onImageChain(_ onImage: UIImage?) -> Self {
        self.onImage = onImage
        return self
    }

    func offImageChain(_ offImage: UIImage?) -> Self {
        self.offImage = offImage
        return self
    }

    @available(iOS 14.0, *)
    func titleChain(_ title: String?) -> Self {
        self.title = title
        return self
    }

    @available(iOS 14.0, *)
    func preferredStyleChain(_ preferredStyle: UISwitch.Style) -> Self {
        self.preferredStyle = preferredStyle
        return self
    }

    func isOnChain(_ isOn: Bool) -> Self {
        self.isOn = isOn
        return self
    }
}
