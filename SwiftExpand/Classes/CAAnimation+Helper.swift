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
    static let kFunctionNames: [CAMediaTimingFunctionName] = [
        .linear,//匀速
        .easeIn,//先慢
        .easeOut,//后慢
        .easeInEaseOut,//先慢 后慢 中间快
        .default//默认
        ];

}


public extension CAAnimation {

    func timingFunctionChain(_ timingFunction: CAMediaTimingFunction?) -> Self {
        self.timingFunction = timingFunction
        return self
    }

    func delegateChain(_ delegate: CAAnimationDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    func isRemovedOnCompletionChain(_ isRemovedOnCompletion: Bool) -> Self {
        self.isRemovedOnCompletion = isRemovedOnCompletion
        return self
    }

}

public extension CAAnimationGroup {

    func animationsChain(_ animations: [CAAnimation]) -> Self {
        self.animations = animations
        return self
    }

}

public extension CATransition {

    func typeChain(_ type: CATransitionType) -> Self {
        self.type = type
        return self
    }

    func subtypeChain(_ subtype: CATransitionSubtype?) -> Self {
        self.subtype = subtype
        return self
    }

    func startProgressChain(_ startProgress: Float) -> Self {
        self.startProgress = startProgress
        return self
    }

    func endProgressChain(_ endProgress: Float) -> Self {
        self.endProgress = endProgress
        return self
    }

}


public extension CASpringAnimation {

    func massChain(_ mass: CGFloat) -> Self {
        self.mass = mass
        return self
    }

    func stiffnessChain(_ stiffness: CGFloat) -> Self {
        self.stiffness = stiffness
        return self
    }

    func dampingChain(_ damping: CGFloat) -> Self {
        self.damping = damping
        return self
    }

    func initialVelocityChain(_ initialVelocity: CGFloat) -> Self {
        self.initialVelocity = initialVelocity
        return self
    }

}


public extension CAKeyframeAnimation {

    func valuesChain(_ values: [Any]) -> Self {
        self.values = values
        return self
    }

    func pathChain(_ path: CGPath?) -> Self {
        self.path = path
        return self
    }

    func keyTimesChain(_ keyTimes: [NSNumber]) -> Self {
        self.keyTimes = keyTimes
        return self
    }

    func timingFunctionsChain(_ timingFunctions: [CAMediaTimingFunction]) -> Self {
        self.timingFunctions = timingFunctions
        return self
    }

    func calculationModeChain(_ calculationMode: CAAnimationCalculationMode) -> Self {
        self.calculationMode = calculationMode
        return self
    }

    func tensionValuesChain(_ tensionValues: [NSNumber]) -> Self {
        self.tensionValues = tensionValues
        return self
    }

    func continuityValuesChain(_ continuityValues: [NSNumber]) -> Self {
        self.continuityValues = continuityValues
        return self
    }

    func biasValuesChain(_ biasValues: [NSNumber]) -> Self {
        self.biasValues = biasValues
        return self
    }

    func rotationModeChain(_ rotationMode: CAAnimationRotationMode?) -> Self {
        self.rotationMode = rotationMode
        return self
    }

}


public extension CABasicAnimation {

    func fromValueChain(_ fromValue: Any?) -> Self {
        self.fromValue = fromValue
        return self
    }

    func toValueChain(_ toValue: Any?) -> Self {
        self.toValue = toValue
        return self
    }

    func byValueChain(_ byValue: Any?) -> Self {
        self.byValue = byValue
        return self
    }

}


public extension CAPropertyAnimation {

    func keyPathChain(_ keyPath: String?) -> Self {
        self.keyPath = keyPath
        return self
    }

    func isAdditiveChain(_ isAdditive: Bool) -> Self {
        self.isAdditive = isAdditive
        return self
    }

    func isCumulativeChain(_ isCumulative: Bool) -> Self {
        self.isCumulative = isCumulative
        return self
    }

    func valueFunctionChain(_ valueFunction: CAValueFunction?) -> Self {
        self.valueFunction = valueFunction
        return self
    }

}


public extension CAMediaTiming {

    func beginTimeChain(_ beginTime: CFTimeInterval) -> Self {
        self.beginTime = beginTime
        return self
    }

    func durationChain(_ duration: CFTimeInterval) -> Self {
        self.duration = duration
        return self
    }

    func speedChain(_ speed: Float) -> Self {
        self.speed = speed
        return self
    }

    func timeOffsetChain(_ timeOffset: CFTimeInterval) -> Self {
        self.timeOffset = timeOffset
        return self
    }

    func repeatCountChain(_ repeatCount: Float) -> Self {
        self.repeatCount = repeatCount
        return self
    }

    func repeatDurationChain(_ repeatDuration: CFTimeInterval) -> Self {
        self.repeatDuration = repeatDuration
        return self
    }

    func autoreversesChain(_ autoreverses: Bool) -> Self {
        self.autoreverses = autoreverses
        return self
    }

    func fillModeChain(_ fillMode: CAMediaTimingFillMode) -> Self {
        self.fillMode = fillMode
        return self
    }
}
