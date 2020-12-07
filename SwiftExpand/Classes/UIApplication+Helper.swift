//
//  UIApplication+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/24.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UIApplication{
    private struct AssociateKeys {
        static var mainWindow   = "UIApplication" + "mainWindow"
    }
    
    static var isPortrait: Bool {
        //横竖屏判断
        let orientation = UIApplication.shared.statusBarOrientation
        return orientation.isPortrait
    }
    
    @available(iOS 13.0, *)
    static var isDarkMode: Bool {
        return UITraitCollection.current.userInterfaceStyle == .dark
    }
    
    static var appName: String {
        guard let infoDic = Bundle.main.infoDictionary else { return "" }
        if let value = infoDic["CFBundleDisplayName"] as? String {
            return value
        }
        
        if let value = infoDic[kCFBundleExecutableKey as String] as? String {
            return value
        }
        return ""
    }
    
    static var appBundleName: String {
        guard let infoDic = Bundle.main.infoDictionary,
              let value = infoDic["CFBundleExecutable"] as? String
        else { return "" }
        return value
    }
    
    static var appIcon: UIImage {
        guard let infoDic = Bundle.main.infoDictionary,
            let iconFiles: [Any] = infoDic["CFBundleIcons.CFBundlePrimaryIcon.CFBundleIconFiles"] as? [Any],
            let imgName: String = iconFiles.last as? String,
            let image = UIImage(named: imgName)
            else { return UIImage() }
        return image
    }
    
    static var appVer: String {
        guard let infoDic = Bundle.main.infoDictionary,
            let version = infoDic["CFBundleShortVersionString"] as? String
        else { return "" }
        return version
    }
    
    static var appBuild: String {
        guard let infoDic = Bundle.main.infoDictionary,
            let version = infoDic["CFBundleVersion"] as? String
        else { return "" }
        return version
    }
    
    static var deviceSystemVer: String {
        return UIDevice.current.systemVersion;
    }
    
    static var deviceSystemName: String {
        return UIDevice.current.systemName;
    }
    
    static var deviceName: String {
        return UIDevice.current.name;
    }
    
    static var deviceModelName: String {
        var systemInfo = utsname()
        uname(&systemInfo)
        
        let identifier = withUnsafePointer(to: &systemInfo.machine.0) { ptr in
            return String(cString: ptr)
        }
        
        switch identifier {
        case "iPod1,1":  return "iPod Touch 1"
        case "iPod2,1":  return "iPod Touch 2"
        case "iPod3,1":  return "iPod Touch 3"
        case "iPod4,1":  return "iPod Touch 4"
        case "iPod5,1":  return "iPod Touch (5 Gen)"
        case "iPod7,1":  return "iPod Touch 6"
            
        case "iPhone3,1", "iPhone3,2", "iPhone3,3":  return "iPhone 4"
        case "iPhone4,1":  return "iPhone 4s"
        case "iPhone5,1":  return "iPhone 5"
        case "iPhone5,2":  return "iPhone 5 (GSM+CDMA)"
        case "iPhone5,3":  return "iPhone 5c (GSM)"
        case "iPhone5,4":  return "iPhone 5c (GSM+CDMA)"
        case "iPhone6,1":  return "iPhone 5s (GSM)"
        case "iPhone6,2":  return "iPhone 5s (GSM+CDMA)"
        case "iPhone7,2":  return "iPhone 6"
        case "iPhone7,1":  return "iPhone 6 Plus"
        case "iPhone8,1":  return "iPhone 6s"
        case "iPhone8,2":  return "iPhone 6s Plus"
        case "iPhone8,4":  return "iPhone SE"
        case "iPhone9,1":  return "国行、日版、港行iPhone 7"
        case "iPhone9,2":  return "港行、国行iPhone 7 Plus"
        case "iPhone9,3":  return "美版、台版iPhone 7"
        case "iPhone9,4":  return "美版、台版iPhone 7 Plus"
        case "iPhone10,1","iPhone10,4":   return "iPhone 8"
        case "iPhone10,2","iPhone10,5":   return "iPhone 8 Plus"
        case "iPhone10,3","iPhone10,6":   return "iPhone X"
        case "iPhone11,2":                return "iPhone XS"
        case "iPhone11,4", "iPhone11,6":  return "iPhone XS Max"
        case "iPhone11,8":                return "iPhone XR"
        case "iPhone12,1":                return "iPhone 11"
        case "iPhone12,3":                return "iPhone 11 Pro"
        case "iPhone12,5":                return "iPhone 11 Pro Max"
            
        case "iPad1,1":   return "iPad"
        case "iPad1,2":   return "iPad 3G"
        case "iPad2,1", "iPad2,2", "iPad2,3", "iPad2,4":   return "iPad 2"
        case "iPad2,5", "iPad2,6", "iPad2,7":  return "iPad Mini"
        case "iPad3,1", "iPad3,2", "iPad3,3":  return "iPad 3"
        case "iPad3,4", "iPad3,5", "iPad3,6":   return "iPad 4"
        case "iPad4,1", "iPad4,2", "iPad4,3":   return "iPad Air"
        case "iPad4,4", "iPad4,5", "iPad4,6":  return "iPad Mini 2"
        case "iPad4,7", "iPad4,8", "iPad4,9":  return "iPad Mini 3"
        case "iPad5,1", "iPad5,2":  return "iPad Mini 4"
        case "iPad5,3", "iPad5,4":  return "iPad Air 2"
        case "iPad6,3", "iPad6,4":  return "iPad Pro 9.7"
        case "iPad6,7", "iPad6,8":  return "iPad Pro 12.9"
        case "iPad7,1", "iPad7,2":                      return "iPad Pro (12.9-inch) (2nd generation)"
        case "iPad7,3", "iPad7,4":                      return "iPad Pro (10.5-inch)"
        case "iPad8,1", "iPad8,2", "iPad8,3", "iPad8,4":return "iPad Pro (11-inch)"
        case "iPad8,5", "iPad8,6", "iPad8,7", "iPad8,8":return "iPad Pro (12.9-inch) (3rd generation)"
        case "AppleTV2,1":  return "Apple TV 2"
        case "AppleTV3,1","AppleTV3,2":  return "Apple TV 3"
        case "AppleTV5,3":   return "Apple TV 4"
        case "i386", "x86_64":   return "Simulator"
        default:  return identifier
        }
    }
    
    static var mainWindow: UIWindow {
        get {
            if let window = objc_getAssociatedObject(self,  &AssociateKeys.mainWindow) as? UIWindow {
                return window
            }
            let window = UIWindow(frame: UIScreen.main.bounds)
            window.backgroundColor = UIColor.white
            window.makeKeyAndVisible()
            
            objc_setAssociatedObject(self,  &AssociateKeys.mainWindow, window, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return window
        }
        set {
            objc_setAssociatedObject(self,  &AssociateKeys.mainWindow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// keyWindow代替品
    var currentKeyWindow: UIWindow? {
        get {
//            UIApplication.shared.delegate?.window
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
            }
            return UIApplication.shared.keyWindow
        }
    }
        
    static var rootController: UIViewController? {
        get {
            return UIApplication.mainWindow.rootViewController
        }
        set {
            guard let newValue = newValue else { return }
            UIApplication.mainWindow.rootViewController = newValue;
        }
    }
    
    static var tabBarController: UITabBarController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
            return nil }
        return rootVC
    }
    
    ///当前导航控制器
    static var navController: UINavigationController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return nil }
        
        if rootVC.isKind(of: UINavigationController.self) {
            return (rootVC as! UINavigationController)
        }
        
        if let tabBarVC = rootVC as? UITabBarController,
           let navController = tabBarVC.selectedViewController as? UINavigationController {
            return navController
        }
        return nil
    }
    ///当前控制器
    static var currentVC: UIViewController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return nil}
        
        if let presentedViewController = rootVC.presentedViewController {
            if presentedViewController.isKind(of: UINavigationController.self) {
                return (presentedViewController as! UINavigationController).topViewController
            }
            return presentedViewController as! UINavigationController
        }
        
        if rootVC.isKind(of: UINavigationController.self) {
            return (rootVC as! UINavigationController).topViewController
        }
        
        if rootVC.isKind(of: UITabBarController.self) {
            let tabBarVC = rootVC as! UITabBarController
            if let selectedViewController = tabBarVC.selectedViewController {
                if selectedViewController.isKind(of: UINavigationController.self) {
                    return (selectedViewController as! UINavigationController).topViewController
                }
                return selectedViewController
            }
            return tabBarVC.viewControllers?.first
        }
        return nil
    }
    
    //MARK: func
    static func setupRootController(_ vc: UIViewController, isAdjust: Bool = true) {
        if !isAdjust {
            UIApplication.rootController = vc
            return;
        }
        
        if vc is UINavigationController || vc is UITabBarController {
            UIApplication.rootController = vc
        } else {
            UIApplication.rootController = UINavigationController(rootViewController: vc);
        }
    }
    
    ///默认风格是白色导航栏黑色标题
    static func setupAppearanceDefault(_ isDefault: Bool = true) {
        let barTintColor: UIColor = isDefault ? UIColor.white : UIColor.theme
        setupAppearanceNavigationBar(barTintColor)
        setupAppearanceScrollView()
        setupAppearanceOthers();
    }
    
    /// 配置UIScrollView默认值
    static func setupAppearanceScrollView() {
        UITableView.appearance().separatorStyle = .singleLine;
        UITableView.appearance().separatorInset = .zero;
        UITableView.appearance().rowHeight = 60;
        
        UITableViewCell.appearance().layoutMargins = .zero;
        UITableViewCell.appearance().separatorInset = .zero;
        UITableViewCell.appearance().selectionStyle = .none;
        
        UIScrollView.appearance().keyboardDismissMode = .onDrag;
        
        if #available(iOS 11.0, *) {
            UITableView.appearance().estimatedRowHeight = 0.0;
            UITableView.appearance().estimatedSectionHeaderHeight = 0.0;
            UITableView.appearance().estimatedSectionFooterHeight = 0.0;
            
            UICollectionView.appearance().contentInsetAdjustmentBehavior = .never;
            UIScrollView.appearance().contentInsetAdjustmentBehavior = .never;
        }
    }
    
    static func setupAppearanceOthers() {
        UIButton.appearance().isExclusiveTouch = false;

        UITabBar.appearance().tintColor = UIColor.theme;
        UITabBar.appearance().barTintColor = UIColor.white;
        UITabBar.appearance().isTranslucent = false;
        
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = UIColor.gray;
        }
        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0)
    }
    
    /// 配置UINavigationBar默认值
    static func setupAppearanceNavigationBar(_ barTintColor: UIColor) {
        let isDefault: Bool = UIColor.white.equalTo(barTintColor);
        let tintColor = isDefault ? UIColor.black : UIColor.white;
        
        let navBar = UINavigationBar.appearance();
        navBar.tintColor = tintColor;
        navBar.barTintColor = barTintColor;
        navBar.setBackgroundImage(UIImage(color: barTintColor), for: UIBarPosition.any, barMetrics: .default)
        navBar.shadowImage = UIImage(color: barTintColor);
        navBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: tintColor,]

        // 自定义返回按钮的图片
        let backImage = UIImage(named: "icon_arowLeft_black")?.withRenderingMode(.alwaysTemplate);
        navBar.backIndicatorImage = backImage;
        navBar.backIndicatorTransitionMaskImage = backImage;

        // 字体设置
        let barItem = UIBarButtonItem.appearance();
        barItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                        NSAttributedString.Key.foregroundColor: tintColor,
                                        NSAttributedString.Key.backgroundColor: barTintColor
        ], for: .normal);
        barItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                        NSAttributedString.Key.backgroundColor: barTintColor,
                                        NSAttributedString.Key.foregroundColor: UIColor.gray
        ],for: .disabled);
        
        // 去除返回按钮的标题
        if #available(iOS 11, *) {
            // 这种隐藏的不止返回按钮，导航栏上的其他按钮标题也会被隐藏调
