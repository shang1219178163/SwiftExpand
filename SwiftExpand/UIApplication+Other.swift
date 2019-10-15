//
//  UIApplication+Other.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/4/25.
//

import UIKit
import UserNotifications
import Photos
import AVFoundation
import Speech
import MediaPlayer
import CoreBluetooth
import CoreLocation
import EventKit
import Contacts
import StoreKit

@objc public extension UIApplication{

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
    
    @available(iOS 9.3, *)
    /// 媒体库是否可用
    static func hasRightOfMediaLibrary() -> Bool {
        var isHasRight = false;
        
        MPMediaLibrary.requestAuthorization { (status) in
            switch status {
            case .authorized:
                isHasRight = true;
                
            default:
                isHasRight = false;
            }
        }
        return isHasRight;
    }
    /// 是否有音视频捕捉权限
    static func hasRightOfAVCapture(_ mediaType: AVMediaType = AVMediaType.video) -> Bool {
        var isHasRight = false;

//        let device = AVCaptureDevice.devices(for: mediaType)
        let status = AVCaptureDevice.authorizationStatus(for: mediaType);
        switch status {
        case .authorized:
            isHasRight = true;
            
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType) { (granted) in
                isHasRight = granted;
            }
            
        default:
            isHasRight = false;
        }
        return isHasRight;
    }
    /// 是否已经打开蓝牙捕捉
    static func hasOpenOfBluetooth() -> Bool {
        var isHasRight = false;
        let centralManager = CBCentralManager();
        switch centralManager.state {
        case .poweredOn:
            isHasRight = true;
            
        default:
            isHasRight = false;
        }
        return isHasRight;
    }
    
    /// 媒体库是否可用
    @available(iOS 10.0, *)
    static func hasRightOfSpeechRecognizer() -> Bool {
        var isHasRight = false;
        
        SFSpeechRecognizer.requestAuthorization { (status) in
            switch status {
            case .authorized:
                isHasRight = true;
                
            default:
                isHasRight = false;
            }
        }
        return isHasRight;
    }
    
    /// 日历是否可用
    @available(iOS 10.0, *)
    static func hasRightOfEventStore(_ entityType: EKEntityType = EKEntityType.reminder) -> Bool {
        var isHasRight = false;
        
        let store = EKEventStore()
        store.requestAccess(to: entityType) { (granted, error) in
            if granted == true {
                isHasRight = granted;

            } else {
                let status = EKEventStore.authorizationStatus(for: .event);
                switch status {
                case .authorized:
                    isHasRight = true;
                    
                default:
                    isHasRight = false;
                }
            }
        }
        return isHasRight;
    }
    
    /// 通讯录是否可用
    @available(iOS 10.0, *)
    static func hasRightOfContactStore(_ entityType: CNEntityType = CNEntityType.contacts) -> Bool {
        var isHasRight = false;
        
        let store = CNContactStore()
        store.requestAccess(for: entityType) { (granted, error) in
            if granted == true {
                isHasRight = granted;
                
            } else {
                let status = EKEventStore.authorizationStatus(for: .event);
                switch status {
                case .authorized:
                    isHasRight = true;
                    
                default:
                    isHasRight = false;
                }
            }
        }
        return isHasRight;
    }
    
    /**
     注册APNs远程推送
     */
    static func registerAPNsWithDelegate(_ delegate: Any) {
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
    static func updateVersion(appStoreID: String, isForce: Bool = false) -> Bool {
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
                        let titles = isForce == false ? [kActionTitle_Update, kActionTitle_Cancell] : [kActionTitle_Update];
                        let alertController = UIAlertController.createAlert("新版本 v\(appStoreVer)", msg: "\n\(releaseNotes)", actionTitles: titles, handler: { (controller: UIAlertController, action: UIAlertAction) in
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
                        UIApplication.shared.keyWindow?.rootViewController?.present(alertController, animated: true, completion: nil)
                        
                    }
                }
            }
        }
        dataTask.resume()
        return isUpdate;
    }

    /// 应用下载其他应用
    static func jumpAppStore(_ appID: String, controller: UIViewController) {
        let productVC = SKStoreProductViewController();
        productVC.delegate = (controller as! SKStoreProductViewControllerDelegate);
        
        let params = [SKStoreProductParameterITunesItemIdentifier: appID]
        productVC.loadProduct(withParameters: params) { (result, error) in
            if result == true {
                controller.present(productVC, animated: true, completion: nil);
            } else {
                DDLog("打开商店失败!!!");
            }
        }
    }
}
