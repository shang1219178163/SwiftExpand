//
//  WKWebView+Helper.swift
//  VehicleBonus
//
//  Created by Bin Shang on 2019/3/13.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation
import WebKit


@objc public extension WKWebView{
    private struct AssociateKeys {
        static var confiDefault  = "WKWebView" + "confiDefault"
    }
    /// WKWebViewConfiguration默认配置
    static var confiDefault: WKWebViewConfiguration {
        get {
            if let obj = objc_getAssociatedObject(self,  &AssociateKeys.confiDefault) as? WKWebViewConfiguration {
                return obj
            }
            
            let sender = WKWebViewConfiguration()
//            sender.allowsInlineMediaPlayback = true
//            sender.selectionGranularity = .dynamic
            
            sender.preferences = WKPreferences()
            sender.preferences.javaScriptCanOpenWindowsAutomatically = false
            sender.preferences.javaScriptEnabled = true
            
            objc_setAssociatedObject(self,  &AssociateKeys.confiDefault, sender, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return sender
        }
        set {
            objc_setAssociatedObject(self,  &AssociateKeys.confiDefault, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    /// JS注入
    func addUserScript(_ source: String) {
        let userScript = WKUserScript(source: source, injectionTime: .atDocumentStart, forMainFrameOnly: false)
        configuration.userContentController.addUserScript(userScript)
    }
    
    ///设置 Cookie 参数
    func setCookieByJavaScript(_ dic: [String: String], completionHandler: ((Any?, Error?) -> Void)? = nil){
        var result = ""
        dic.forEach { (key: String, value: String) in
            result = (result + "\(key)=\(value),")
        }
        self.evaluateJavaScript("document.cookie ='\(result)'", completionHandler: completionHandler)
    }
    
    ///添加 cookie的自动推送
    @available(iOS 11.0, macOS 10.13, *)
    func copyNSHTTPCookieStorageToWKHTTPCookieStore(_  handler: (() -> Void)? = nil) {
        guard let cookies = HTTPCookieStorage.shared.cookies else { return }
        let cookieStore = self.configuration.websiteDataStore.httpCookieStore

        if cookies.count == 0 {
            handler?()
            return
        }
        for cookie in cookies {
            cookieStore.setCookie(cookie) {
                if cookies.last!.isEqual(cookie) {
                    handler?()
                    return
                }
            }
        }
    }

    /// 字体改变
    static func javaScriptFromTextSizeRatio(_ ratio: CGFloat) -> String {
        let result = "document.getElementsByTagName('body')[0].style.webkitTextSizeAdjust= '\(ratio)%'"
        return result
    }
    /// 字体改变
    func loadHTMLStringWithMagic(_ content: String, baseURL: URL?){
        let headerString = "<header><meta name='viewport' content='width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no'></header>"
        loadHTMLString(headerString + content, baseURL: baseURL)
    }
    
    ///此方法解决了: Web 页面包含了 ajax 请求的话，cookie 要重新处理,这个处理需要在 WKWebView 的 WKWebViewConfiguration 中进行配置。
    func loadUrl(_ urlString: String?, additionalHttpHeaders: [String: String]? = nil, isAddUserScript: Bool = true) {
        guard let urlString = urlString,
              let urlStr = urlString.removingPercentEncoding as String?,
              let url = URL(string: urlStr) as URL?
              else {
            DDLog("链接错误")
            return }
        
        if isAddUserScript == false {
            if let URL = URL(string: urlString) as URL? {
                var request = URLRequest(url: URL)
                additionalHttpHeaders?.forEach { (key, value) in
                    request.addValue(value, forHTTPHeaderField: key)
                }
               load(request)
            }
            return
        }
        
        let cookieSource: String = "document.cookie = 'user=\("userValue")'"
        let cookieScript = WKUserScript(source: cookieSource, injectionTime: .atDocumentStart, forMainFrameOnly: false)

        let userContentController = WKUserContentController()
        userContentController.addUserScript(cookieScript)

        configuration.userContentController = userContentController

        var request = URLRequest(url: url)
        if let headFields: [AnyHashable : Any] = request.allHTTPHeaderFields {
            if headFields["user"] != nil {

            } else {
                request.addValue("user=\("userValue")", forHTTPHeaderField: "Cookie")
            }
        }

        additionalHttpHeaders?.forEach { (key, value) in
            request.addValue(value, forHTTPHeaderField: key)
        }
        load(request)
    }
    
    @available(iOS 11.0, macOS 10.13, *)
    func snapshot(_ rect: CGRect, snapshotWidth: NSNumber? = nil, completionHandler: @escaping (Image?, Error?) -> Void){
        let conf = WKSnapshotConfiguration()
        conf.rect = rect
        conf.snapshotWidth = snapshotWidth
        takeSnapshot(with: conf, completionHandler: completionHandler)
    }
}

