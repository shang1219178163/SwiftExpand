//
//  JSONSerialization+Helper.swift
//  CloudCustomerService
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2019 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//


@objc public extension JSONSerialization{

    /// data -> NSObject
    static func jsonObjectFromData(_ data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        return data.objValue
    }
    
    /// NSString -> NSObject/NSDiction/NSArray
    static func jsonObjectFromString(_ string: String, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil}
        return JSONSerialization.jsonObjectFromData(data);
    }

    ///读取本地文件内容
    static func jsonObject(forResource name: String, ofType ext: String?) -> Any?{
        guard let path = Bundle.main.path(forResource: name, ofType: ext),
              let URL = URL(fileURLWithPath: path) as URL?,
              let jsonData = try? Data(contentsOf: URL),
              let obj = try? JSONSerialization.jsonObject(with: jsonData, options: [])
        else { return nil}
        return obj
    }
}
