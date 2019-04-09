//
//  CAKeyframeAnimation+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/3/29.
//  Copyright © 2019 BN. All rights reserved.
//
import QuartzCore

extension CAKeyframeAnimation{
    
    /// [源]CAKeyframeAnimation
    @objc public static func animDuration(_ duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float, fillMode:String, removedOnCompletion:Bool, functionName:String!) -> CAKeyframeAnimation {
        let anim: CAKeyframeAnimation = CAKeyframeAnimation(keyPath: kTransformPosition);
        anim.duration = duration;
        anim.repeatCount = repeatCount;
        anim.fillMode = fillMode;
        anim.isRemovedOnCompletion = removedOnCompletion;
        
        let name = kFunctionNames.contains(functionName) ? functionName : kFunctionNames.first;
        anim.timingFunction = CAMediaTimingFunction(name: name!);
        return anim;
    }
    
    /// CAKeyframeAnimation
    @objc public static func animPath(_ pathRef:CGPath, duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float) -> CAKeyframeAnimation {
        let anim: CAKeyframeAnimation = CAKeyframeAnimation.animDuration(duration, autoreverses: autoreverses, repeatCount: repeatCount, fillMode: kCAFillModeForwards, removedOnCompletion: false, functionName:kCAMediaTimingFunctionDefault)
        anim.path = pathRef;
        return anim;
    }
    
    /// CAKeyframeAnimation
    @objc public static func animValues(_ values: [Any], duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float, fillMode:String, removedOnCompletion:Bool, functionName:String!) -> CAKeyframeAnimation {
        let anim: CAKeyframeAnimation = CAKeyframeAnimation.animDuration(duration, autoreverses: autoreverses, repeatCount: repeatCount, fillMode: fillMode, removedOnCompletion: removedOnCompletion, functionName:functionName)
        anim.values = values;
        return anim;
    }
    
    /// [便捷]CAKeyframeAnimation
    @objc public static func animValues(_ values: [Any], duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float) -> CAKeyframeAnimation {
        let anim: CAKeyframeAnimation = CAKeyframeAnimation.animDuration(duration, autoreverses: autoreverses, repeatCount: repeatCount, fillMode: kCAFillModeForwards, removedOnCompletion: false, functionName:kCAMediaTimingFunctionDefault)
        anim.values = values;
        return anim;
    }
    
}
