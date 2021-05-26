
//
//  NSUserDefaults+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension UserDefaults{

    subscript(key: String) -> Any? {
        get {
            return value(forKey: key)
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// UserDefaults 二次封装
    static func defaults() -> UserDefaults {
         return self.standard
     }
    /// UserDefaults 二次封装
    static func synchronize() {
         self.standard.synchronize()
     }
    /// UserDefaults 二次封装(遵守编解码协议的模型)
    static func setArcObject(_ value: Any?, forkey key: String) {
        guard let value = standard.object(forKey: key) else { return }
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        self.standard.set(data, forKey: key)
    }
    /// UserDefaults 二次封装(遵守编解码协议的模型)
    static func arcObject(forKey key: String) -> Any? {
        guard let data = standard.object(forKey: key) as? Data else { return nil}
        return NSKeyedUnarchiver.unarchiveObject(with: data)
    }
    
}

public extension UserDefaults{
    
    subscript<T>(key: String) -> T? {
        get {
            return value(forKey: key) as? T
        }
        set {
            set(newValue, forKey: key)
        }
    }
    
    /// 枚举默认支持 RawRepresentable
    subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = object(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            set(newValue?.rawValue, forKey: key)
        }
    }
    
    ///类属性下标方法
    static subscript<T>(key: String) -> T? {
        get {
            return standard.value(forKey: key) as? T
        }
        set {
            standard.set(newValue, forKey: key)
        }
    }
    
    /// 类属性下标方法(枚举默认支持 RawRepresentable)
    static subscript<T: RawRepresentable>(key: String) -> T? {
        get {
            if let rawValue = standard.object(forKey: key) as? T.RawValue {
                return T(rawValue: rawValue)
            }
            return nil
        }
        set {
            standard.set(newValue?.rawValue, forKey: key)
        }
    }
}


public enum AppTheme: Int {
    case light
    case dark
}

public class SettingsService {
    
    public required init() {
        
    }
    
    public var isNotificationsEnabled: Bool {
        get {
            let isEnabled = UserDefaults.standard[#function] as? Bool
            return isEnabled ?? true
        }
        set {
//            DDLog(#function, String(describing: self), type(of: self), Self.self)
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
    
    public var appTheme: AppTheme {
        get {
            return UserDefaults.standard[#function] ?? .light
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
    public static var isNotificationsEnabled: Bool {
        get {
            let isEnabled = UserDefaults.standard[#function] as? Bool
            return isEnabled ?? true
        }
        set {
//            DDLog(#function, String(describing: self), type(of: self), Self.self)
            UserDefaults.standard.setValue(newValue, forKey: #function)
        }
    }
    
    public static var appTheme: AppTheme {
        get {
            return UserDefaults.standard[#function] ?? .light
        }
        set {
            UserDefaults.standard[#function] = newValue
        }
    }
    
//    public func testFunc() {
//        DDLog(#function, String(describing: self), type(of: self), Self.self)
//    }
//
//    public static func testFunc() {
//        DDLog(#function, String(describing: self), type(of: self), Self.self)
//    }
//
//    public func test() {
//        let service = SettingsService()
//        service.isNotificationsEnabled = false
//        SettingsService.isNotificationsEnabled = false
//
//        DDLog(service.isNotificationsEnabled, SettingsService.isNotificationsEnabled)
//        service.testFunc()
//        SettingsService.testFunc()
//    }
}
