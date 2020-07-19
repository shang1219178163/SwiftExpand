//
//  WKWebView+Helper.swift
//  VehicleBonus
//
//  Created by Bin Shang on 2019/3/13.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import WebKit

@objc public extension WKWebView{
    /// WKWebViewConfiguration默认配置
    static var confiDefault: WKWebViewConfiguration {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromType(self, aSelector: #function)) as? WKWebViewConfiguration {
                return obj;
            }
            
            let sender = WKWebViewConfiguration()
            sender.allowsInlineMediaPlayback = true;
            sender.selectionGranularity = .dynamic;
            sender.preferences = WKPreferences();
            sender.preferences.javaScriptCanOpenWindowsAutomatically = false;
            sender.preferences.javaScriptEnabled = true;
            
            objc_setAssociatedObject(self, RuntimeKeyFromType(self, aSelector: #function), sender, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return sender;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromType(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// JS注入
    func addUserScript(_ source: String) {
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(userScript)
    }

    /// 字体改变
    static func javaScriptFromTextSizeRatio(_ ratio: CGFloat) -> String {
        let result = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(ratio)%'"
        return result
    }
}
