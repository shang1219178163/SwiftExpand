//
//  UISlider+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc public extension UISlider{

    private struct AssociateKeys {
        static var closure = "UISlider" + "closure"
    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UISlider) ->Void), for controlEvents: UIControl.Event = .valueChanged) {
        addTarget(self, action:#selector(p_handleActionSlider(_:)), for:controlEvents)
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
    }
    
    /// 点击回调
    private func p_handleActionSlider(_ sender: UISlider) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UISlider) ->Void) {
            block(sender)
        }
    }
    
    /// [源]UISlider创建
    convenience init(rect: CGRect = .zero, minValue: Float = 0, maxValue: Float = 100) {
        self.init(frame: rect)
        self.autoresizingMask = .flexibleWidth
        self.minimumValue = minValue
        self.maximumValue = maxValue
        self.value = minValue
        self.minimumTrackTintColor = UIColor.theme
    }
    
    func setValue(_ value: Float, animated: Bool = true, duration: TimeInterval = 1, completion: (() -> Void)? = nil) {
        if animated {
            UIView.animate(withDuration: duration, animations: {
                self.setValue(value, animated: true)
            }, completion: { _ in
                completion?()
            })
        } else {
            setValue(value, animated: false)
            completion?()
        }
    }
}
