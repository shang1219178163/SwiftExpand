
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
        return 20.0
    }
    
    static var navBarHeight: CGFloat {
        return UIScreen.main.bounds.size.height >= 812 ? 88 : 64
    }
    
    static var barHeight: CGFloat {
        return (UIScreen.statusBarHeight + UIScreen.navBarHeight)
    }
    
    static var tabBarHeight: CGFloat {
        return UIScreen.main.bounds.size.height >= 812 ? 84 :  49
    }
    
    static var isIPhoneX: Bool {
        return UIScreen.main.bounds.size.height >= 812
    }
}
