
//
//  StackView+Helper.swift
//  Alamofire
//
//  Created by Bin Shang on 2019/11/26.All rights reserved.
//

import Foundation

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
    
    
}
