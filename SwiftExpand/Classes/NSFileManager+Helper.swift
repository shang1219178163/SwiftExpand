//
//  NSFileManager+Helper.swift
//  IntelligentOfParking
//
//  Created by Bin Shang on 2020/2/14.
//  Copyright © 2020 Xi'an iRain IoT. Technology Service CO., Ltd. . All rights reserved.
//

import UIKit

public extension FileManager{
    
    var documentsURL: URL {
        return urls(for: .documentDirectory, in: .userDomainMask).last!
    }
    
    var documentsPath: String {
        return NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
    }
    
    var cachesURL: URL {
        return urls(for: .cachesDirectory, in: .userDomainMask).last!
    }
    
    var cachesPath: String {
        return NSSearchPathForDirectoriesInDomains(.cachesDirectory, .userDomainMask, true).first!
    }
    
    var libraryURL: URL {
        return urls(for: .libraryDirectory, in: .userDomainMask).last!
    }
    
    var libraryPath: String {
        return NSSearchPathForDirectoriesInDomains(.libraryDirectory, .userDomainMask, true).first!
    }

    ///读取本地文件内容
    static func readFile(forResource name: String?, ofType ext: String?) -> String{
        guard let path = Bundle.main.path(forResource: name, ofType: ext) else { return "" }
        let content = try? String(contentsOfFile: path)
        return content ?? ""
    }
    
}
