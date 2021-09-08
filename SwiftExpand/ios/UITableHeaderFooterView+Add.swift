//
//  UITableHeaderFooterView+Add.swift
//  BuildUI
//
//  Created by Bin Shang on 2018/12/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UITableViewHeaderFooterView{

    /// [源]自定义 UITableViewHeaderFooterView 获取方法(兼容OC)
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView, identifier: String) -> Self {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) ?? self.init(reuseIdentifier: identifier)
        view.contentView.lineTop.isHidden = false
        view.contentView.lineBottom.isHidden = false
        return view as! Self
    }
    
    /// [OC简洁方法]自定义 UITableViewHeaderFooterView 获取方法
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView) -> Self {
        return dequeueReusableHeaderFooterView(tableView, identifier: String(describing: self))
    }
 
}

@objcMembers public class NNFoldSectionModel: NSObject{
    public var title = "标题"
    public var titleSub = "子标题"
    public var image = "图片名称"
    public var isOpen = false
    public var isCanOpen = false
    public var headerHeight: CGFloat = 10.0
    public var footerHeight: CGFloat = 0.01
    public var headerColor: UIColor = .background
    public var footerColor: UIColor = .background
    public var sectionModel: AnyObject?

    public var dataList: [Any] = []
//    public var dataList: NSMutableArray = []
    public var cellList: NSMutableArray = []
}
