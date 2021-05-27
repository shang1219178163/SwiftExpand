
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
        if index < subviews.count {
            let element = subviews[index];
            if self.axis == .horizontal {
                element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true

            } else {
                element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
            }
        }
    }
    
    //排列 NSButton 视图
    func distributeViewsAlongButton(for buttonType: Button.ButtonType, titles: [String], handler: @escaping ((Button) -> Void)) {
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let element = Button(type: buttonType)
            element.setTitle(value, for: .normal)
            element.tag = idx
            handler(element)
            addArrangedSubview(element)
        }
    }
}
