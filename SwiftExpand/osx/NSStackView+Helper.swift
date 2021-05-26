//
//  NSStackView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//




@objc public extension NSStackView {

    // MARK: -funtions
    ///数组传入子视图集合
    func changeViews(_ views: [NSView], orientation: NSUserInterfaceLayoutOrientation) {
        if views.count == 0 {
            return
        }
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
        
        let list = views.filter({ $0.isHidden == false })

        self.orientation = orientation
        list.forEach { (sender) in
            self.addArrangedSubview(sender)
        }
        
        distribution = .fillEqually
        translatesAutoresizingMaskIntoConstraints = true ///方向改变时,组件宽度重绘
    }
        
    /// 设置子视图显示比例(此方法前请设置 .axis/.orientation)
    func setSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
        if index < subviews.count {
            let element = subviews[index];
            if self.orientation == .horizontal {
                element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

            } else {
                element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            }
        }
    }
    ///排列视图
    func distributeViewsAlong(for titles: [String], handler: @escaping ((Int, String) -> NSView)) {
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let element = handler(idx, value)
            addArrangedSubview(element)
        }
    }
    
    //排列 NSButton 视图
    func distributeViewsAlongButton(for buttonType: NSButton.ButtonType, titles: [String], handler: @escaping ((NSButton) -> Void)) {
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let element = NSButton()
            element.setButtonType(buttonType)
            element.title = value
            element.tag = idx
            handler(element)
            addArrangedSubview(element)
        }
    }

}
