//
//  UIApplication+Other.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/4/25.
//

import UIKit
import UserNotifications

extension UIApplication{

    /// 网络状态是否可用
    @objc public static func reachable() -> Bool {
        let data = NSData(contentsOf: URL(string: "https://www.baidu.com/")!)
        return (data != nil)
    }
    
    /**
     注册APNs远程推送
     */
    public static func registerAPNsWithDelegate(_ delegate: Any) -> Void {
        
        if #available(iOS 10.0, *) {
            let options = UNAuthorizationOptions(rawValue : UNAuthorizationOptions.alert.rawValue | UNAuthorizationOptions.badge.rawValue | UNAuthorizationOptions.sound.rawValue)
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
            let types = UIUserNotificationType.alert.rawValue | UIUserNotificationType.badge.rawValue | UIUserNotificationType.sound.rawValue
            let settings = UIUserNotificationSettings(types: UIUserNotificationType(rawValue: types), categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            // 需要通过设备UDID, 和app bundle id, 发送请求, 获取deviceToken
            UIApplication.shared.registerForRemoteNotifications()
        }
    }
    
    /// app商店链接
    public static func appUrlWithID(_ appStoreID: String) -> String {
        let appStoreUrl = "itms-apps://itunes.apple.com/app/id\(appStoreID)?mt=8"
        return appStoreUrl
    }
    
    /// app详情链接
    public static func appDetailUrlWithID(_ appStoreID: String) -> String {
        let detailUrl = "http://itunes.apple.com/cn/lookup?id=\(appStoreID)"
        return detailUrl
    }
    
    /// 版本升级
    public static func checkVersion(_ appStoreID: String) -> Bool {
        var isUpdate = false;
        
//        let path = "http://itunes.apple.com/cn/lookup?id=\(appStoreID)"
        let path =  UIApplication.appDetailUrlWithID(appStoreID)
        let request = URLRequest(url:NSURL(string: path)! as URL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 6)
        let dataTask = URLSession.shared.dataTask(with: request) { (data, respone, error) in
            guard let data = data, let json = try? JSONSerialization.jsonObject(with: data, options: .mutableLeaves) else {
                print("字典不能为空")
                return
            }
            
            guard let dic = json as? Dictionary<String, Any> else {
                print("数据格式错误")
                return
            }
            
            guard (dic["resultCount"] as! NSNumber).intValue == 1 else {
                print("resultCount错误")
                return
            }
            
            guard let list = dic["results"] as? NSArray else {
                print("dicInfo错误")
                return
            }
            
            guard let dicInfo = list[0] as? Dictionary<String, Any> else {
                print("dicInfo错误")
                return
            }
            
            let releaseNotes = dicInfo["releaseNotes"] ?? "";
//            print(dicInfo);
            if let appStoreVer = dicInfo["version"] as? String {
                isUpdate = appStoreVer.compare(UIApplication.appVer, options: .numeric, range: nil, locale: nil) == .orderedDescending
                if isUpdate == true {
                    DispatchQueue.main.async {
                        let alertController = UIAlertController.showAlert("新版本 v\(appStoreVer)", msg: releaseNotes as! String, actionTitles: [kActionTitle_Update, kActionTitle_Cancell], handler: { (controller: UIAlertController, action: UIAlertAction) in
                            if action.title == kActionTitle_Update {
                                //去升级
                                UIApplication.openURL(UIApplication.appUrlWithID(appStoreID))
                            }
                        })
                        
                        //富文本效果
                        let paraStyle = NSMutableParagraphStyle.create(.byCharWrapping, alignment: .left)
                        alertController.setTitleColor(UIColor.theme)
                        alertController.setMessageParaStyle(paraStyle)
//                        alertController.actions.first?.setValue(UIColor.orange, forKey: kAlertActionColor);
                    }
                }
            }
        }
        dataTask.resume()
        return isUpdate;
    }

   

}
