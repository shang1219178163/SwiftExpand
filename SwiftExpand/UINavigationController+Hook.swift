//
//  UINavigationController+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/12/13.
//  Copyright © 2018 BN. All rights reserved.
//

import UIKit

public extension UINavigationController{
    
    @objc internal func swz_pushViewController(_ viewController: UIViewController, animated: Bool) {
        //需要注入的代码写在此处
//        viewController.navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .done, target: nil, action: nil);
        viewController.view.backgroundColor = .white;
        //判断是否是根控制器
        if viewControllers.count > 0 {
            viewController.hidesBottomBarWhenPushed = true
            _ = viewController.createBackItem(UIImageNamed("icon_arowLeft_black")!)
        }
        
        //push进入下一个控制器
        swz_pushViewController(viewController, animated: animated);
        
    }
    
}
