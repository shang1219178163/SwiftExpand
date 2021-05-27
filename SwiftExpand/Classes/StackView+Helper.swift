
//
//  UIStackView+Helper.swift
//  Alamofire
//
//  Created by Bin Shang on 2019/11/26.
//


@objc public extension StackView {
    
    func addArrangedSubviews(_ views: [View]) {
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
    func changeSubViews(_ views: [UIView]) {
        if views.count == 0 {
            return
        }
        removeArrangedSubviews()
        let list = views.filter({ $0.isHidden == false })
        addArrangedSubviews(list)
        
        translatesAutoresizingMaskIntoConstraints = true ///方向改变时,组件宽度重绘
    }
    
    
}
