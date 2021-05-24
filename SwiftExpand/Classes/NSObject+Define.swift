//
//  NSObject+Define.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

// 定义数据类型(其实就是设置别名)
public typealias CellForRowClosure = ((UITableView, IndexPath) ->UITableViewCell?)
public typealias DidSelectRowClosure = ((UITableView, IndexPath) ->Void)
//
public typealias CellForItemClosure = ((UICollectionView, IndexPath) ->UICollectionViewCell?)
public typealias DidSelectItemClosure = ((UICollectionView, IndexPath) ->Void)

/// 打印地址
public func AddressOf(_ o: UnsafeRawPointer) -> String {
    let addr = Int(bitPattern: o)
    return String(format: "%p", addr)
}
/// 打印地址
public func AddressOf<T: AnyObject>(_ o: T) -> String {
    let addr = unsafeBitCast(o, to: Int.self)
//    return String(format: "%p", addr)
    return "\(addr)"
}

//获取本地创建类
public func NNClassFromString(_ name: String) -> AnyClass? {
    if let cls = NSClassFromString(name) {
//        print("✅_Objc类存在: \(name)")
        return cls;
     }
     
     let swiftClassName = "\(UIApplication.appBundleName).\(name)";
     if let cls = NSClassFromString(swiftClassName) {
//         print("✅_Swift类存在: \(swiftClassName)")
         return cls;
     }
     print("❌_类不存在: \(name)")
    return nil;
}

/// 获取本地 UIViewController 文件(swift 文件名必须带命名空间)
public func UICtrFromString(_ vcName: String) -> UIViewController {
    assert(vcName.hasSuffix("Controller"), "控制器必须以Controller结尾")
    let cls: AnyClass = NNClassFromString(vcName)!;
    // 通过类创建对象， 不能用cls.init(),有的类可能没有init方法
    // 需将cls转换为制定类型
    let vcCls = cls as! UIViewController.Type;
    // 创建对象
    let controller: UIViewController = vcCls.init();
    controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
    return controller;
}
