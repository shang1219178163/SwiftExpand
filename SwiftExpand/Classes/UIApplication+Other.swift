//
//  UIApplication+Other.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/4/25.
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
        return UIApplication.token.count > 0;
    }
    
    /// 网络状态是否可用
    static func reachable() -> Bool {
        let data = NSData(contentsOf: URL(string: "https://www.baidu.com/")!)
        return (data != nil)
    }
    /// 消息推送是否可用
    static func hasRightOfPush() -> Bool {
        let notOpen = UIApplication.shared.currentUserNotificationSettings?.types == UIUserNotificationType(rawValue: 0)
        return !notOpen;
    }
    /// 用户相册是否可用
    static func hasRightOfPhotoLibrary() -> Bool {
        var isHasRight = false;
        
        PHPhotoLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                isHasRight = true;
          
            default:
                isHasRight = false;
            }
        }
        return isHasRight;
    }
    
    /// 注册APNs远程推送
    static func registerAPNsWithDelegate(_ delegate: Any) {
        if #available(iOS 10.0, *) {
            let options: UNAuthorizationOptions = [.alert, .badge, .sound]
            let center = UNUserNotificationCenter.current()
            center.delegate = (delegate as! UNUserNotificationCenterDelegate);
            center.requestAuthorization(options: options){ (granted: Bool, error:Error?) in
                if granted {
                    print("success")
                }
            }
            UIApplication.shared.registerForRemoteNotifications()
            //            center.delegate = self
        } else {
            // 请求授权
            let types: UIUserNotificationType = [.alert, .badge, .sound]
            let settings = UIUserNotificationSettings(types: types, categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            // 需要通过设备UDID, 和app bundle id, 发送请求, 获取deviceToken
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    @available(iOS 10.0, *)
    func addLocalUserNoti(trigger: AnyObject,
                          content: UNMutableNotificationContent,
                          identifier: String,
                          notiCategories: AnyObject,
                          repeats: Bool = true,
                          handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        
        var notiTrigger: UNNotificationTrigger?
        if let date = trigger as? NSDate {
            var interval = date.timeIntervalSince1970 - NSDate().timeIntervalSince1970;
            interval = interval < 0 ? 1 : interval;
            
            notiTrigger = UNTimeIntervalNotificationTrigger(timeInterval: interval, repeats: repeats)
        } else if let components = trigger as? DateComponents {
            notiTrigger = UNCalendarNotificationTrigger(dateMatching: components as DateComponents, repeats: repeats)
            
        } else if let region = trigger as? CLCircularRegion {
            notiTrigger = UNLocationNotificationTrigger(region: region, repeats: repeats)
            
        }
        
        let request = UNNotificationRequest(identifier: identifier, content: content, trigger: notiTrigger)
        let center = UNUserNotificationCenter.current()
        
        center.add(request) { (error) in
            if error == nil {
                return;
            }
            DDLog("推送已添加成功");
        }
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
    static func updateVersion(appStoreID: String, isForce: Bool = false) {
        UIApplication.updateVersion(appStoreID: appStoreID) { (dic, appStoreVer, releaseNotes, isUpdate) in
            if isUpdate == false {
                return;
            }
            DispatchQueue.main.async {
                let titles = isForce == false ? [kTitleUpdate, kTitleCancell] : [kTitleUpdate];
                //富文本效果
                let paraStyle = NSMutableParagraphStyle.create(.byCharWrapping, alignment: .left)
                
                let title = "新版本 v\(appStoreVer)"
                let message = "\n\(releaseNotes)"
                UIAlertController(title: title, message: message, preferredStyle: .alert)
                    .addActionTitles(titles) { (action) in
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
    func create(_ title: String, body: String, userInfo: [AnyHashable : Any], sound: UNNotificationSound = .default) -> UNMutableNotificationContent {
        // 1. 创建通知内容
        let content = UNMutableNotificationContent()
        // 标题
        content.title = title
        // 内容
        content.body = body
        
        content.userInfo = userInfo
        // 通知提示音
        content.sound = sound
        
        return content
    }
    ///添加TimeInterval本地通知到通知中心
    func addTimeIntervalRequestToCenter(_ timeInterval: TimeInterval = 1,
                                        repeats: Bool = false,
                                        handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        let identifier = DateFormatter.stringFromDate(Date())
        /// 几秒后触发，如果要设置可重复触发需要大于60
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval: timeInterval, repeats: repeats)

        let request = UNNotificationRequest(identifier: identifier, content: self, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            handler?(center, request, error as NSError?)
            if error != nil {
                DDLog("推送添加失败: %@", error!.localizedDescription);
            }
        }
    }
    ///添加Calendar本地通知到通知中心
    func addCalendarRequestToCenter(_ dateComponents: DateComponents,
                                    repeats: Bool = false,
                                    handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        let identifier = DateFormatter.stringFromDate(Date())
        ///某年某月某日某天某时某分某秒触发
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: identifier, content: self, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            handler?(center, request, error as NSError?)
            if error != nil {
                DDLog("推送添加失败: %@", error!.localizedDescription);
            }
        }
    }
    ///添加Location本地通知到通知中心
    func addLocationRequestToCenter(_ region: CLCircularRegion,
                                    repeats: Bool = false,
                                    handler: ((UNUserNotificationCenter, UNNotificationRequest, NSError?)->Void)?) {
        let identifier = DateFormatter.stringFromDate(Date())
        ///在某个位置触发
        let trigger = UNLocationNotificationTrigger(region: region, repeats: repeats)
        
        let request = UNNotificationRequest(identifier: identifier, content: self, trigger: trigger)
        
        let center = UNUserNotificationCenter.current()
        center.add(request) { (error) in
            handler?(center, request, error as NSError?)
            if error != nil {
                DDLog("推送添加失败: %@", error!.localizedDescription);
            }
        }
    }
}
