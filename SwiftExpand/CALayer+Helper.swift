//
//  CALayer+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension CALayer{
    
    static func create(_ rect: CGRect = .zero, contents: Any?) -> CALayer {
        let layer = CALayer()
        layer.frame = rect
        layer.contents = contents
        layer.contentsScale = UIScreen.main.scale
        layer.rasterizationScale = UIScreen.main.scale
        layer.shouldRasterize = true
        return layer
    }
    /// 控制器切换渐变动画
    func addAnimationFade(_ duration: CFTimeInterval = 0.15, functionName: CAMediaTimingFunctionName = .easeIn) {
        
        let anim = CATransition()
        anim.duration = duration;
        anim.timingFunction = CAMediaTimingFunction(name: functionName);
        anim.type = .fade
        anim.isRemovedOnCompletion = true;
        self.add(anim, forKey: "change_view_controller")
    }
}
