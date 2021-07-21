//
//  CATransition+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/3/29.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation
import QuartzCore


@objc public extension CATransition{
    // MARK: - kCATransition
    /// 立方体效果
    static let kCATransitionCube         = "cube"
    /// 阿拉神灯效果
    static let kCATransitionSuckEffect   = "suckEffect"
    /// 上下左右翻转效果
    static let kCATransitionOglFlip      = "oglFlip"
    /// 水滴效果
    static let kCATransitionRippleEffect = "rippleEffect"
    /// 向上翻页效果
    static let kCATransitionPageCurl     = "pageCurl"
    /// 向下翻页效果
    static let kCATransitionPageUnCurl   = "pageUnCurl"
    /// 相机镜头打开效果
    static let kCATransitionCameraOpen   = "cameraIrisHollowOpen"
    /// 相机镜头关闭效果
    static let kCATransitionCameraClose  = "cameraIrisHollowClose"
    /// 动画方向
    static let kSubTypes: [CATransitionSubtype] = [
        .fromTop,
        .fromLeft,
        .fromBottom,
        .fromRight]
    /// [源]CATransition    
    convenience init(duration: CFTimeInterval,
                     functionName: CAMediaTimingFunctionName = .linear,
                     type: CATransitionType = .fade,
                     subType: CATransitionSubtype? = nil) {
        self.init()
        self.duration = duration;
        self.timingFunction = CAMediaTimingFunction(name: functionName);
        self.type = type
        self.subtype = subType
    }
    
}
