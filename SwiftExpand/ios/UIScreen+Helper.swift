
//
//  UIScreen+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/7.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

public let isiPhoneX: Bool              = UIScreen.isIPhoneX
/// 状态栏 20
public let kStatusBarHeight: CGFloat    = UIScreen.statusBarHeight
/// 导航栏高
public let kNavBarHeight: CGFloat       = UIScreen.navBarHeight

/// 底部tabBar高度 49
public let kTabBarHeight: CGFloat       = UIScreen.tabBarHeight


@objc public extension UIScreen {
    
    static var sizeWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var sizeHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var statusBarHeight: CGFloat {
//        return isIPhoneX ? 44 : 20
        var height = UIApplication.shared.statusBarFrame.size.height
        if #available(iOS 13.0, *) {
            height = UIApplication.shared.windows[0].windowScene?.statusBarManager?.statusBarFrame.size.height ?? 44
        }
        return height
    }
    
    static var isIPhoneX: Bool {
        return UIScreen.main.bounds.size.height >= 812
    }
    
    static var navBarHeight: CGFloat {
        return isIPhoneX ? 88 : 64
    }
    
    static var tabBarHeight: CGFloat {
        return isIPhoneX ? (49.0 + 34.0) : 49
    }
    
//    @available(iOS 11.0, *)
//    static var insets: UIEdgeInsets {
//        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
//    }
}
