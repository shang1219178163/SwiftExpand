//
//  UIStoryboard+Helper.swift
//  IntelligentOfParking
//
//  Created by Bin Shang on 2020/1/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UIStoryboard{
    
    /// 获取指定控制器
    static func storyboard(with name: String, bundle: Bundle? = nil, identifier: String) -> UIViewController {
        let storyboard = UIStoryboard(name: name, bundle: bundle)
        let controller = storyboard.instantiateViewController(withIdentifier: identifier)
        return controller
    }
}