//            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.clear], for: .normal);
//            barItem.setTitleTextAttributes([NSAttributedString.Key.foregroundColor : UIColor.clear], for: .highlighted);
        } else {
            barItem.setBackButtonTitlePositionAdjustment(UIOffset(horizontal: 0, vertical: -64), for: .default);
        }
        ///
        let otherBarItem = UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIButton.self, UILabel.self])
        otherBarItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                        NSAttributedString.Key.foregroundColor : tintColor], for: .normal);
        barItem.setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                                        NSAttributedString.Key.foregroundColor : UIColor.gray], for: .disabled);
    }
    
//    static func setupAppearanceTabBar() {
        //         设置字体颜色
//        let attDic_N = [NSAttributedString.Key.foregroundColor: UIColor.black];
//        let attDic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme];
//        UITabBarItem.appearance().setTitleTextAttributes(attDic_N, for: .normal);
//        UITabBarItem.appearance().setTitleTextAttributes(attDic_H, for: .selected);
//        // 设置字体偏移
//        UITabBarItem.appearance().titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0);
        // 设置图标选中时颜色
//        UITabBar.appearance().tintColor = .red;
//    }
    
    static func setupAppearanceSearchbarCancellButton(_ textColor: UIColor = .theme) {
        let shandow: NSShadow = {
            let shadow = NSShadow();
            shadow.shadowColor = UIColor.darkGray;
            shadow.shadowOffset = CGSize(width: 0, height: -1);
            return shadow;
        }();
        
        let dic: [NSAttributedString.Key: Any] = [NSAttributedString.Key.foregroundColor:  textColor,
                                                  NSAttributedString.Key.font:  UIFont.systemFont(ofSize: 13),
                                                  NSAttributedString.Key.shadow:  shandow,
        ]
        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .normal)
        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .highlighted)
        UIBarButtonItem.appearance().setTitleTextAttributes(dic, for: .selected)

        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self])
    }
    
    /// http/https请求链接
    func isNormalURL(_ url: NSURL) -> Bool {
        guard let scheme = url.scheme else {
            fatalError("url.scheme不能为nil")
        }
        
        let schemes = ["http", "https"]
        return schemes.contains(scheme)
    }
    
    static let kPrefixHttp = "http://"
    
    static let kPrefixTel = "tel://"
        
    /// 打开网络链接
    static func openURLString(_ string: String, prefix: String = "") {
//        let set = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: set)!;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        
        var tmp = string
        if string.hasPrefix(prefix) == false {
            tmp = prefix + string
        }
        if tmp.hasPrefix("tel") {
            tmp = tmp.replacingOccurrences(of: "-", with: "")
        }
        guard let url = URL(string: tmp) as URL? else {
            print("\(#function):链接无法打开!!!\n\(string)");
            return
        }

        if UIApplication.shared.canOpenURL(url) == false {
            print("\(#function):链接无法打开!!!\n\(string)");
            return
        }
        UIApplication.openURL(url);
    }
    
    /// 打开网络链接
    static func openURL(_ url: URL) {
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    /// 远程推送deviceToken处理
    static func deviceTokenString(_ deviceToken: NSData) -> String{
        var deviceTokenString = String()
        if #available(iOS 13.0, *) {
            let bytes = [UInt8](deviceToken)
            for item in bytes {
                deviceTokenString += String(format:"%02x", item&0x000000FF)
            }
            
        } else {
            deviceTokenString = deviceToken.description.trimmingCharacters(in: CharacterSet(charactersIn: "<> "))
        }
#if DEBUG
        print("deviceToken：\(deviceTokenString)");
#endif
        return deviceTokenString;
    }
    
    /// block内任务后台执行(block为空可填入AppDelegate.m方法 applicationDidEnterBackground中)
    static func didEnterBackground(_ block: (()->Void)? = nil) {
        let application: UIApplication = UIApplication.shared;
        var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0);
        //注册一个后台任务，并提供一个在时间耗尽时执行的代码块
        bgTask = application.beginBackgroundTask(expirationHandler: {
            if bgTask != UIBackgroundTaskIdentifier.invalid {
                //当时间耗尽时调用这个代码块
                //如果在这个代码块返回之前没有调用endBackgroundTask
                //应用程序将被终止
                application.endBackgroundTask(bgTask)
                bgTask = UIBackgroundTaskIdentifier.invalid
            }
        });
        
        let backgroundQueue = OperationQueue()
        backgroundQueue.addOperation() {
            //完成一些工作。我们有几分钟的时间来完成它
            //在结束时，必须调用endBackgroundTask
            NSLog("Doing some background work!")
            block?()
            application.endBackgroundTask(bgTask)
            bgTask = UIBackgroundTaskIdentifier.invalid
        }
    }
    /// 配置app图标(传 nil 恢复默认)
    static func setAppIcon(name: String?) {
        //判断是否支持替换图标, false: 不支持
        if #available(iOS 10.3, *) {
            //判断是否支持替换图标, false: 不支持
            guard UIApplication.shared.supportsAlternateIcons else { return }
            
            //如果支持, 替换icon
            UIApplication.shared.setAlternateIconName(name) { (error) in
                //点击弹框的确认按钮后的回调
                if error != nil {
                    print(error ?? "更换icon发生错误")
                }
            }
        }
    }
}
