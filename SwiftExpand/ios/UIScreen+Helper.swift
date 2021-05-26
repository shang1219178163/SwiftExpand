
//
//  UIScreen+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/7.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


@objc public extension UIScreen {
    
    static var sizeWidth: CGFloat {
        return UIScreen.main.bounds.size.width
    }
    
    static var sizeHeight: CGFloat {
        return UIScreen.main.bounds.size.height
    }
    
    static var statusBarHeight: CGFloat {
        return isIPhoneX ? 44 : 20
    }
    
    static var navBarHeight: CGFloat {
        return isIPhoneX ? 88 : 64
    }
    
    static var barHeight: CGFloat {
        return (UIScreen.statusBarHeight + UIScreen.navBarHeight)
    }
    
    static var tabBarHeight: CGFloat {
        return isIPhoneX ? (49.0 + 34.0) : 49
    }
    
    static var isIPhoneX: Bool {
        return UIScreen.main.bounds.size.height >= 812
    }
    
//    @available(iOS 11.0, *)
//    static var insets: UIEdgeInsets {
//        return UIApplication.shared.delegate?.window??.safeAreaInsets ?? UIEdgeInsets.zero
//    }
}
