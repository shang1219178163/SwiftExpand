
//
//  UIStackView+Helper.swift
//  Alamofire
//
//  Created by Bin Shang on 2019/11/26.
//

import UIKit

@available(iOS 9.0, *)
@objc public extension UIStackView {
    
    convenience init(arrangedSubviews: [UIView],
                      axis: NSLayoutConstraint.Axis,
                      spacing: CGFloat = 0.0,
                      alignment: UIStackView.Alignment = .fill,
                      distribution: UIStackView.Distribution = .fill) {
        self.init(arrangedSubviews: arrangedSubviews)
        self.axis = axis
        self.spacing = spacing
        self.alignment = alignment
        self.distribution = distribution
    }
    
    func axisChain(_ axis: NSLayoutConstraint.Axis) -> Self {
        self.axis = axis
        return self
    }

    func distributionChain(_ distribution: UIStackView.Distribution) -> Self {
        self.distribution = distribution
        return self
    }

    func alignmentChain(_ alignment: UIStackView.Alignment) -> Self {
        self.alignment = alignment
        return self
    }

    func spacingChain(_ spacing: CGFloat) -> Self {
        self.spacing = spacing
        return self
    }

    func isBaselineRelativeArrangementChain(_ isBaselineRelativeArrangement: Bool) -> Self {
        self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
        return self
    }

    func isLayoutMarginsRelativeArrangementChain(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
        self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
        return self
    }
    
    @available(iOS 11.0, *)
    func setCustomSpacingChain(_ spacing: CGFloat, after arrangedSubview: UIView) -> Self {
        self.setCustomSpacing(spacing, after: arrangedSubview)
        return self
    }

    func addArrangedSubviews(_ views: [UIView]) {
        for view in views {
            addArrangedSubview(view)
        }
    }
    
    func removeArrangedSubviews() {
        for view in arrangedSubviews {
            removeArrangedSubview(view)
        }
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
    
    ///数组传入子视图集合
    func changeViews(_ views: [UIView]) {
        if views.count == 0 {
            return
        }
        removeArrangedSubviews()
        let list = views.filter({ $0.isHidden == false })
        addArrangedSubviews(list)
        
        translatesAutoresizingMaskIntoConstraints = true ///方向改变时,组件宽度重绘
    }
    
    
    //排列 NSButton 视图
    func distributeViewsAlongButton(for buttonType: UIButton.ButtonType, titles: [String], handler: @escaping ((UIButton) -> Void)) {
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let element = UIButton(type: buttonType)
            element.setTitle(value, for: .normal)
            element.tag = idx
            handler(element)
            addArrangedSubview(element)
        }
    }
}
