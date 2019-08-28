
//
//  UIScreen+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/7.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


public extension UIScreen {
    
    @objc static var width: CGFloat {
        get {
            return UIScreen.main.bounds.size.width
        }
    }
    
    @objc static var height: CGFloat {
        get {
            return UIScreen.main.bounds.size.height
        }
    }
    
    @objc static var statusBarHeight: CGFloat {
        get {
            return 20.0
        }
    }
    
    @objc static var navBarHeight: CGFloat {
        get {
            return 44.0
        }
    }
    
    @objc static var barHeight: CGFloat {
        get {
            return (UIScreen.statusBarHeight + UIScreen.navBarHeight)
        }
    }
    
    @objc static var tabBarHeight: CGFloat {
        get {
            return 49.0
        }
    }
}
