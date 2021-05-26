//
//  PHAsset+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/3/2.
//  Copyright © 2019 BN. All rights reserved.
//

import Photos

@objc public extension PHAsset{
    
    /// 请求UIImage
    func requestImage(_ resultHandler: @escaping (Image?, [AnyHashable : Any]?) -> Void) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true
        
        PHImageManager.default().requestImage(for: self,
                                              targetSize: PHImageManagerMaximumSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler: resultHandler)
    }
    
}
