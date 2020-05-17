
//
//  UIViewController+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UIViewController{
    /// 关联obj任意对象
    var obj: AnyObject? {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as AnyObject;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// 关联obj任意对象
    var objOne: AnyObject? {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as AnyObject;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// 关联NSMutableArray 数据容器
    var dataList: NSMutableArray {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? NSMutableArray;
            if obj == nil {
                obj = [];
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    /// 关联UITableView视图对象
    var tbView: UITableView {
        guard let tableView = view.subView(UITableView.self) as? UITableView else {
            let view = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
            if self.conforms(to: UITableViewDataSource.self) {
                view.dataSource = self as? UITableViewDataSource;
            }
            if self.conforms(to: UITableViewDelegate.self) {
                view.delegate = self as? UITableViewDelegate;
            }
            return view
        }
        return tableView
    }
    /// 关联UITableView视图对象
    var tbViewGrouped: UITableView {
        guard let tableView = view.subView(UITableView.self) as? UITableView else {
            let view = UITableView.create(self.view.bounds, style: .plain, rowHeight: 50)
            if self.conforms(to: UITableViewDataSource.self) {
                view.dataSource = self as? UITableViewDataSource;
            }
            if self.conforms(to: UITableViewDelegate.self) {
                view.delegate = self as? UITableViewDelegate;
            }
            return view
        }
        return tableView
    }
    
    /// 关联UICollectionView视图对象
    var ctView: UICollectionView {
        guard let collectionView = view.subView(UICollectionView.self) as? UICollectionView else {
            let view = UICollectionView(frame: self.view.bounds, collectionViewLayout: UICollectionView.layoutDefault)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isPagingEnabled = true;
            view.backgroundColor = UIColor.background

            view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
            if self.conforms(to: UICollectionViewDataSource.self) {
                view.dataSource = (self as! UICollectionViewDataSource)
            }
             
            if self.conforms(to: UICollectionViewDelegate.self) {
                view.delegate = (self as! UICollectionViewDelegate)
            }
            return view
        }
        return collectionView
    }
    
    /// 关联tipLab
    var tipLab: UILabel {
        let view = UILabel(frame: .zero)
        view.text = "暂无数据"
        view.textColor = UIColor.gray;
        view.sizeToFit();
        view.center = self.view.center;
        return view
    }
}
