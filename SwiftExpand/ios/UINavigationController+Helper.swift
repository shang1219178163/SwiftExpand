//
//  UINavigationController+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/5.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UINavigationController{
    
    /// vcName 控制器类名
    convenience init(vcName: String){
        self.init(rootViewController: UICtrFromString(vcName))
    }
    
    func pushVC(_ name: String, animated: Bool = true) {
        assert(UICtrFromString(name).isKind(of: UIViewController.self))
        let controller = UICtrFromString(name)
        pushViewController(controller, animated: animated)
    }
    
    /// pop到特定控制器页面
    func popToVC(_ type: UIViewController.Type, animated: Bool) {
        for e in viewControllers {
            if e.isKind(of: type) {
                popToViewController(e, animated: animated)
                return
            }
        }
        popViewController(animated: animated)
    }
        
    /// 修改切换导航栏样式
    func changeBarStyle() {
         // 切换导航栏样式
         if navigationBar.barStyle == .default {
             navigationBar.barStyle = .black
         } else {
             navigationBar.barStyle = .default
         }
    }
    
}

public extension UINavigationController{
    ///泛型方法: push到特定控制器页面
    final func pushVC<T: UIViewController>(_ type: T.Type, animated: Bool = true, block: ((T) -> Void)? = nil) {
        let controller = type.init()
//        controller.hidesBottomBarWhenPushed = true
        block?(controller)
        pushViewController(controller, animated: animated)
    }
    ///泛型方法: pop到特定控制器页面
    final func popToVC<T: UIViewController>(_ type: T.Type, animated: Bool = true) {
        for e in viewControllers {
            if e.isKind(of: type) {
                popToViewController(e, animated: animated)
                return
            }
        }
        popViewController(animated: animated)
    }
    ///泛型方法: 延迟退出
    func popVC(animated: Bool, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: delay)) {
            self.popViewController(animated: animated)
        }
    }
    
    ///泛型方法: 跳转到特定页面(viewControllers 包含 pop, 不包含则 push)
    final func jumpToVC<T: UIViewController>(_ type: T.Type, animated: Bool = true, block: ((T) -> Void)? = nil) {
        for e in viewControllers {
            if e.isKind(of: type) {
                block?(e as! T)
                popToViewController(e, animated: animated)
                return
            }
        }
        pushVC(type, animated: animated, block: block)
    }
}


extension DispatchTime: ExpressibleByIntegerLiteral {
    
    public init(integerLiteral value: Int) {
        self = DispatchTime.now() + .seconds(value)
    }
}

extension DispatchTime: ExpressibleByFloatLiteral {
    
    public init(floatLiteral value: Double) {
        self = DispatchTime.now() + .milliseconds(Int(value * 1000))
    }
}
