//
//  UIApplication+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/24.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

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
        return UIDevice.current.systemVersion
    }
    
    static var deviceSystemName: String {
        return UIDevice.current.systemName
    }
    
    static var deviceName: String {
        return UIDevice.current.name
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
            
            objc_setAssociatedObject(self,  &AssociateKeys.mainWindow, window, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return window
        }
        set {
            objc_setAssociatedObject(self,  &AssociateKeys.mainWindow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    /// keyWindow代替品
    var currentKeyWindow: UIWindow? {
        get {
            if #available(iOS 13.0, *) {
                return UIApplication.shared.windows.filter({ $0.isKeyWindow }).first
            }
            return UIApplication.shared.keyWindow ?? UIApplication.shared.windows.first
        }
    }
    
    static var tabBarController: UITabBarController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController as? UITabBarController else {
            return nil }
        return rootVC
    }

    ///当前控制器
    static var currentVC: UIViewController? {
        guard let rootVC = UIApplication.shared.keyWindow?.rootViewController else { return nil}
        
        if let presentedVC = rootVC.presentedViewController {
            if let nav = presentedVC as? UINavigationController {
                return nav.topViewController
            }
            return presentedVC
        }
        
        if let nav = rootVC as? UINavigationController {
            return nav.topViewController
        }

        if let tab = rootVC as? UITabBarController {
            if let nav = tab.selectedViewController as? UINavigationController{
                return nav.topViewController
            }
            return tab.viewControllers?.first
        }
        return nil
    }
    
    ///当前导航控制器
    static var navController: UINavigationController? {
        return currentVC?.navigationController
    }
    
    static func topViewController(_ base: UIViewController? = UIApplication.shared.keyWindow?.rootViewController) -> UIViewController? {
          
        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }
          
        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }
          
        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }
        return base
    }
    
    //MARK: func
    
    /// 配置 app 外观主题色
    static func setupAppearance(_ tintColor: UIColor, barTintColor: UIColor) {
        _ = {
            $0.barTintColor = barTintColor
            $0.tintColor = tintColor
            $0.titleTextAttributes = [.foregroundColor: tintColor,
            ]
          }(UINavigationBar.appearance())
        
        
        if #available(iOS 11.0, *) {
            _ = {
                $0.tintColor = nil
            }(UINavigationBar.appearance(whenContainedInInstancesOf: [UIDocumentBrowserViewController.self]))
        }
        
        
        if #available(iOS 13.0, *) {
            let barAppearance = UINavigationBarAppearance.create(tintColor, background: barTintColor, shadowColor: nil)
            _ = {
                $0.standardAppearance = barAppearance
                $0.scrollEdgeAppearance = barAppearance
            }(UINavigationBar.appearance())

            
            let tabbarAppearance = UITabBarAppearance.create(barTintColor, background: tintColor)
            _ = {
                $0.standardAppearance = tabbarAppearance
                if #available(iOS 15.0, *) {
                    $0.scrollEdgeAppearance = tabbarAppearance
                }
            }(UITabBar.appearance())
        } else {
            // Fallback on earlier versions
        }
        
        
        _ = {
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15), ], for: .normal)
            $0.setTitleTextAttributes([.font: UIFont.systemFont(ofSize: 15), ], for: .highlighted)
        }(UIBarButtonItem.appearance(whenContainedInInstancesOf: [UINavigationBar.self]))
        
//        _ = {
//            $0.setTitleTextAttributes([.foregroundColor: tintColor], for: .normal)
//        }(UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]))
        
        _ = {
            $0.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        }(UIBarButtonItem.appearance(whenContainedInInstancesOf: [UIImagePickerController.self]))
        
//        _ = {
//            $0.barTintColor = barTintColor
//            $0.tintColor = tintColor
//            $0.isTranslucent = false
//            $0.unselectedItemTintColor = .gray
//          }(UITabBar.appearance())
        
