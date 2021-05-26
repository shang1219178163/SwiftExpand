//
//  NSBundle+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa

@objc public extension Bundle{

    /// 国际化语言适配
    static func localizedString(forKey key: String, comment: String = "", userDefaultsKey: String = "AppLanguage") -> String {
        let defaultValue = NSLocalizedString(key, comment: comment)
        guard let name = UserDefaults.standard.object(forKey: userDefaultsKey) as? String,
              let lprojBundlePath = Bundle.main.path(forResource: name, ofType: "lproj"),
              let lprojBundle = Bundle(path: lprojBundlePath) else {
            return defaultValue }
        let value = NSLocalizedString(key, bundle: lprojBundle, comment: comment)
//        let value = bundle!.localizedString(forKey: key, value: "", table: nil)
        return value;
    }
        
    /// 读取plist文件
    func dictionary(forResource name: String, ofType ext: String = "plist") -> NSDictionary? {
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
            let obj = NSDictionary(contentsOfFile: path)
            else { return nil }
        return obj
    }
    
    /// 读取plist文件
    func array(forResource name: String, ofType ext: String = "plist") -> NSArray? {
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
            let obj = NSArray(contentsOfFile: path)
            else { return nil }
        return obj
    }
    
    ///本地文件 URL
    static func fileURL(forResource name: String, ofType ext: String?) -> NSURL?{
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
              let URL = NSURL(fileURLWithPath: path) as NSURL?
        else { return nil}
        return URL
    }
    
    ///本地文件内容
    static func string(forResource name: String, ofType ext: String) -> String?{
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
              let content = try? String(contentsOfFile: path)
              else { return nil}
        return content
    }
    
    static func readPath(forResource name: String, ofType ext: String?) -> [String]? {
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
              let data = try? String(contentsOfFile: path, encoding: .utf8)
              else { return nil}
        return data.components(separatedBy: .newlines)
    }
}

