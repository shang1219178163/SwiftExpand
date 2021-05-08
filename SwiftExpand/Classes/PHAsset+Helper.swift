//
//  PHAsset+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/3/2.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import Photos

@objc public extension PHAsset{
    
    /// 请求UIImage
    func requestImage(_ resultHandler: @escaping (UIImage?, [AnyHashable : Any]?) -> Void) {
        let options = PHImageRequestOptions.defaultOptions()
        PHImageManager.default().requestImage(for: self,
                                              targetSize: PHImageManagerMaximumSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler: resultHandler)
    }
    
}

@objc public extension PHImageRequestOptions{
    // version
    @available(iOS 8, *)
    func versionChain(_ version: PHImageRequestOptionsVersion) -> Self {
        self.version = version
        return self
    }

    // delivery mode. Defaults to PHImageRequestOptionsDeliveryModeOpportunistic
    @available(iOS 8, *)
    func deliveryModeChain(_ deliveryMode: PHImageRequestOptionsDeliveryMode) -> Self {
        self.deliveryMode = deliveryMode
        return self
    }

    // resize mode. Does not apply when size is PHImageManagerMaximumSize. Defaults to PHImageRequestOptionsResizeModeFast
    @available(iOS 8, *)
    func resizeModeChain(_ resizeMode: PHImageRequestOptionsResizeMode) -> Self {
        self.resizeMode = resizeMode
        return self
    }

    // specify crop rectangle in unit coordinates of the original image, such as a face. Defaults to CGRectZero (not applicable)
    @available(iOS 8, *)
    func normalizedCropRectChain(_ normalizedCropRect: CGRect) -> Self {
        self.normalizedCropRect = normalizedCropRect
        return self
    }

    // if necessary will download the image from iCloud (client can monitor or cancel using progressHandler). Defaults to NO (see start/stopCachingImagesForAssets)
    @available(iOS 8, *)
    func isNetworkAccessAllowedChain(_ isNetworkAccessAllowed: Bool) -> Self {
        self.isNetworkAccessAllowed = isNetworkAccessAllowed
        return self
    }

    // return only a single result, blocking until available (or failure). Defaults to NO
    @available(iOS 8, *)
    func isSynchronousChain(_ isSynchronous: Bool) -> Self {
        self.isSynchronous = isSynchronous
        return self
    }

    // provide caller a way to be told how much progress has been made prior to delivering the data when it comes from iCloud. Defaults to nil, shall be set by caller
    @available(iOS 8, *)
    func progressHandlerChain(_ progressHandler: PHAssetImageProgressHandler?) -> Self {
        self.progressHandler = progressHandler
        return self
    }
    
    /// 默认参数
    static func defaultOptions() -> PHImageRequestOptions {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        return options;
    }

}

@available(iOS 9.1, *)
@objc public extension PHLivePhotoRequestOptions {

    // version
    func versionChain(_ version: PHImageRequestOptionsVersion) -> Self {
        self.version = version
        return self
    }

    func deliveryModeChain(_ deliveryMode: PHImageRequestOptionsDeliveryMode) -> Self {
        self.deliveryMode = deliveryMode
        return self
    }

    func isNetworkAccessAllowedChain(_ isNetworkAccessAllowed: Bool) -> Self {
        self.isNetworkAccessAllowed = isNetworkAccessAllowed
        return self
    }

    func progressHandlerChain(_ progressHandler: PHAssetImageProgressHandler?) -> Self {
        self.progressHandler = progressHandler
        return self
    }


}


public extension PHVideoRequestOptions {

    func isNetworkAccessAllowedChain(_ isNetworkAccessAllowed: Bool) -> Self {
        self.isNetworkAccessAllowed = isNetworkAccessAllowed
        return self
    }

    func versionChain(_ version: PHVideoRequestOptionsVersion) -> Self {
        self.version = version
        return self
    }

    func deliveryModeChain(_ deliveryMode: PHVideoRequestOptionsDeliveryMode) -> Self {
        self.deliveryMode = deliveryMode
        return self
    }

    func progressHandlerChain(_ progressHandler: PHAssetVideoProgressHandler?) -> Self {
        self.progressHandler = progressHandler
        return self
    }


}
