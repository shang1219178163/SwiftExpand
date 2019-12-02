//
//  CAAnimation+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/2.
//

import UIKit
import QuartzCore

@objc public extension CAAnimation{

    /// x方向平移
    static let kTransformMoveX           = "transform.translation.x";
    /// y方向平移
    static let kTransformMoveY           = "transform.translation.y";
    /// 比例转化
    static let kTransformScale           = "transform.scale";
    /// 宽的比例
    static let kTransformScaleX          = "transform.scale.x";
    /// 高的比例
    static let kTransformScaleY          = "transform.scale.y";

    static let kTransformRotationZ       = "transform.rotation.z";
    static let kTransformRotationX       = "transform.rotation.x";
    static let kTransformRotationY       = "transform.rotation.y";
    /// 横向拉伸缩放 (0.4)最好是0~1之间的
    static let kTransformSizW            = "contentsRect.size.width";
    /// 位置(中心点的改变) [NSValue valueWithCGPoint:CGPointMake(300, 300)];
    static let kTransformPosition        = "position";
    /// 大小，中心不变  [NSValue valueWithCGRect:CGRectMake(0, 0, 200, 200)];
    static let kTransformBounds          = "bounds";
    /// 内容,imageAnima.toValue = (id)[UIImage imageNamed:"to"].CGImage;
    static let kTransformContents        = "contents";
    /// 透明度
    static let kTransformOpacity         = "opacity";
    /// 圆角
    static let kTransformCornerRadius    = "cornerRadius";
    /// 背景
    static let kTransformBackgroundColor = "backgroundColor";
    /// path
    static let kTransformPath            = "path";
    ///背景
    static let kTransformStrokeEnd       = "strokeEnd";
    /// kCAMediaTimingFunction集合
    static let kFunctionNames = [
                                CAMediaTimingFunctionName.linear,//匀速
                                CAMediaTimingFunctionName.easeIn,//先慢
                                CAMediaTimingFunctionName.easeOut,//后慢
                                CAMediaTimingFunctionName.easeInEaseOut,//先慢 后慢 中间快
                                CAMediaTimingFunctionName.default//默认
                                ];
    // MARK: - kCATransition
    /// 立方体效果
    static let kCATransitionCube                  = "cube";
    /// 阿拉神灯效果
    static let kCATransitionSuckEffect            = "suckEffect";
    /// 上下左右翻转效果
    static let kCATransitionOglFlip               = "oglFlip";
    /// 水滴效果
    static let kCATransitionRippleEffect          = "rippleEffect";
    /// 向上翻页效果
    static let kCATransitionPageCurl              = "pageCurl";
    /// 向下翻页效果
    static let kCATransitionPageUnCurl            = "pageUnCurl";
    /// 相机镜头打开效果
    static let kCATransitionCameraIrisHollowOpen  = "cameraIrisHollowOpen";
    /// 相机镜头关闭效果
    static let kCATransitionCameraIrisHollowClose = "cameraIrisHollowClose";
    /// 动画方向
    static let kSubTypeFuntionNames = [CATransitionSubtype.fromTop,
                                       CATransitionSubtype.fromLeft,
                                       CATransitionSubtype.fromBottom,
                                       CATransitionSubtype.fromRight];
}
