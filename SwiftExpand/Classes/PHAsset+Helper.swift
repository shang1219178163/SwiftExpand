//
//  PHAsset+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/3/2.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation
import Photos


@objc public extension PHAsset{
    
    /// 请求UIImage
    @available(macOS 10.13, *)
    func requestImage(_ resultHandler: @escaping (Image?, [AnyHashable: Any]?) -> Void) {
        let options = PHImageRequestOptions()
        options.deliveryMode = .highQualityFormat
        options.isNetworkAccessAllowed = true

        PHImageManager.default().requestImage(for: self,
                                              targetSize: PHImageManagerMaximumSize,
                                              contentMode: .aspectFit,
                                              options: options,
                                              resultHandler: resultHandler)
    }

    
    @available(macOS 10.15, *)
    func getURL(completionHandler: @escaping ((_ responseURL: URL?) -> Void)){
        if self.mediaType == .image {
            let options = PHContentEditingInputRequestOptions()
            options.canHandleAdjustmentData = {(adjustmeta: PHAdjustmentData) -> Bool in
                return true
            }
            self.requestContentEditingInput(with: options, completionHandler: {(contentEditingInput: PHContentEditingInput?, info: [AnyHashable: Any]) -> Void in
                completionHandler(contentEditingInput!.fullSizeImageURL as URL?)
//                print("contentEditingInput: \(contentEditingInput)")
//                print("infos: \(infos)")
//
//                // 获取图片元数据（数据全）
//                let ciImage = CIImage(contentsOf: (contentEditingInput?.fullSizeImageURL)!)
//                print("ciImage properties: \(ciImage?.properties)")
            })
        } else if self.mediaType == .video {
            let options = PHVideoRequestOptions()
            options.version = .original
            options.isNetworkAccessAllowed = true // 从云端获取
            options.deliveryMode = .mediumQualityFormat
            PHImageManager.default().requestAVAsset(forVideo: self, options: options, resultHandler: {(asset: AVAsset?, audioMix: AVAudioMix?, info: [AnyHashable: Any]?) -> Void in
                if let urlAsset = asset as? AVURLAsset {
                    let localVideoUrl: URL = urlAsset.url as URL
                    completionHandler(localVideoUrl)
                } else {
                    completionHandler(nil)
                }
            })
        }
    }
    
    /// 导出视频
    func exportVideo(_ video: URL, with session: AVAssetExportSession?, block: @escaping ((Bool) -> Void)) {
        guard let session = session else {
            DispatchQueue.main.async {
                block(false)
            }
            return
        }
        session.outputURL = video
        session.outputFileType = .mp4
        session.shouldOptimizeForNetworkUse = true
        session.exportAsynchronously {
            DispatchQueue.main.async {
                switch session.status {
                case .completed:
                    block(true)
                default:
                    block(false)
                }
            }
        }
    }
}

@available(macOS 10.13, iOS 8, *)
@objc public extension PHPhotoLibrary{
    /// 创建自定义相册
    func createAssetCollection(_ title: String, completionHandler: ((Bool, Error?) -> Void)?){
        PHPhotoLibrary.shared().performChanges({
            PHAssetCollectionChangeRequest.creationRequestForAssetCollection(withTitle: title)

        }, completionHandler: completionHandler)
    }
    
    
    /// 删除图片
    func deleteAssets(_ assets: [PHAsset], completionHandler: ((Bool, Error?) -> Void)?){
        PHPhotoLibrary.shared().performChanges({
            PHAssetChangeRequest.deleteAssets(assets as NSFastEnumeration)

        }, completionHandler: completionHandler)
    }
}



@objc public extension PHImageManager{


    func getOriginalPhoto(_ asset: PHAsset, progressHandler: @escaping PHAssetImageProgressHandler, completion: ((UIImage, [AnyHashable: Any], Bool) -> Void)?) -> PHImageRequestID {
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
                if let image = UIImage(data: imageData),
                    let result = image.fixedOrientation() {
                    completion?(result, info, isDegraded)
                }
        }
    }
}
