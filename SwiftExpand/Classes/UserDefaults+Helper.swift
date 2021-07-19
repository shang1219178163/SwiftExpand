//
//  UserDefaults+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/10/28.
//  Copyright © 2019 BN. All rights reserved.
//


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
    
    ///UserDefaults 保存模型
    static func arcObject(_ value: Any?, forkey defaultName: String) {
        guard let value = value else { return }
        if #available(iOS 11.0, *) {
            do {
                let data = try NSKeyedArchiver.archivedData(withRootObject: value, requiringSecureCoding: true)
                standard.setValue(data, forKey: defaultName)
            } catch {
                DDLog(error.localizedDescription)
            }
        } else {
            let data = NSKeyedArchiver.archivedData(withRootObject: value)
            standard.setValue(data, forKey: defaultName)
        }
    }
    ///UserDefaults 解包模型
    static func unarcObject(ofClasses classes: Set<AnyHashable>, forkey defaultName: String) -> Any? {
        guard let value = standard.object(forKey: defaultName) as? Data else { return nil}
        if #available(iOS 11.0, *) {
            do {
                let data = try NSKeyedUnarchiver.unarchivedObject(ofClasses: classes, from: value)
                return data
            } catch {
                DDLog(error.localizedDescription)
            }
        } else {
            let data = NSKeyedUnarchiver.unarchiveObject(with: value)
            return data
        }
        return nil
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

