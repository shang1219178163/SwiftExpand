//
//  NSApplication+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa
import ServiceManagement

@objc public extension NSApplication{
    private struct AssociateKeys {
        static var mainWindow   = "NSApplication" + "windowDefault"
    }
    
    static var windowDefault: NSWindow {
        get {
            var obj = objc_getAssociatedObject(self, &AssociateKeys.mainWindow) as? NSWindow
            if obj == nil {
                obj = NSWindow.createMain();
                objc_setAssociatedObject(self, &AssociateKeys.mainWindow, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.mainWindow, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    static var appName: String {
        guard let infoDic = Bundle.main.infoDictionary else { return "" }
        if let name = infoDic["CFBundleDisplayName"] as? String {
            return name
        }
        if let bundleName = infoDic[kCFBundleNameKey as String] as? String {
            return bundleName
        }
        return ""
    }
    
    static var appBundleName: String {
        guard let infoDic = Bundle.main.infoDictionary,
        let result = infoDic["CFBundleExecutable"] as? String else { return "" }
        return result
    }
    
    static var appIcon: NSImage {
        let infoDic = Bundle.main.infoDictionary;
        let imgName = infoDic!["CFBundleIconName"]
        return NSImage(named: imgName as! NSImage.Name)!
    }
    
    static var appVer: String {
        guard let infoDic = Bundle.main.infoDictionary,
        let result = infoDic["CFBundleShortVersionString"] as? String else { return "" }
        return result
    }
    
    static var appBuild: String {
        guard let infoDic = Bundle.main.infoDictionary,
        let result = infoDic["CFBundleVersion"] as? String else { return "" }
        return result
    }
    
    static var systemInfo: String {
        guard let infoDic = Bundle.main.infoDictionary,
        let result = infoDic["DTSDKName"] as? String else { return "" }
        return result
    }
    
    static var appCopyright: String {
        guard let infoDic = Bundle.main.infoDictionary,
        let result = infoDic["NSHumanReadableCopyright"] as? String else { return "" }
        return result
    }
    
    static var userName: String {
//        return ProcessInfo.processInfo.userName;
        return ProcessInfo.processInfo.fullUserName;
    }
    
    static var localizedName: String {
        return Host.current().localizedName ?? "";
    }
    
    static var systemDic: NSDictionary? {
        return NSDictionary(contentsOfFile: "/System/Library/CoreServices/SystemVersion.plist")
    }
    /// MacOX
    static var productName: String {
        guard let dic = self.systemDic,
              let name = dic["ProductName"] as? String
              else { return ""}
        return name;
    }
    /// MacOX 版权
    static var productCopyright: String {
        guard let dic = self.systemDic,
              let copyright = dic["ProductCopyright"] as? String
              else { return ""}
        return copyright;
    }
    /// MacOX 版权
    static var productVersion: String {
        guard let dic = self.systemDic,
              let version = dic["ProductVersion"] as? String
              else { return ""}
        return version;
    }
    
    /// 获取默认版权信息
    static var classCopyright: String {
        return copyright(with: "", type: "")
    }
    /// 获取文件版权信息
    static func copyright(with name: String,
                          type: String,
                          bundleName: String = NSApplication.appBundleName,
                          author: String = NSApplication.userName,
                          organization: String = NSApplication.userName) -> String {
        let dateStr = DateFormatter.stringFromDate(Date(), fmt: "yyyy/MM/dd HH:mm")
        let year = dateStr.components(separatedBy: "/").first!

        let fileName = [name, type].contains("") ? "\(name)\(type)" : "\(name).\(type)"
        let result = """
        //
        //\t\(fileName)
        //\t\(bundleName)
        //
        //\tCreated by \(author.capitalized) on \(dateStr)
        //\tCopyright © \(year) \(organization). All rights reserved.
        //\n\n
        """
        return result;
    }
    
    /// http/https请求链接
    func isNormalURL(_ url: NSURL) -> Bool {
        guard let scheme = url.scheme else {
            fatalError("url.scheme不能为nil")
        }
        
        let schemes = ["http", "https"]
        return schemes.contains(scheme)
    }
    
    /// 打开网络链接
    static func openURL(_ urlStr: String, isUrl: Bool = true) {
        if isUrl == true {
            NSApplication.openURLStr(urlStr, prefix: "http://")
        } else {
            NSApplication.openURLStr(urlStr, prefix: "tel://")
        }
    }
    
    /// 打开网络链接(prefix为 http://或 tel:// )
    static func openURLStr(_ urlStr: String, prefix: String = "http://") {
//        let set = NSCharacterSet(charactersIn: "!*'();:@&=+$,/?%#[]").inverted;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: set)!;
//        let str: String = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!;
        var tmp = urlStr;
        if urlStr.hasPrefix(prefix) == false {
            tmp = prefix + urlStr;
        }
        NSWorkspace.shared.open(URL(string: tmp)!)
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

    /// 配置app图标(传 nil 恢复默认)
    static func setAppIcon(name: String?) {
        if name == nil {
            // 恢复默认图片
            return;
        }
        NSApplication.shared.applicationIconImage = NSImage(named: name!)
    }
    
    /// 开机启动项
    static func loginAutoLaunch(enabled: Bool) {
        let identifier: String = NSApplication.appBundleName
        if SMLoginItemSetEnabled(identifier as CFString, enabled) {
          if enabled {
            NSLog("Successfully add login item.")
          } else {
            NSLog("Successfully remove login item.")
          }
          
        } else {
          NSLog("Failed to add login item.")
        }
    }

}
