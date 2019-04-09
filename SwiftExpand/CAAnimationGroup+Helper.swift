//
//  CAAnimationGroup+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/3/29.
//  Copyright © 2019 BN. All rights reserved.
//

import QuartzCore

extension CAAnimationGroup{
    
    /// [源]CAAnimationGroup
    @objc public static func animDuration(_ duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float, fillMode:String, removedOnCompletion:Bool) -> CAAnimationGroup {
        
        let anim: CAAnimationGroup = CAAnimationGroup();
        anim.duration = duration;
        anim.repeatCount = repeatCount;
        anim.fillMode = fillMode;
        anim.isRemovedOnCompletion = removedOnCompletion;
        return anim;
    }
    
    /// [简]CAAnimationGroup
    @objc public static func animDuration(_ animList: [CAAnimation], duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float, fillMode:String, removedOnCompletion:Bool) -> CAAnimationGroup {
        let anim = CAAnimationGroup.animDuration(duration, autoreverses: autoreverses, repeatCount: repeatCount, fillMode: fillMode, removedOnCompletion: removedOnCompletion);
        anim.animations = animList;
        return anim;
    }
    
    /// [便捷]CAAnimationGroup
    @objc public static func animDuration(_ animList: [CAAnimation], duration: CFTimeInterval, autoreverses:Bool, repeatCount:Float) -> CAAnimationGroup {
        let anim = CAAnimationGroup.animDuration(duration, autoreverses: autoreverses, repeatCount: repeatCount, fillMode: kCAFillModeForwards, removedOnCompletion: false);
        anim.animations = animList;
        return anim;
    }
    
}
