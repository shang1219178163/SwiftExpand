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
    private struct AssociateKeys {
        static var confiDefault  = "WKWebView" + "confiDefault"
    }
    /// WKWebViewConfiguration默认配置
    static var confiDefault: WKWebViewConfiguration {
        get {
            if let obj = objc_getAssociatedObject(self,  &AssociateKeys.confiDefault) as? WKWebViewConfiguration {
                return obj;
            }
            
            let sender = WKWebViewConfiguration()
            sender.allowsInlineMediaPlayback = true;
            sender.selectionGranularity = .dynamic;
            sender.preferences = WKPreferences();
            sender.preferences.javaScriptCanOpenWindowsAutomatically = false;
            sender.preferences.javaScriptEnabled = true;
            
            objc_setAssociatedObject(self,  &AssociateKeys.confiDefault, sender, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return sender;
        }
        set {
            objc_setAssociatedObject(self,  &AssociateKeys.confiDefault, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    func navigationDelegateChain(_ navigationDelegate: WKNavigationDelegate?) -> Self {
        self.navigationDelegate = navigationDelegate
        return self
    }

    func uiDelegateChain(_ uiDelegate: WKUIDelegate?) -> Self {
        self.uiDelegate = uiDelegate
        return self
    }

    func allowsBackForwardNavigationGesturesChain(_ allowsBackForwardNavigationGestures: Bool) -> Self {
        self.allowsBackForwardNavigationGestures = allowsBackForwardNavigationGestures
        return self
    }

    func customUserAgentChain(_ customUserAgent: String?) -> Self {
        self.customUserAgent = customUserAgent
        return self
    }

    func allowsLinkPreviewChain(_ allowsLinkPreview: Bool) -> Self {
        self.allowsLinkPreview = allowsLinkPreview
        return self
    }

    @available(iOS 14.0, *)
    func pageZoomChain(_ pageZoom: CGFloat) -> Self {
        self.pageZoom = pageZoom
        return self
    }

    @available(iOS 14.0, *)
    func mediaTypeChain(_ mediaType: String?) -> Self {
        self.mediaType = mediaType
        return self
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
    @available(iOS 11.0, *)
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
        
        let cookieSource: String = "document.cookie = 'user=\("userValue")';"
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
    
    @available(iOS 11.0, *)
    func snapshot(_ rect: CGRect, snapshotWidth: NSNumber? = nil, completionHandler: @escaping (UIImage?, Error?) -> Void){
        let conf = WKSnapshotConfiguration()
        conf.rect = rect
        conf.snapshotWidth = snapshotWidth
        takeSnapshot(with: conf, completionHandler: completionHandler)
    }
}


public extension WKWebViewConfiguration {

    func processPoolChain(_ processPool: WKProcessPool) -> Self {
        self.processPool = processPool
        return self
    }

    func preferencesChain(_ preferences: WKPreferences) -> Self {
        self.preferences = preferences
        return self
    }

    func userContentControllerChain(_ userContentController: WKUserContentController) -> Self {
        self.userContentController = userContentController
        return self
    }

    @available(iOS 9.0, *)
    func websiteDataStoreChain(_ websiteDataStore: WKWebsiteDataStore) -> Self {
        self.websiteDataStore = websiteDataStore
        return self
    }

    func suppressesIncrementalRenderingChain(_ suppressesIncrementalRendering: Bool) -> Self {
        self.suppressesIncrementalRendering = suppressesIncrementalRendering
        return self
    }

    @available(iOS 9.0, *)
    func applicationNameForUserAgentChain(_ applicationNameForUserAgent: String?) -> Self {
        self.applicationNameForUserAgent = applicationNameForUserAgent
        return self
    }

    @available(iOS 9.0, *)
    func allowsAirPlayForMediaPlaybackChain(_ allowsAirPlayForMediaPlayback: Bool) -> Self {
        self.allowsAirPlayForMediaPlayback = allowsAirPlayForMediaPlayback
        return self
    }

    @available(iOS 10.0, *)
    func mediaTypesRequiringUserActionForPlaybackChain(_ mediaTypesRequiringUserActionForPlayback: WKAudiovisualMediaTypes) -> Self {
        self.mediaTypesRequiringUserActionForPlayback = mediaTypesRequiringUserActionForPlayback
        return self
    }

    @available(iOS 13.0, *)
    func defaultWebpagePreferencesChain(_ defaultWebpagePreferences: WKWebpagePreferences!) -> Self {
        self.defaultWebpagePreferences = defaultWebpagePreferences
        return self
    }

    @available(iOS 14.0, *)
    func limitsNavigationsToAppBoundDomainsChain(_ limitsNavigationsToAppBoundDomains: Bool) -> Self {
        self.limitsNavigationsToAppBoundDomains = limitsNavigationsToAppBoundDomains
        return self
    }

    func allowsInlineMediaPlaybackChain(_ allowsInlineMediaPlayback: Bool) -> Self {
        self.allowsInlineMediaPlayback = allowsInlineMediaPlayback
        return self
    }

    func selectionGranularityChain(_ selectionGranularity: WKSelectionGranularity) -> Self {
        self.selectionGranularity = selectionGranularity
        return self
    }

    @available(iOS 9.0, *)
    func allowsPictureInPictureMediaPlaybackChain(_ allowsPictureInPictureMediaPlayback: Bool) -> Self {
        self.allowsPictureInPictureMediaPlayback = allowsPictureInPictureMediaPlayback
        return self
    }

    @available(iOS 10.0, *)
    func dataDetectorTypesChain(_ dataDetectorTypes: WKDataDetectorTypes) -> Self {
        self.dataDetectorTypes = dataDetectorTypes
        return self
    }

    @available(iOS 10.0, *)
    func ignoresViewportScaleLimitsChain(_ ignoresViewportScaleLimits: Bool) -> Self {
        self.ignoresViewportScaleLimits = ignoresViewportScaleLimits
        return self
    }


}


public extension URLRequest{
    ///便捷方法设置 addValue(_ value: String, forHTTPHeaderField field: String)
    init(url: URL, httpHeaders: [String: String]) {
        self.init(url: url)
        httpHeaders.forEach { (key, value) in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }

    ///设置 addValue(_ value: String, forHTTPHeaderField field: String)
    mutating func addHTTPHeaderField(for dic: [String: String]?) {
        dic?.forEach { (key, value) in
            self.addValue(value, forHTTPHeaderField: key)
        }
    }
    
    mutating func addDict(_ dic: [String: String]?, forHTTPHeaderField field: String = "Cookie") {
        var result = ""
        dic?.forEach{ (key: String, value: String) in
            result = (result + "\(key)=\(value);")
        }
        self.addValue(result, forHTTPHeaderField: field)
    }
}
