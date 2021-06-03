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



@objc public extension NSObject{
    static var named: String {
        let array = NSStringFromClass(self).components(separatedBy: ".")
        return array.last ?? ""
    }

    ///遍历成员变量列表
    func enumerateIvars(_ block: @escaping ((Ivar, String, Any?)->Void)) {
        var count: UInt32 = 0
        guard let list = class_copyIvarList(self.classForCoder, &count) else { return }
        defer {
            free(list)// 释放c语言对象
        }

        for i in 0..<Int(count) {
            let ivar = list[i]
            //转换成String字符串
            guard let name = ivar_getName(ivar),
                let strName = String(cString: name, encoding: String.Encoding.utf8) else {
                //继续下一次遍历
                continue
            }
            //利用kvc 取值
            let value = self.value(forKey: strName)
            block(ivar, strName, value)
        }
    }
    ///遍历属性列表
    func enumeratePropertys(_ block: @escaping ((objc_property_t, String, Any?)->Void)) {
        var count: UInt32 = 0
        guard let list = class_copyPropertyList(self.classForCoder, &count) else { return }
        defer {
            free(list)// 释放c语言对象
        }
        
        for i in 0..<Int(count) {
            let property: objc_property_t = list[i]
            //获取成员变量的名称 -> c语言字符串
            let name = property_getName(property)
            //转换成String字符串
            guard let strName = String(cString: name, encoding: .utf8) else {
                //继续下一次遍历
                continue
            }
            //利用kvc 取值
            let value = self.value(forKey: strName)
            block(property, strName, value)
        }
    }
    ///遍历方法列表
    func enumerateMethods(_ block: @escaping ((Method, String)->Void)) {
        var count: UInt32 = 0
        guard let list = class_copyMethodList(self.classForCoder, &count) else { return }
        defer {
            free(list)// 释放c语言对象
        }

        for i in 0..<Int(count) {
            let method: Method = list[i]
            //获取成员变量的名称 -> c语言字符串
            let name: Selector = method_getName(method)
            //转换成String字符串
            let strName = NSStringFromSelector(name)
            block(method, strName)
        }
    }
    ///遍历遵循的协议列表
    func enumerateProtocols(_ block: @escaping ((Protocol, String)->Void)) {
        var count: UInt32 = 0
        guard let list = class_copyProtocolList(self.classForCoder, &count) else { return }

        for i in 0..<Int(count) {
            let proto: Protocol = list[i]
            //获取成员变量的名称 -> c语言字符串
            let name = protocol_getName(proto)
            //转换成String字符串
            guard let strName = String(cString: name, encoding: String.Encoding.utf8) else {
                //继续下一次遍历
                continue
            }
            block(proto, strName)
        }
    }

    /// 模型自动编码
    func se_encode(with aCoder: NSCoder) {
        enumeratePropertys { (property, name, value) in
            guard let value = self.value(forKey: name) else { return }
            //进行编码
            aCoder.encode(value, forKey: name)
        }
    }
    
    /// 模型自动解码
    func se_decode(with aDecoder: NSCoder) {
        enumeratePropertys { (property, name, value) in
            //进行解档取值
            guard let value = aDecoder.decodeObject(forKey: name) else { return }
            //利用kvc给属性赋值
            self.setValue(value, forKeyPath: name)
        }
    }
    /// 字典转模型
//    convenience init(dic: [String: Any]) {
//        self.init();
//        self.setValuesForKeys(dic)
//    }
//    ///详情模型转字典(不支持嵌套)
//    func toDictionary() -> [AnyHashable : Any] {
//        var dic: [AnyHashable : Any] = [:]
//        self.enumeratePropertys { (property, name, value) in
//            dic[name] = value ?? ""
//        }
//        return dic
//    }
    
    func synchronized(_ lock: AnyObject, block: () -> Void) {
        objc_sync_enter(lock)
        block()
        objc_sync_exit(lock)
    }
            
    // MARK: - KVC

    /// 返回key对应的值
    func valueText(forKey key: String, defalut: String = "-") -> String{
        if key == "" {
            return "";
        }
        if let result = self.value(forKey: key) {
            return "\(result)" != "" ? "\(result)" : defalut;
        }
        return defalut;
    }
    /// 返回key对应的值
    func valueText(forKeyPath keyPath: String, defalut: String = "-") -> String{
        if keyPath == "" {
            return "";
        }
        if let result = self.value(forKeyPath: keyPath) {
            return "\(result)" != "" ? "\(result)" : defalut;
        }
        return defalut;
    }

}


public extension NSObjectProtocol where Self: NSObject {
    /// viewModel.observe(\.playButtonTitle) { [playButton] in playButton!.setTitle($0, for: .normal) },
    func observe<Value>(_ keyPath: KeyPath<Self, Value>, onChange: @escaping (Value) -> ()) -> NSKeyValueObservation {
        return observe(keyPath, options: [.initial, .new]) { _, change in
            guard let newValue = change.newValue else { return }
            onChange(newValue)
        }
    }
    
    ///viewModel.bind(\.navigationTitle, to: navigationItem, at: \.title)
    func bind<Value, Target>(_ sourceKeyPath: KeyPath<Self, Value>, to target: Target, at targetKeyPath: ReferenceWritableKeyPath<Target, Value>) -> NSKeyValueObservation {
        return observe(sourceKeyPath) { target[keyPath: targetKeyPath] = $0 }
    }

}
