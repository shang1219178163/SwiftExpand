//
//  UINavigationController+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/12/13.
//  Copyright © 2018 BN. All rights reserved.
//

import UIKit

@objc extension UINavigationController{
        
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
