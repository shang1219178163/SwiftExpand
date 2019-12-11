//
//  Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/11/20.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit


@objc public extension Bundle{
    /// 读取plist文件
    static func infoDictionary(plist: String) -> [String: AnyObject]? {
        guard
            let pList = Bundle.main.path(forResource: plist, ofType: "plist"),
            let dic = NSDictionary(contentsOfFile: pList)
            else { return nil; }
        return dic as? [String : AnyObject]
    }
    /// 获取 pod bundle 图片资源
    static func image(named name: String, podClass: AnyClass, bundleName: String? = nil) -> UIImage?{
        let bundleNameNew = bundleName ?? "\(podClass)"
        if let image = UIImage(named: "\(bundleNameNew).bundle/\(name)") {
            return image;
        }

        let framework = Bundle(for: podClass)
        let filePath = framework.resourcePath! + "/\(bundleNameNew).bundle"
        
        guard let bundle = Bundle(path: filePath) else { return nil}
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image;
    }
    /// 获取 pod bundle 图片资源
    static func image(named name: String, podClassName: String, bundleName: String? = nil) -> UIImage?{
        let bundleNameNew = bundleName ?? podClassName
        if let image = UIImage(named: "\(bundleNameNew).bundle/\(name)") {
            return image;
        }

        let framework = Bundle.main
        let filePath = framework.resourcePath! + "/Frameworks/\(podClassName).framework/\(bundleNameNew).bundle"
        
        guard let bundle = Bundle(path: filePath) else { return nil}
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image;
    }
    
    /// 获取 pod bundle 图片资源
    static func image(named name: String, bundlePath: String) -> UIImage?{
        if let image = UIImage(named: name) {
            return image;
        }
                
        guard let bundle = Bundle(path: bundlePath) else { return nil}
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image;
    }
    
}
