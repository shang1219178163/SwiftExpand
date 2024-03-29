//
//  UIApplication+Other.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/4/25.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit
import UserNotifications
import Photos

@objc public extension UIApplication{
    /// 全局token
    static var token: String {
        get {
            return UserDefaults.standard.string(forKey: #function) ?? ""
        }
        set {
            UserDefaults.standard.set(newValue, forKey: #function)
            UserDefaults.standard.synchronize()
        }
    }
    
    /// 是否已经登录
    static var isLogin: Bool {
        return UIApplication.token.count > 0
    }
    
    /// 网络状态是否可用
    static func reachable() -> Bool {
        let data = NSData(contentsOf: URL(string: "https://www.baidu.com/")!)
        return (data != nil)
    }
    
    /// 用户相册是否可用
    static func hasRightOfPhotoLibrary() -> Bool {
        var isHasRight = false
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                isHasRight = true
          
            default:
                isHasRight = false
            }
        }
        return isHasRight
    }
    
    ///打开应用自己的设置页面
    func openSettings() {
        guard let url = URL(string: UIApplication.openSettingsURLString) else {
            print("api 失效, 请更新")
            return
        }
        open(url, options: [:], completionHandler: nil)
    }
    
    /// 注册APNs远程推送
    static func registerAPNsWithDelegate(_ delegate: UNUserNotificationCenterDelegate, completionHandler: @escaping (Bool, Error?) -> Void) {
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            let center = UNUserNotificationCenter.current()
            center.delegate = delegate
            center.requestAuthorization(options: options, completionHandler: completionHandler)
            UIApplication.shared.registerForRemoteNotifications()

    }
    
    /// app商店链接
    static func appUrlWithID(_ appStoreID: String) -> String {
        let appStoreUrl = "itms-apps://itunes.apple.com/app/id\(appStoreID)?mt=8"
        return appStoreUrl
    }
    
    /// app详情链接
    static func appDetailUrlWithID(_ appStoreID: String) -> String {
        let detailUrl = "http://itunes.apple.com/cn/lookup?id=\(appStoreID)"
        return detailUrl
    }
    
    /// 版本升级
    static func updateVersionShow(appStoreID: String, isForce: Bool = false) {
        UIApplication.updateVersion(appStoreID: appStoreID) { (dic, appStoreVer, releaseNotes, isUpdate) in
            if isUpdate == false {
                return
            }
            DispatchQueue.main.async {
                let titles = isForce == false ? [kTitleUpdate, kTitleCancell] : [kTitleUpdate]
                //富文本效果
                let paraStyle = NSMutableParagraphStyle()
                    .lineBreakModeChain(.byCharWrapping)
                    .lineSpacingChain(5)
                    .alignmentChain(.left)
                
                let title = "新版本 v\(appStoreVer)"
                let message = "\n\(releaseNotes)"
                UIAlertController(title: title, message: message, preferredStyle: .alert)
                    .addActionTitles(titles) { (alertVC, action) in
                        if action.title == kTitleUpdate {
                            //去升级
                            UIApplication.openURLString(UIApplication.appUrlWithID(appStoreID))
                        }
                    }
                    .setTitleColor(UIColor.theme)
                    .setMessageParaStyle(paraStyle)
                    .present()
            }
        }
    }
    
    /// 版本升级
    static func updateVersion(appStoreID: String, block:@escaping (([String: Any], String, String, Bool)->Void)) {
//        let path = "http://itunes.apple.com/cn/lookup?id=\(appStoreID)"
        let path =  UIApplication.appDetailUrlWithID(appStoreID)
        let request = URLRequest(url:NSURL(string: path)! as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 6)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, respone, error) in
            guard let data = data,
                  let dic = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? [String: Any] else {
                print("字典不能为空")
                return
            }
            
            guard let resultCount = dic["resultCount"] as? NSNumber,
                  resultCount.intValue == 1 else {
                print("resultCount错误")
                return
            }
            
            guard let list = dic["results"] as? NSArray,
                let dicInfo = list[0] as? [String: Any],
                let appStoreVer = dicInfo["version"] as? String
            else {
                print("dicInfo错误")
                return
            }
                        
            let releaseNotes: String = (dicInfo["releaseNotes"] as? String) ?? ""
            let isUpdate = appStoreVer.compare(UIApplication.appVer, options: .numeric, range: nil, locale: nil) == .orderedDescending
            block(dicInfo, appStoreVer, releaseNotes, isUpdate)
        }
        dataTask.resume()
    }

}


@available(iOS 10.0, *)
@objc public extension UNMutableNotificationContent{
    ///创建本地通知
    convenience init(_ title: String, body: String, userInfo: [AnyHashable: Any], sound: UNNotificationSound = .default) {
        self.init()
        self.title = title
        self.body = body
        self.userInfo = userInfo
        self.sound = sound
    }
    
    ///添加TimeInterval本地通知到通知中心
    func addRequestToCenter(_ trigger: UNNotificationTrigger,
                            handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        let identifier = DateFormatter.stringFromDate(Date())
        let request = UNNotificationRequest(identifier: identifier, content: self, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            handler?(center, request, error as NSError?)
            if let error = error {
                DDLog("推送添加失败: %@", error.localizedDescription)
            }
        }
    }
    
    ///添加TimeInterval本地通知到通知中心
    func addTimeIntervalRequestToCenter(_ timeInterval: TimeInterval = 1,
                                        repeats: Bool = false,
                                        handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        /// 几秒后触发，如果要设置可重复触发需要大于60
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)
        addRequestToCenter(trigger, handler: handler)
    }
    ///添加Calendar本地通知到通知中心
    func addCalendarRequestToCenter(_ dateComponents: DateComponents,
                                    repeats: Bool = false,
                                    handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        ///某年某月某日某天某时某分某秒触发
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        addRequestToCenter(trigger, handler: handler)
    }
    ///添加Location本地通知到通知中心
    func addLocationRequestToCenter(_ region: CLCircularRegion,
                                    repeats: Bool = false,
                                    handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        ///在某个位置触发
        let trigger = UNLocationNotificationTrigger(region: region, repeats: repeats)
        addRequestToCenter(trigger, handler: handler)
    }
}
