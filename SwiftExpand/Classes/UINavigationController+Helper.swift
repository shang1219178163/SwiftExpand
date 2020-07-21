//
//  UINavigationController+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/5.
//

import UIKit

@objc extension UINavigationController{
    
    /// vcName 控制器类名
    public convenience init(vcName: String){
        self.init(rootViewController: UICtrFromString(vcName))
    }
    
    /// pop到特定控制器页面
    public func popToViewController(_ type: UIViewController.Type, animate: Bool) {
        for e in viewControllers {
            if e.isKind(of: type) {
                popToViewController(e, animated: animate)
                return
            }
        }
        popViewController(animated: animate)
    }
    
    /// 修改切换导航栏样式
    public func changeBarStyle() {
         // 切换导航栏样式
         if navigationBar.barStyle == .default {
             navigationBar.barStyle = .black
         } else {
             navigationBar.barStyle = .default
         }
    }
}
