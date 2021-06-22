
//
//  UIViewController+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UIViewController{
    private struct AssociateKeys {
        static var tbView   = "UIViewController" + "tbView"
    }
    /// 关联UITableView视图对象
    var tbView: UITableView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.tbView) as? UITableView {
                return obj
            }

            let view = UITableView(rect: self.view.bounds, style: .plain, rowHeight: 50)
            if self.conforms(to: UITableViewDataSource.self) {
                view.dataSource = self as? UITableViewDataSource
            }
            if self.conforms(to: UITableViewDelegate.self) {
                view.delegate = self as? UITableViewDelegate
            }

            objc_setAssociatedObject(self, &AssociateKeys.tbView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.tbView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}

