
//
//  UIViewController+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UIViewController{
    /// 关联UITableView视图对象
    var tbView: UITableView {
        if let tableView = view.subView(UITableView.self) as? UITableView {
            return tableView
        }
        
        let view = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
        if self.conforms(to: UITableViewDataSource.self) {
            view.dataSource = self as? UITableViewDataSource;
        }
        if self.conforms(to: UITableViewDelegate.self) {
            view.delegate = self as? UITableViewDelegate;
        }
        return view
    }

}