//        _ = {
//            $0.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -5.0)
//          }(UITabBarItem.appearance())
                
        _ = {
            $0.setTitleColor(.black, for: .normal)
            $0.titleLabel?.adjustsFontSizeToFitWidth = true
            $0.titleLabel?.minimumScaleFactor = 1.0
            $0.imageView?.contentMode = .scaleAspectFit
            $0.isExclusiveTouch = true
            $0.adjustsImageWhenHighlighted = false
          }(UIButton.appearance())
        
        
        if let aClass = NSClassFromString("UICalloutBarButton")! as? UIButton.Type {
            aClass.appearance().setTitleColor(.white, for: .normal)
        }

        
        _ = {
            $0.tintColor = tintColor
          }(UISegmentedControl.appearance())
        
        _ = {
            $0.tintColor = tintColor

            $0.setTitleTextAttributes([.foregroundColor: tintColor,
            ], for: .normal)
            $0.setTitleTextAttributes([.foregroundColor: barTintColor,
            ], for: .selected)
          }(UISegmentedControl.appearance(whenContainedInInstancesOf: [UINavigationBar.self]))

                
        _ = {
            $0.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            $0.showsHorizontalScrollIndicator = false
            $0.keyboardDismissMode = .onDrag
            if #available(iOS 11.0, *) {
                $0.contentInsetAdjustmentBehavior = .never
            }
          }(UIScrollView.appearance())
        
        
        _ = {
            $0.separatorInset = .zero
            $0.separatorStyle = .singleLine
            $0.rowHeight = 60
            $0.backgroundColor = .groupTableViewBackground
            if #available(iOS 11.0, *) {
                $0.estimatedRowHeight = 0.0
                $0.estimatedSectionHeaderHeight = 0.0
                $0.estimatedSectionFooterHeight = 0.0
            }
          }(UITableView.appearance())
        

        _ = {
            $0.layoutMargins = .zero
            $0.separatorInset = .zero
            $0.selectionStyle = .none
            $0.backgroundColor = .white
          }(UITableViewCell.appearance())

        
        _ = {
            $0.scrollsToTop = false
            $0.isPagingEnabled = true
            $0.bounces = false
          }(UICollectionView.appearance())
        
        
        _ = {
            $0.layoutMargins = .zero
            $0.backgroundColor = .white
          }(UICollectionViewCell.appearance())
 
        
        _ = {
            $0.isUserInteractionEnabled = true
          }(UIImageView.appearance())
        
        
        _ = {
            $0.isUserInteractionEnabled = true
          }(UILabel.appearance())
        
        
        _ = {
            $0.pageIndicatorTintColor = barTintColor
            $0.currentPageIndicatorTintColor = tintColor
            $0.isUserInteractionEnabled = true
            $0.hidesForSinglePage = true
          }(UIPageControl.appearance())
        
        
        _ = {
            $0.progressTintColor = barTintColor
            $0.trackTintColor = .clear
          }(UIProgressView.appearance())
        
        
        _ = {
            $0.datePickerMode = .date
            $0.locale = Locale.zh_CN
            $0.backgroundColor = .white
            if #available(iOS 13.4, *) {
                $0.preferredDatePickerStyle = .wheels
            }
          }(UIDatePicker.appearance())
        
        
        _ = {
            $0.minimumTrackTintColor = tintColor
            $0.autoresizingMask = .flexibleWidth
          }(UISlider.appearance())
        
        
        _ = {
            $0.onTintColor = tintColor
            $0.autoresizingMask = .flexibleWidth
          }(UISwitch.appearance())
        
    }
    
    /// http/https请求链接
    func isHttpURL(_ url: NSURL) -> Bool {
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
//        let set = NSCharacterSet(charactersIn: "!*'():@&=+$,/?%#[]").inverted
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: set)!
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        
        var tmp = string
        if string.hasPrefix(prefix) == false {
            tmp = prefix + string
        }
        if tmp.hasPrefix("tel") {
            tmp = tmp.replacingOccurrences(of: "-", with: "")
        }
        guard let url = URL(string: tmp) as URL? else {
            print("\(#function):链接无法打开!!!\n\(string)")
            return
        }

        if UIApplication.shared.canOpenURL(url) == false {
            print("\(#function):链接无法打开!!!\n\(string)")
            return
        }
        UIApplication.shared.open(url, options: [:], completionHandler: nil)
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
        print("deviceToken：\(deviceTokenString)")
#endif
        return deviceTokenString
    }
    
    /// block内任务后台执行(block为空可填入AppDelegate.m方法 applicationDidEnterBackground中)
    static func didEnterBackground(_ block: (()->Void)? = nil) {
        let application: UIApplication = UIApplication.shared
        var bgTask: UIBackgroundTaskIdentifier = UIBackgroundTaskIdentifier(rawValue: 0)
        //注册一个后台任务，并提供一个在时间耗尽时执行的代码块
        bgTask = application.beginBackgroundTask(expirationHandler: {
            if bgTask != UIBackgroundTaskIdentifier.invalid {
                //当时间耗尽时调用这个代码块
                //如果在这个代码块返回之前没有调用endBackgroundTask
                //应用程序将被终止
                application.endBackgroundTask(bgTask)
                bgTask = UIBackgroundTaskIdentifier.invalid
            }
        })
        
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
                if let error = error {
                    print("更换icon发生错误")
                }
            }
        }
    }
}
