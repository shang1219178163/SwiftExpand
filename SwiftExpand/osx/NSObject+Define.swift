//
//  NSObject+Define.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import AppKit

public typealias CellForRowClosure = ((NSTableView, IndexPath) -> NSTableCellView?)
public typealias DidSelectRowClosure = ((NSTableView, IndexPath) -> Void)
//
public typealias CellForItemClosure = ((NSCollectionView, IndexPath) -> NSCollectionViewElement?)
public typealias DidSelectItemClosure = ((NSCollectionView, IndexPath) -> Void)



public func NSStringFromIndexPath(_ tableView: NSTableView, tableColumn: NSTableColumn, row: Int) -> String {
    let item: Int = tableView.tableColumns.firstIndex(of: tableColumn)!
    return String(format: "{%d, %d}", row, item)
}

//获取本地创建类
public func NNClassFromString(_ name: String) -> AnyClass? {
    if let cls = NSClassFromString(name) {
//         print("✅_Objc类存在: \(name)")
        return cls
     }
     
     let swiftClassName = "\(NSApplication.appBundleName ?? "").\(name)"
     if let cls = NSClassFromString(swiftClassName) {
//         print("✅_Swift类存在: \(swiftClassName)")
         return cls
     }
     print("❌_类不存在: \(name)")
    return nil;
}

/// 获取本地 NSViewController 文件(Swift类,需要在名称之前加 . 符号,以示区别)
public func NSCtrFromString(_ vcName: String) -> NSViewController {
    assert(NNClassFromString(vcName) != nil )
    let cls: AnyClass = NNClassFromString(vcName)!
    // 通过类创建对象， 不能用cls.init(),有的类可能没有init方法
    // 需将cls转换为制定类型
    let vcCls = cls as! NSViewController.Type
    // 创建对象
    let vc: NSViewController = vcCls.init()
    return vc
}

///获取 ItemSize
public func calculateItemSize(_ numOfRow: Int = 4, width: CGFloat = NSScreen.main!.frame.width, minimumInteritemSpacing: CGFloat = 10, heightScale: CGFloat = 1) -> CGSize {

    let itemWidth = (width - (CGFloat(numOfRow) - 1) * minimumInteritemSpacing)/CGFloat(numOfRow)
    let itemSize = CGSize(width: round(itemWidth) - 2, height: itemWidth * heightScale)
    return itemSize
}
