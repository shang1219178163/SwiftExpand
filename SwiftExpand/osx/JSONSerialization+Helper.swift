//
//  JSONSerialization+Helper.swift
//  CloudCustomerService
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2019 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import Cocoa

@objc public extension JSONSerialization{

    
    /// NSObject -> NSData
    static func dataFromObj(_ obj: AnyObject) -> Data? {
        var data: Data?

        switch obj {
        case let value as Data:
            data = value;

        case let value as String:
            data = value.data(using: .utf8);

        case let value as NSImage:
            data = value.tiffRepresentation

        case _ as NSDictionary, _ as NSArray:
            do {
                data = try JSONSerialization.data(withJSONObject: obj, options: [])
            } catch {
                print(error)
            }
        default:
            break;
        }
        return data;
    }
    
    /// data -> NSObject
    static func jsonObjectFromData(_ data: Data, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        return data.objValue
    }
    
    /// NSString -> NSObject/NSDiction/NSArray
    static func jsonObjectFromString(_ string: String, options opt: JSONSerialization.ReadingOptions = []) -> Any? {
        guard let data = string.data(using: .utf8) else { return nil}
        return JSONSerialization.jsonObjectFromData(data);
    }

    /// NSObject -> NSString
    static func jsonStringFromObj(_ obj: AnyObject) -> String {
        guard let data = JSONSerialization.dataFromObj(obj) else { return "" }
        let jsonString: String = String(data: data as Data, encoding: .utf8) ?? "";
        return jsonString;
    }

    /// 本地json文件(.geojson) -> NSString
    static func ObjFromGeojson(_ name: String) -> Any? {
        assert(name.contains(".geojson") == true);
         
        let array: Array = name.components(separatedBy: ".");
        guard let path = Bundle.main.path(forResource: array.first, ofType: array.last),
        let jsonData = try? Data(contentsOf: URL(fileURLWithPath: path)),
            let obj = try? JSONSerialization.jsonObject(with: jsonData, options: [])
            else { return nil}
        return obj
     }
    
}
