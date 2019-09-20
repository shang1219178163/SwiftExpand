//
//  UIViewController+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/12/13.
//  Copyright © 2018 BN. All rights reserved.
//

import UIKit

public extension UIViewController{
    
    @objc class func initializeMethod() {
        // Make sure This isn't a subclass of UIViewController, So that It applies to all UIViewController childs
//        return;
        if self == UIViewController.self {
            let onceToken = "Method Swizzling_\(NSStringFromClass(classForCoder()))";
            //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(UIViewController.viewDidLoad)
                let repSel = #selector(UIViewController.swz_viewDidLoad)
                //            let _ = UIViewController.swizzleMethodInstance(oriSel, replSel: repSel);
                let _ = swizzleMethodInstance(UIViewController.self, origSel: oriSel, replSel: repSel);
                
//                DDLog(UIViewController.self)
                
                let oriSel1 = #selector(UIViewController.viewWillAppear(_:))
                let repSel1 = #selector(UIViewController.swz_viewWillAppear(animated:))
                //            let _ = UIViewController.swizzleMethodInstance(oriSel, replSel: repSel);
                let _ = swizzleMethodInstance(UIViewController.self, origSel: oriSel1, replSel: repSel1);
                
                
                let oriSel2 = #selector(UIViewController.viewWillDisappear(_:))
                let repSel2 = #selector(UIViewController.swz_viewWillDisappear(animated:))
                let _ = swizzleMethodInstance(UIViewController.self, origSel: oriSel2, replSel: repSel2);
                
                let oriSelPresent = #selector(UIViewController.present(_:animated:completion:))
                let repSelPresent = #selector(UIViewController.hook_present(_:animated:completion:))
                let _ = swizzleMethodInstance(UIViewController.self, origSel: oriSelPresent, replSel: repSelPresent);
                
            }
        } else if self == UINavigationController.self {
            let onceToken = "Method Swizzling_\(NSStringFromClass(classForCoder()))";
            //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
            DispatchQueue.once(token: onceToken) {
                let oriSel = #selector(UINavigationController.pushViewController(_:animated:));
                let repSel = #selector(UINavigationController.swz_pushViewController(_:animated:));
//                let _ = UINavigationController.swizzleMethodInstance(oriSel, replSel: repSel);
                let _ = swizzleMethodInstance(UINavigationController.self, origSel:oriSel , replSel: repSel);

            }
        }
    }
    
    @objc internal func swz_viewDidLoad(animated: Bool) {
        //需要注入的代码写在此处
//        edgesForExtendedLayout = UIRectEdge(rawValue: 0)
        edgesForExtendedLayout = [];
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
        self.swz_viewDidLoad(animated: animated)
    }
    
    @objc private func swz_viewWillAppear(animated: Bool) {
        //需要注入的代码写在此处
        self.swz_viewWillAppear(animated: animated)
//        self.eventGather(isBegin: true);
    }
    
    @objc private func swz_viewWillDisappear(animated: Bool) {
        //需要注入的代码写在此处
        self.swz_viewWillDisappear(animated: animated)
//        self.eventGather(isBegin: false);
    }
    
    @objc private func hook_present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Swift.Void)? = nil) {
        //判断是否是alert弹窗
        if viewControllerToPresent.isKind(of: UIAlertController.self) {
            #if DEBUG
                print("title: \(String(describing: (viewControllerToPresent as? UIAlertController)?.title))")
                print("message: \(String(describing: (viewControllerToPresent as? UIAlertController)?.message))")
            #endif
            // 换图标时的提示框的title和message都是nil，由此可特殊处理
            let alertController = viewControllerToPresent as? UIAlertController
            if alertController?.title == nil && alertController?.message == nil {
                //是更换icon的提示
                changeAppIconAction()
                return
            } else {
                //其他的弹框提示正常处理
                hook_present(viewControllerToPresent, animated: flag, completion: completion)
            }
        }
        hook_present(viewControllerToPresent, animated: flag, completion: completion)
    }
    
    // MARK: -funtions
    @objc private func eventGather(isBegin: Bool = true) -> Void {
        let className = NSStringFromClass(classForCoder);
        //设置不允许发送数据的Controller
        let filters = ["UINavigationController", "UITabBarController", "UICompatibilityInputViewController",
                       "UIInputWindowController", "UIAlertController"];
        if filters.contains(className) {
            return ;
        }
        
        if isBegin == true {
            DDLog("\(NSStringFromClass(classForCoder))--Appear")
            
        } else {
            DDLog("\(NSStringFromClass(classForCoder))--Disappear")
            
        }
    }
    
    @objc private func changeAppIconAction(){
        print("替换成功")

    }

}
