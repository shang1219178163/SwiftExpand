//
//  NSObject+Define.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//



public typealias CellForRowClosure = ((NSTableView, IndexPath) -> NSTableCellView?)
public typealias DidSelectRowClosure = ((NSTableView, IndexPath) -> Void)
//
public typealias CellForItemClosure = ((NSCollectionView, IndexPath) -> NSCollectionViewElement?)
public typealias DidSelectItemClosure = ((NSCollectionView, IndexPath) -> Void)



public func NSStringFromIndexPath(_ tableView: NSTableView, tableColumn: NSTableColumn, row: Int) -> String {
    let item: Int = tableView.tableColumns.firstIndex(of: tableColumn)!
    return String(format: "{%d, %d}", row, item);
}

///返回类名字符串
public func NNStringFromClass(_ cls: Swift.AnyClass) -> String {
    return String(describing: cls);// return "\(type(of: self))";
}

//获取本地创建类
public func NNClassFromString(_ name: String) -> AnyClass? {
    if let cls = NSClassFromString(name) {
//         print("✅_Objc类存在: \(name)")
        return cls;
     }
     
     let swiftClassName = "\(NSApplication.appBundleName).\(name)";
     if let cls = NSClassFromString(swiftClassName) {
//         print("✅_Swift类存在: \(swiftClassName)")
         return cls;
     }
     print("❌_类不存在: \(name)")
    return nil;
}

/// 获取本地 NSViewController 文件(Swift类,需要在名称之前加 . 符号,以示区别)
public func NSCtrFromString(_ vcName: String) -> NSViewController {
    let cls: AnyClass = NNClassFromString(vcName)!;
    // 通过类创建对象， 不能用cls.init(),有的类可能没有init方法
    // 需将cls转换为制定类型
    let vcCls = cls as! NSViewController.Type;
    // 创建对象
    let controller: NSViewController = vcCls.init();
    return controller;
}

