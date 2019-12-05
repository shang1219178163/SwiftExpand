//
//  UINavigationController+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/5.
//

import UIKit

@objc public extension UINavigationController{
    
    /// vcName 控制器类名
    convenience init(vcName: String){
        self.init(rootViewController: UICtrFromString(vcName))
    }
}
