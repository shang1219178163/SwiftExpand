//
//  SwiftExpandResources.swift
//  SwiftExpand
//
//  资源 Bundle 解析，兼容 CocoaPods 与 SPM。
//

import Foundation

private final class SwiftExpandBundleToken {}

public enum SwiftExpandResources {
    /// SwiftExpand 图片等资源所在 Bundle
    public static var bundle: Bundle {
        #if SWIFT_PACKAGE
        return Bundle.module
        #else
        let bundleName = "SwiftExpand"
        if let resourcePath = Bundle(for: SwiftExpandBundleToken.self).resourcePath,
           let podBundle = Bundle(path: resourcePath + "/\(bundleName).bundle") {
            return podBundle
        }
        return Bundle(for: SwiftExpandBundleToken.self)
        #endif
    }
}
