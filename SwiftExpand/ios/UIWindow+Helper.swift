//
//  UIWindow+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

@objc public extension UIWindow {

    func switchRootViewController(
        to viewController: UIViewController,
        animated: Bool = true,
        duration: TimeInterval = 0.5,
        functionName: CAMediaTimingFunctionName = .easeIn,
        completion: (() -> Void)? = nil) {
        guard animated else {
            rootViewController = viewController
            completion?()
            return
        }
        
        layer.addAnimationFade(duration, functionName: functionName)
        rootViewController = viewController

//        UIView.transition(with: self, duration: duration, options: options, animations: {
//            let oldState = UIView.areAnimationsEnabled
//            UIView.setAnimationsEnabled(false)
//            self.rootViewController = viewController
//            UIView.setAnimationsEnabled(oldState)
//        }, completion: { _ in
//            completion?()
//        })
    }

}
