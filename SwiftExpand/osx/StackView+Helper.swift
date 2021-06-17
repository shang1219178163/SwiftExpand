//
//  NSStackView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//




@objc public extension StackView {

    ///遍利方法
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
    
    ///数组传入子视图集合
    func changeSubViews(_ views: [View]) {
        if views.count == 0 {
            return
        }
        removeArrangedSubviews()
        let list = views.filter({ $0.isHidden == false })
        addArrangedSubviews(list)
        
        translatesAutoresizingMaskIntoConstraints = true ///方向改变时,组件宽度重绘
    }
        
    ///排列视图
    func distributeViewsAlong(for titles: [String], handler: @escaping ((Int, String) -> NSView)) {
        translatesAutoresizingMaskIntoConstraints = false

        for (idx, value) in titles.enumerated() {
            let element = handler(idx, value)
            addArrangedSubview(element)
        }
    }
}
