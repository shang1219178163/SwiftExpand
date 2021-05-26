//
//  NSFileManager+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import Cocoa


@objc public extension FileManager{
    /// 下载目录
    static var downloadsDir = FileManager.default.urls(for: .downloadsDirectory, in:.userDomainMask).first;

    ///根据文件名和路径创建文件
    @discardableResult
    static func createFile(atPath path: String, name: String, content: String, attributes: [FileAttributeKey : Any]?, isCover: Bool = true) -> Bool {
//        let filePath = atPath + "/\(name)"
        let filePath = isCover ? "\(path)/\(name)" : "\(path)/\(name)_\(DateFormatter.stringFromDate(Date()))";
        return FileManager.default.createFile(atPath: filePath, contents: content.data(using: .utf8), attributes: attributes)
    }
 
    ///创建文件到下载目录
    static func createFile(dirUrl: URL = FileManager.downloadsDir!, content: String, name: String, type: String, isCover: Bool = true, openDir: Bool = true){
        let fileUrl = dirUrl.appendingPathComponent("\(name).\(type)")
        let data = content.data(using: .utf8)

        let exist = FileManager.default.fileExists(atPath: fileUrl.path)
        if !exist {
            let isSuccess = FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
            print("文件创建结果: \(isSuccess)")
        } else {
            let fileName = isCover ? "\(name).\(type)" : "\(name) \(DateFormatter.stringFromDate(Date())).\(type)";
            let fileUrl = dirUrl.appendingPathComponent(fileName)
            let isSuccess = FileManager.default.createFile(atPath: fileUrl.path, contents: data, attributes: nil)
            print("文件创建结果: \(isSuccess)")
        }
        if openDir {
            NSWorkspace.shared.open(dirUrl)
        }
    }
}

public extension NSPasteboard{
    ///获取拖拽元素的信息
    @available(OSX 10.13, *)
    var propertyList: [Any]? {
        if let board = self.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? [String] {
            print("FILE: \(board)")
            return board
        }
        
        if let board = self.propertyList(forType: .URL) as? [URL] {
            print("URL: \(board)")
            return board
        }
        
        if let board = self.propertyList(forType: .string) as? [String] {
            print("STRING: \(board)")
            return board
        }
        
        if let board = self.propertyList(forType: .html) as? [String] {
            print("HTML: \(board)")
            return board
        }
        return nil
    }
    
//    @available(OSX 10.13, *)
//    var propertyList: [Any]? {
//        let types: [NSPasteboard.PasteboardType] = [.string, .pdf, .tiff, .png,
//                                                    .rtf, .rtfd, .html, .tabularText,
//                                                    .font, .ruler, .color, .sound,
//                                                    .multipleTextSelection, .textFinderOptions, .URL, .fileURL]
//
//        for type in types {
//            if let board = self.propertyList(forType: type) as? [Any] {
//                print("\(type.rawValue): \(board)")
//                return board
//            } else if let board = self.propertyList(forType: NSPasteboard.PasteboardType(rawValue: "NSFilenamesPboardType")) as? [String] {
//                print("FILE: \(board)")
//                return board
//            }
//        }
//        return nil
//    }
    
    ///拖拽的本地文件路径
    @available(OSX 10.13, *)
    var draggedFileURL: NSURL? {
        if let property = propertyList?.first as? String {
            print(property)
            return NSURL(fileURLWithPath: property)
        }
        return nil
    }
    ///解析拖拽到目标视图上的信息同时options 参数限制可拖入子元素的类型（ nil 表示不限类型）
    func readObjects(forClasses classArray: [AnyClass] = [NSImage.self, NSColor.self, NSString.self, NSURL.self],
                     options: [NSPasteboard.ReadingOptionKey : Any]? = nil,
                     handler: ((Any)->Void)? = nil) -> Bool {
        guard let pasteboardObjects = readObjects(forClasses: classArray, options: options),
              pasteboardObjects.count > 0 else {
            return false
        }
        
        pasteboardObjects.forEach { (obj) in
            switch obj {
            case let value as NSImage:
                print(#function, #line, "NSImage", value)
                handler?(value)
                
            case let value as NSString:
                print(#function, #line, "NSString", value)
                handler?(value)

            case let value as NSColor:
                print(#function, #line, "NSColor", value)
                handler?(value)

            case let value as URL:
                print(#function, #line, "URL", value.absoluteString.removingPercentEncoding ?? "")
                if let image = NSImage(contentsOfFile: value.path) {
                    print(#function, #line, image)
                    handler?(image)
                } else {
                    handler?(value)
                }
                
            default:
                print(#function, #line, obj)
                handler?(obj)
                break
            }
        }
        return true
    }
}
