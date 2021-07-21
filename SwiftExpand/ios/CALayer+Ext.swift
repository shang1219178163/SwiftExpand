//
//  CALayer+Ext.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

@objc public extension CALayer{
    
    func shake() {
        let anim = CABasicAnimation(keyPath: "position")
        anim.duration = 0.05
        anim.repeatCount = 5
        anim.autoreverses = true
        anim.fromValue = NSValue(cgPoint: CGPoint(x: position.x - 4.0, y: position.y))
        anim.toValue = NSValue(cgPoint: CGPoint(x: position.x + 4.0,  y: position.y))
        self.add(anim, forKey: "position")
    }
}
