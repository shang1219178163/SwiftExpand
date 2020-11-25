//
//  NSObject+Define.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/28.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

// 定义数据类型(其实就是设置别名)
public typealias SwiftClosure = ((AnyObject, AnyObject, Int) ->Void)

public typealias ObjClosure = ((AnyObject) ->Void)
public typealias ViewClosure = ((UITapGestureRecognizer?, UIView, NSInteger) ->Void)
public typealias ControlClosure = ((UIControl) ->Void)
public typealias RecognizerClosure = ((UIGestureRecognizer) ->Void)

public typealias TextFieldClosure = ((UITextField) ->Void)
public typealias TextViewClosure = ((UITextView) ->Void)

public typealias CellHeightForRowClosure = ((UITableView, IndexPath) ->CGFloat)
public typealias CellForRowClosure = ((UITableView, IndexPath) ->UITableViewCell?)
public typealias DidSelectRowClosure = ((UITableView, IndexPath) ->Void)

public typealias CellForItemClosure = ((UICollectionView, IndexPath) ->UICollectionViewCell?)
public typealias DidSelectItemClosure = ((UICollectionView, IndexPath) ->Void)

public typealias ScrollViewDidScrollClosure = ((UIScrollView) ->Void)

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

/// 自定义UIEdgeInsets
public func UIEdgeInsetsMake(_ top: CGFloat = 0, _ left: CGFloat = 0, _ bottom: CGFloat = 0, _ right: CGFloat = 0) -> UIEdgeInsets{
    return UIEdgeInsets(top: top, left: left, bottom: bottom, right: right)
}

/// 自定义CGRect
public func CGRectMake(_ x: CGFloat = 0, _ y: CGFloat = 0, _ w: CGFloat = 0, _ h: CGFloat = 0) -> CGRect{
    return CGRect(x: x, y: y, width: w, height: h)
}

/// 自定义CGPointMake
public func CGPointMake(_ x: CGFloat = 0, _ y: CGFloat = 0) -> CGPoint {
    return CGPoint(x: x, y: y)
}

/// 自定义GGSizeMake
public func GGSizeMake(_ w: CGFloat = 0, _ h: CGFloat = 0) -> CGSize {
    return CGSize(width: w, height: h)
}

/// 自定义GGSizeMake
public func UIOffsetMake(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> UIOffset {
    return UIOffset(horizontal: horizontal, vertical: vertical)
}

///角度转弧度
 public func CGRadianFromDegrees(_ value: CGFloat) -> CGFloat{
    return (CGFloat(Double.pi) * (value) / 180.0);
}
///弧度转角度
public func CGDegreesFromRadian(_ value: CGFloat) -> CGFloat{
    return (value * 180.0)/CGFloat((Double.pi));
}

/// 自定义两点之间距离
public func CGDistance(_ pointA: CGPoint, pointB: CGPoint) -> CGFloat {
    let result = sqrt(pow(pointA.x - pointB.x, 2) + pow(pointA.y - pointB.y, 2))
    return result
}

///返回类名字符串
public func NNStringFromClass(_ cls: Swift.AnyClass) -> String {
    return String(describing: cls);// return "\(type(of: self))";
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

/// 获取本地 UIViewController 文件
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

public func UINavCtrFromObj(_ obj: AnyObject) -> UINavigationController?{
    if obj is UINavigationController {
        return obj as? UINavigationController;
        
    } else if obj is String {
        return UINavigationController(rootViewController: UICtrFromString(obj as! String));
        
    } else if obj is UIViewController {
        return UINavigationController(rootViewController: obj as! UIViewController);
    }
    return nil;
}

/// 获取UIViewController/UINavigationController数组
public func UICtlrListFromList(_ list: [[String]], isNavController: Bool = false, showVCTitle: Bool = true) -> [UIViewController] {
    return UIViewController.controllers(list, isNavController: isNavController, showVCTitle: showVCTitle)
}

/// 获取UINavigationController数组
public func UINavListFromList(_ list: [[String]], showVCTitle: Bool = true) -> [UIViewController] {
    return UICtlrListFromList(list, isNavController: true, showVCTitle: showVCTitle)
}

///获取UITarBarController
public func UITarBarCtrFromList(_ list: [[String]]) -> UITabBarController {
    let tabBarVC = UITabBarController()
    tabBarVC.viewControllers = UICtlrListFromList(list, isNavController: true)
    return tabBarVC
}

/// 地址字符串(hostname + port)
public func UrlAddress(_ hostname: String, port: String) ->String {
    return NSString.UrlAddress(hostname, port: port);
}

///// 两个Int(+-*/)
//public func resultByOpt(_ num1: Int, _ num2: Int, result: (Int, Int) -> Int) -> Int {
//    return result(num1, num2);
//}

/// 两个数值(+-*/)
public func resultByOpt<T>(_ num1: T, _ num2: T, result: (T, T) -> T) -> T {
    return result(num1, num2);
}
