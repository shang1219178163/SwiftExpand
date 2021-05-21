//
//  UIViewController+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/5/16.
//  Copyright © 2018年 BN. All rights reserved.
//

import Foundation
import UIKit

@objc public extension UIViewController{

    
    var controllerName: String {
        var className: String = NNStringFromClass(self.classForCoder)
        if className.contains("Controller") {
            var range = className.range(of: "Controller");
            if className.contains("ViewController") {
                range = className.range(of: "ViewController");
                
            }
            className = String(className[..<range!.lowerBound]);
        }
        return className;
    }
    
    /// 是否正在展示
    var isCurrentVC: Bool {
        return isViewLoaded == true && (view!.window != nil)
    }
    
    /// 呈现
    func present(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let keyWindow = UIApplication.shared.keyWindow,
              let rootVC = keyWindow.rootViewController
              else { return }
        if let presentedViewController = rootVC.presentedViewController {
            presentedViewController.dismiss(animated: false, completion: nil)
        }
        
        self.modalPresentationStyle = .fullScreen
        DispatchQueue.main.async {
            switch self {
            case let alertVC as UIAlertController:
                if alertVC.preferredStyle == .alert {
                    if alertVC.actions.count == 0 {
                        rootVC.present(alertVC, animated: animated, completion: {
                            DispatchQueue.main.after(TimeInterval(kDurationToast), execute: {
                                alertVC.dismiss(animated: animated, completion: completion)
                            })
                        })
                        return
                    }
                    rootVC.present(alertVC, animated: animated, completion: completion)
                } else {
                    //防止 ipad 下 sheet 会崩溃的问题
                    if UIDevice.current.userInterfaceIdiom == .pad {
                        if let controller = alertVC.popoverPresentationController {
                            controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                            controller.sourceView = keyWindow;
                            
                            let isEmpty = controller.sourceRect.equalTo(.null) || controller.sourceRect.equalTo(.zero)
                            if isEmpty {
                                controller.sourceRect = CGRect(x: keyWindow.bounds.midX, y: 64, width: 1, height: 1);
                            }
                        }
                    }
                    rootVC.present(alertVC, animated: animated, completion: completion)
                }
                
            default:
                rootVC.present(self, animated: animated, completion: completion)
            }
        }
    }
    
    /// 消失
    func dismissVC(_ animated: Bool = true, completion: (() -> Void)? = nil) {
        guard let keyWindow = UIApplication.shared.keyWindow,
              let rootVC = keyWindow.rootViewController
              else { return }
        
        DispatchQueue.main.async {
            if let presentedViewController = rootVC.presentedViewController {
                presentedViewController.dismiss(animated: animated, completion: completion)
            }
        }
    }
    
    ///判断上一页是哪个页面
    func pushFromVC(_ type: UIViewController.Type) -> Bool {
        guard let viewControllers = navigationController?.viewControllers,
              viewControllers.count > 1,
              let index = viewControllers.firstIndex(of: self) else {
            return false }
                        
        let result = viewControllers[index - 1].isKind(of: type)
        return result
    }
    
    /// 重置布局
    func setupExtendedLayout() {
        edgesForExtendedLayout = [];
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never;
        } else {
            automaticallyAdjustsScrollViewInsets = false;
        }
    }
    
    /// 重置布局(UIDocumentPickerViewController需要为automatic)
    func setupContentInsetAdjustmentBehavior(_ isAutomatic: Bool = false) {
        if #available(iOS 11.0, *) {
            UIScrollView.appearance().contentInsetAdjustmentBehavior = isAutomatic == true ? .automatic : .never;
        }
    }
    
    /// [源]创建UISearchController(设置IQKeyboardManager.shared.enable = false;//避免searchbar下移)
    func createSearchVC(_ resultsController: UIViewController) -> UISearchController {
        resultsController.edgesForExtendedLayout = []
        definesPresentationContext = true;
        
        let searchVC = UISearchController(searchResultsController: resultsController)
        if resultsController.conforms(to: UISearchResultsUpdating.self) {
            searchVC.searchResultsUpdater = resultsController as? UISearchResultsUpdating;
        }
        
        searchVC.dimsBackgroundDuringPresentation = true;
//        searchVC.hidesNavigationBarDuringPresentation = true;
        if #available(iOS 9.1, *) {
            searchVC.obscuresBackgroundDuringPresentation = true;
        }
        
        searchVC.searchBar.barStyle = .default;
//        searchVC.searchBar.barTintColor = UIColor.theme;
        
        searchVC.searchBar.isTranslucent = false;
//        searchVC.searchBar.setValue("取消", forKey: "_cancelButtonText")
        searchVC.searchBar.placeholder = "搜索";
        
