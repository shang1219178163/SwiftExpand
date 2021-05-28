
//
//  UIStackView+Helper.swift
//  Alamofire
//
//  Created by Bin Shang on 2019/11/26.
//


@objc public extension StackView {
    ///遍利方法
    convenience init(subviews: [View],
                     axis: NSLayoutConstraint.Axis,
                     spacing: CGFloat = 0.0,
                     alignment: StackView.Alignment = .fill,
                     distribution: StackView.Distribution = .fill) {
        self.init(arrangedSubviews: subviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    /// 设置子视图显示比例(此方法前请设置 .axis/.orientation)
    func setSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
        if index >= subviews.count {
            return
        }
        
        let element = subviews[index];
        if self.axis == .horizontal {
            element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
        } else {
            element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
        }
    }
    
    //排列 NSButton 视图
    func distributeViewsAlongButton(for buttonType: Button.ButtonType, titles: [String], handler: @escaping ((Button) -> Void)) -> Self {
        if arrangedSubviews.count == titles.count {
            arrangedSubviews.enumerated().forEach { (e) in
                if let sender = e.element as? Button {
                    sender.setTitle(titles[e.offset], for: .normal)
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
            let sender = Button(type: buttonType)
            sender.setTitle(value, for: .normal)
            sender.setTitleColor(.black, for: .normal)
            sender.titleLabel?.font = Font.systemFont(ofSize: 15)
            sender.tag = idx
            handler(sender)
            addArrangedSubview(sender)
        }
        return self
    }
}
