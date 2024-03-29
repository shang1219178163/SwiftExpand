//
//  NSPanel+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//


import AppKit

@objc public extension NSPanel {

}


@objc public extension NSOpenPanel {

    static func create(fileTypes: [String]?, allowsMultipleSelection: Bool = false) -> Self {
        let panel = self.init()
        panel.canChooseFiles = true
        panel.canChooseDirectories = true
        panel.allowsMultipleSelection = allowsMultipleSelection
        panel.allowedFileTypes = fileTypes
        
        let path = "/Users/\(ProcessInfo.processInfo.userName)/Downloads"
        panel.directoryURL = URL(fileURLWithPath: path)
//        panel.runModal()
//        if panel.runModal() == NSApplication.ModalResponse.OK {
//            DDLog(panel.urls)
//        }
        return panel
    }
    
    static func open(fileTypes: [String]?, allowsMultipleSelection: Bool = false) -> Self {
        let panel = self.create(fileTypes: fileTypes, allowsMultipleSelection: allowsMultipleSelection)
//        panel.runModal()
        if panel.runModal() == NSApplication.ModalResponse.OK {
            DDLog(panel.urls)
        }
        return panel
    }
}

