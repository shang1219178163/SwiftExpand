
//
//  StackView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import AppKit

@objc public extension StackView {

    ///遍利方法
    convenience init(subviews: [View],
                     orientation: NSUserInterfaceLayoutOrientation,
                     spacing: CGFloat = 0.0,
                     alignment: NSLayoutConstraint.Attribute = .centerY,
                     distribution: StackView.Distribution = .fill) {
        self.init(views: subviews)
        self.orientation = orientation
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    /// 设置子视图显示比例(此方法前请设置 .axis/.orientation)
    func setSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
        if index >= subviews.count {
            return
        }
        let element = subviews[index]
        if self.orientation == .horizontal {
            element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        } else {
            element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
        }
    }

    //排列 NSButton 视图
    @discardableResult
    func distributeViewsAlongButton(for titles: [String], handler: @escaping ((NSButton) -> Void)) -> Self {
        if arrangedSubviews.count == titles.count {
            arrangedSubviews.enumerated().forEach { (e) in
                if let sender = e.element as? NSButton {
                    sender.title = titles[e.offset]
                }
            }
            return self
        }
        
        if arrangedSubviews.count != titles.count {
            arrangedSubviews.forEach { (e) in
                e.removeFromSuperview()
            }
        }
        
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let sender = NSButton()
            sender.bezelStyle = .rounded
            sender.title = value
            sender.tag = idx
            handler(sender)
            addArrangedSubview(sender)
        }
        return self
    }
 
}