//        searchVC.searchBar.delegate = self;
//        searchVC.delegate = self;
        return searchVC;
    }
        
    /// 导航栏返回按钮图片定制
    func createBackItem(_ image: UIImage) {
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: image, style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem?.addAction({ (item) in
            self.navigationController?.popViewController(animated: true);
        });
    }
    ///系统样式
    func createBarItem(_ systemItem: UIBarButtonItem.SystemItem, isLeft: Bool = false, closure: @escaping ((UIBarButtonItem) -> Void)) {
        let item = UIBarButtonItem(barButtonSystemItem: systemItem, target: nil, action: nil);
        item.systemType = systemItem
        item.addAction(closure)
        if isLeft == true {
            navigationItem.leftBarButtonItem = item;
        } else {
            navigationItem.rightBarButtonItem = item;
        }
    }
    
    /// 创建 UIBarButtonItem
    func createBarItem(_ obj: String, style: UIBarButtonItem.Style = .plain, isLeft: Bool = false, action: @escaping ((UIBarButtonItem) -> Void)){
        var barItem: UIBarButtonItem?
        if let image = UIImage(named: obj) {
            barItem = UIBarButtonItem(image: image, style: style, target: nil, action: nil)
        } else {
            barItem = UIBarButtonItem(title: obj, style: style, target: nil, action: nil);
        }
        barItem?.addAction(action)        
        if isLeft == true {
            navigationItem.leftBarButtonItem = barItem;
        } else {
            navigationItem.rightBarButtonItem = barItem;
        }
    }
        
    func addControllerName(_ vcName: String) {
        let controller = UICtrFromString(vcName)
        assert(controller.isKind(of: UIViewController.self))
        addControllerVC(controller)
    }
    
    /// 添加子控制器(对应方法 removeControllerVC)
    func addControllerVC(_ controller: UIViewController) {
        assert(controller.isKind(of: UIViewController.self))
        
        addChild(controller)
//        controller.view.frame = self.view.bounds;
        controller.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        view.addSubview(controller.view)
        controller.didMove(toParent: self)
    }
    
    /// 移除添加的子控制器(对应方法 addControllerVC)
    func removeControllerVC(_ controller: UIViewController) {
        assert(controller.isKind(of: UIViewController.self))
        
        controller.willMove(toParent: nil)
        controller.view.removeFromSuperview()
        controller.removeFromParent();
    }
    
    /// 显示controller(手动调用viewWillAppear和viewDidAppear,viewWillDisappear)
    func transitionTo(VC: UIViewController) {
        beginAppearanceTransition(false, animated: true)  //调用self的 viewWillDisappear:
        VC.beginAppearanceTransition(true, animated: true)  //调用VC的 viewWillAppear:
        endAppearanceTransition(); //调用self的viewDidDisappear:
        VC.endAppearanceTransition(); //调用VC的viewDidAppear:
        /*
         isAppearing 设置为 true : 触发 viewWillAppear:;
         isAppearing 设置为 false : 触发 viewWillDisappear:;
         endAppearanceTransition方法会基于我们传入的isAppearing来调用viewDidAppear:以及viewDidDisappear:方法
         */
    }
    /// 手动调用 viewWillAppear,viewDidDisappear 或 viewWillDisappear,viewDidDisappear
    func beginAppearance(_ isAppearing: Bool, animated: Bool){
        beginAppearanceTransition(isAppearing, animated: animated);
        endAppearanceTransition();
    }
    
    ///背景灰度设置
    func setAlphaOfBackgroundViews(_ alpha: CGFloat) {
        guard let statusBarWindow = UIApplication.shared.value(forKey: "statusBarWindow") as? UIWindow else { return }
        UIView.animate(withDuration: 0.2) {
            statusBarWindow.alpha = alpha;
            self.view.alpha = alpha;
            self.navigationController?.navigationBar.alpha = alpha;
        }
    }
        
    ///呈现popover
    func presentPopover(_ contentVC: UIViewController,
                        sender: UIView,
                        arrowDirection: UIPopoverArrowDirection = .any,
                        offset: UIOffset = .zero,
                        completion: (() -> Void)? = nil){
        if contentVC.presentingViewController != nil {
            return
        }
        
        contentVC.modalPresentationStyle = .popover

        guard let superview = sender.superview else { return }
        let sourceRect = superview.convert(sender.frame, to: self.view)
        
        guard let popoverPresentationVC = contentVC.popoverPresentationController else { return }
        popoverPresentationVC.permittedArrowDirections = arrowDirection
        popoverPresentationVC.sourceView = self.view
        popoverPresentationVC.sourceRect = sourceRect.offsetBy(dx: offset.horizontal, dy: offset.vertical)
        if conforms(to: UIPopoverPresentationControllerDelegate.self) {
            popoverPresentationVC.delegate = self as? UIPopoverPresentationControllerDelegate
        }
//        present(popoverContentVC, animated: true, completion: completion)
        contentVC.present(true, completion: completion)
    }
    
    ///左滑返回按钮(viewDidAppear/viewWillDisappear)
    func popGesture(_ isEnabled: Bool) {
        guard let navigationController = navigationController,
              let interactivePopGestureRecognizer = navigationController.interactivePopGestureRecognizer,
              let gestureRecognizers = interactivePopGestureRecognizer.view?.gestureRecognizers
              else { return }
   
        gestureRecognizers.forEach { (gesture) in
            gesture.isEnabled = isEnabled
        }
        interactivePopGestureRecognizer.isEnabled = isEnabled
    }
    
    ///左滑返回关闭(viewDidAppear/viewWillDisappear)
    func popGestureClose() {
        popGesture(false)
    }

    ///左滑返回打开(viewDidAppear/viewWillDisappear)
    func popGestureOpen() {
        popGesture(true)
    }
}


public extension UIViewController{
    
    ///刷新 tabBarItem
    func reloadTabarItem(_ item: (String, UIImage?, UIImage?)) {
        let (title, image, imageH) = item
        guard let img = image,
              let imgH = imageH else {
                tabBarItem = UITabBarItem(title: title, image: nil, selectedImage: nil)
                return }
        
        let value = img.withRenderingMode(.alwaysOriginal)
        let valueH = imgH.withRenderingMode(.alwaysTemplate)
        tabBarItem = UITabBarItem(title: title, image: value, selectedImage: valueH)
    }
}
