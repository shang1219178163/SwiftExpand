
//
//  StackView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



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

}
