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
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return queryItems?
            .first(where: { $0.name == key })?
            .value
    }
    
    ///追加查询参数
    mutating func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        queryItems = (queryItems ?? []) + parameters.map { URLQueryItem(name: $0, value: $1) }
        return url!
    }
    
    ///删除查询参数
    mutating func removingQueryParameters(for keys: [String]) -> URL {
        var dic = [String: String]()

        queryItems?
            .filter({ !keys.contains($0.name) })
            .forEach({ dic[$0.name] = $0.value })
        
        queryItems = [] + dic.map { URLQueryItem(name: $0, value: $1) }
        return url!
    }

}


public extension URL {
    
    ///查询参数
    var queryParameters: [String: String]? {
        guard let components = URLComponents(url: self, resolvingAgainstBaseURL: false)
        else { return nil }
        return components.queryParameters
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return URLComponents(string: absoluteString)?.queryValue(for: key)
    }
    
    ///追加查询参数
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        return components.appendingQueryParameters(parameters)
    }
    
    ///追加查询参数
    mutating func appendQueryParameters(_ parameters: [String: String]) {
        self = appendingQueryParameters(parameters)
    }
    
    func removingQueryParameters(for keys: [String]) -> URL {
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)!
        return components.removingQueryParameters(for: keys)
    }
    
    ///删除查询参数
    mutating func removeQueryParameters(for keys: [String]) {
        self = removingQueryParameters(for: keys)
    }
    

}

//@objc public extension NSURLComponents {
//
//    ///查询参数
//    var queryParameters: [String: String]? {
//        return (self as URLComponents).queryParameters
//    }
//    ///追加查询参数
//    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
//        queryItems = (queryItems ?? []) + parameters.map { URLQueryItem(name: $0, value: $1) }
//        return url!
//    }
//
//    ///查询对应参数值
//    func queryValue(for key: String) -> String? {
//        return (self as URLComponents).queryValue(for: key)
//    }
//}


@objc public extension NSURL {
    
    ///查询参数
    var queryParameters: [String: String]? {
        return (self as URL).queryParameters
    }
    
    ///查询对应参数值
    func queryValue(for key: String) -> String? {
        return (self as URL).queryValue(for: key)
    }
    
    ///追加查询参数
    func appendingQueryParameters(_ parameters: [String: String]) -> URL {
        return (self as URL).appendingQueryParameters(parameters)
    }
    
    ///删除查询参数
    func removingQueryParameters(for keys: [String]) -> URL {
        return (self as URL).removingQueryParameters(for: keys)
    }
    
}


import AVFoundation
public extension URL {
    /// Generate a thumbnail image from given url. Returns nil if no thumbnail could be created. This function may take some time to complete. It's recommended to dispatch the call if the thumbnail is not generated from a local resource.
    ///
    ///     var url = URL(string: "https://video.golem.de/files/1/1/20637/wrkw0718-sd.mp4")!
    ///     var thumbnail = url.thumbnail()
    ///     thumbnail = url.thumbnail(fromTime: 5)
    ///
    ///     DisptachQueue.main.async {
    ///         someImageView.image = url.thumbnail()
    ///     }
    ///
    /// - Parameter time: Seconds into the video where the image should be generated.
    /// - Returns: The UIImage result of the AVAssetImageGenerator
    func thumbnail(fromTime time: Float64 = 0) -> UIImage? {
        let imageGenerator = AVAssetImageGenerator(asset: AVAsset(url: self))
        let time = CMTimeMakeWithSeconds(time, preferredTimescale: 1)
        var actualTime = CMTimeMake(value: 0, timescale: 0)

        guard let cgImage = try? imageGenerator.copyCGImage(at: time, actualTime: &actualTime) else {
            return nil
        }
        return UIImage(cgImage: cgImage)
    }
}
