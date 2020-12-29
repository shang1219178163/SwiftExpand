//
//  UINavigationController+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/5.
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
        pushViewController(controller, animated: animated);
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
    
    final func pushVC<T: UIViewController>(_ type: T.Type, animated: Bool = true, block: ((T) -> Void)? = nil) {
        let controller = type.init()
//        controller.hidesBottomBarWhenPushed = true
        block?(controller)
        pushViewController(controller, animated: animated);
    }
    
    func popVC(animated: Bool, delay: Double) {
        DispatchQueue.main.asyncAfter(deadline: DispatchTime(floatLiteral: delay)) {
            self.popViewController(animated: animated)
        }
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
