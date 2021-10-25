//
//  PHAsset+Ext.swift
//  SwiftExpand
//
//  Created by shangbinbin on 2021/10/25.
//

import Foundation
import Photos


@objc public extension PHImageManager{


    func getOriginalPhoto(_ asset: PHAsset, progressHandler: @escaping PHAssetImageProgressHandler, completion: ((Image, [AnyHashable: Any], Bool) -> Void)?) -> PHImageRequestID {
        let option = PHImageRequestOptions()
        option.isNetworkAccessAllowed = true
        option.resizeMode = .fast
        option.progressHandler = progressHandler

        return PHImageManager.default().requestImageData(for: asset, options: option) { imageData, dataUTI, orientation, info in
            guard let imageData = imageData,
                  let info = info,
                  let cancelled = info[PHImageCancelledKey] as? Bool,
                  let isDegraded = info[PHImageResultIsDegradedKey] as? Bool,
                    cancelled == false else {
                        return }
                if let image = Image(data: imageData),
                    let result = image.fixedOrientation() {
                    completion?(result, info, isDegraded)
                }
        }
    }
}
