//
//  NSURL+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


public extension URLComponents {
    
    ///查询参数
    var queryParameters: [String: String]? {
        guard let queryItems = queryItems else { return nil }

        var dic = [String: String]()
        for item in queryItems {
            dic[item.name] = item.value
        }
        return dic
    }
    ///追加查询参数
    mutating func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        queryItems = (queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        return url!
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return queryItems?
            .first(where: { $0.name == key })?
            .value
    }
}


public extension URL {
    
    ///查询参数
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        else { return nil }
        return components.queryParameters
    }
    ///追加查询参数
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        return components.appendingQueryParameters(parameters)
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return URLComponents(string: absoluteString)?.queryValue(for: key)
    }
}

@objc public extension NSURLComponents {
    
    ///查询参数
    var queryParameters: [String: String]? {
        return (self as URLComponents).queryParameters
    }
    ///追加查询参数
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        queryItems = (queryItems ?? []) + parameters
            .map { URLQueryItem(name: $0, value: $1) }
        return url!
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return (self as URLComponents).queryValue(for: key)
    }
}


@objc public extension NSURL {
    
    ///查询参数
    var queryParameters: [String: String]? {
        return (self as URL).queryParameters
    }
    ///追加查询参数
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        return (self as URL).appendingQueryParameters(parameters)
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return (self as URL).queryValue(for: key)
    }
}
