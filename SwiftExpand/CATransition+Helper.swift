//
//  CATransition+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/3/29.
//  Copyright © 2019 BN. All rights reserved.
//
import QuartzCore


@objc public extension CATransition{
   
    /// [源]CATransition
    static func animDuration(_ duration: CFTimeInterval,
                                   functionName: CAMediaTimingFunctionName = .linear,
                                   type: CATransitionType = .fade,
                                   subType: CATransitionSubtype? = nil) -> CATransition {

        let anim = CATransition()
        anim.duration = duration;
       
        let name = kFunctionNames.contains(functionName) ? functionName : kFunctionNames.first;
        anim.timingFunction = CAMediaTimingFunction(name: name!);
        anim.type = type
        anim.subtype = subType
        return anim;
    }
    
}
