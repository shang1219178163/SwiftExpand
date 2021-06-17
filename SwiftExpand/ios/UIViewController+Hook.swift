//
//  UIViewController+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/12/13.
//  Copyright © 2018 BN. All rights reserved.
//

import UIKit

@objc extension UIViewController{
    
    override public class func initializeMethod() {
        super.initializeMethod();
        
        if self == UIViewController.self {
            let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(viewDidLoad)
                let repSel = #selector(hook_viewDidLoad)
                hookInstanceMethod(of: oriSel, with: repSel);
                                
                let oriSel1 = #selector(viewWillAppear(_:))
                let repSel1 = #selector(hook_viewWillAppear(animated:))
                hookInstanceMethod(of: oriSel1, with: repSel1);
                
                let oriSel2 = #selector(viewWillDisappear(_:))
                let repSel2 = #selector(hook_viewWillDisappear(animated:))
                hookInstanceMethod(of: oriSel2, with: repSel2);
                
                let oriSelPresent = #selector(present(_:animated:completion:))
                let repSelPresent = #selector(hook_present(_:animated:completion:))
                hookInstanceMethod(of: oriSelPresent, with: repSelPresent);
            }
        } else if self == UINavigationController.self {
            let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(UINavigationController.pushViewController(_:animated:));
                let repSel = #selector(UINavigationController.hook_pushViewController(_:animated:));
                hookInstanceMethod(of:oriSel , with: repSel);
            }
        }
    }
    
    private func hook_viewDidLoad(animated: Bool) {
        hook_viewDidLoad(animated: animated)
        
        edgesForExtendedLayout = []
        automaticallyAdjustsScrollViewInsets = false
    }
    
    private func hook_viewWillAppear(animated: Bool) {
        //需要注入的代码写在此处
        hook_viewWillAppear(animated: animated)
//        self.eventGather(isBegin: true);
    }
    
    private func hook_viewWillDisappear(animated: Bool) {
        //需要注入的代码写在此处
        hook_viewWillDisappear(animated: animated)
//        self.eventGather(isBegin: false);
    }
    
    private func hook_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        if viewControllerToPresent.presentationController == nil {
            viewControllerToPresent.presentationController?.presentedViewController.dismiss(animated: false, completion: nil)
            DDLog("viewControllerToPresent.presentationController 不能为 nil")
            return
        }
        hook_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: -funtions
    private func eventGather(isBegin: Bool = true) {
        let className = NSStringFromClass(classForCoder);
        if className.hasPrefix("UI") && className.hasSuffix("Controller"){
            return ;
        }
        
        if isBegin == true {
            DDLog("\(NSStringFromClass(classForCoder))--Appear")
        } else {
            DDLog("\(NSStringFromClass(classForCoder))--Disappear")
        }
    }
    
    private func changeAppIconAction(){
//        print("替换成功")
    }

}

@objc extension UINavigationController{
    
    public func hook_pushViewController(_ viewController: UIViewController, animated: Bool) {
        //判断是否是根控制器
        if viewControllers.count > 0 {
            viewController.createBackItem(UIImage(named: "icon_arowLeft_black")!.withRenderingMode(.alwaysTemplate))
            viewController.hidesBottomBarWhenPushed = true
        }
        //push进入下一个控制器
        hook_pushViewController(viewController, animated: animated);
    }

}

