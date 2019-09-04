//
//  UICollectionView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/16.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension UICollectionView{
    
    @objc static let elementKindSectionItem: String = "UICollectionView.elementKindSectionItem";
    
    /// 泛型复用register cell - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UICollectionViewCell>(cellType: T.Type, forCellWithReuseIdentifier identifier: String = String(describing: T.self)){
        self.register(cellType.self, forCellWithReuseIdentifier: identifier)
    }
    
    /// 泛型复用register supplementaryView - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String = UICollectionView.elementKindSectionHeader){
        guard elementKind.contains("KindSection") else {
            return;
        }
        let kindSuf = elementKind.components(separatedBy: "KindSection").last;
        let identifier = String(describing: T.self) + kindSuf!;
        self.register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /// 泛型复用cell - cellType: "类名.self" (备用默认值 T.self)
    final func dequeueReusableCell<T: UICollectionViewCell>(for cellType: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return cell as! T;
    }
    
    /// 泛型复用cell - aClass: "类名()"
    final func dequeueReusableCell<T: UICollectionViewCell>(for aClass: T, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        return dequeueReusableCell(for: T.self, identifier: identifier, indexPath: indexPath)
    }
    
    /// 泛型复用SupplementaryView - cellType: "类名.self" (备用默认值 T.self)
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for cellType: T.Type, kind: String, indexPath: IndexPath) -> T{
        let kindSuf = kind.components(separatedBy: "KindSection").last;
        let identifier = String(describing: T.self) + kindSuf!;
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.textLabel.text = kindSuf! + "\(indexPath.section)";
        
        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? UIColor.green : UIColor.yellow;
        return view as! T;
    }
    
    /// 泛型复用SupplementaryView - aClass: "类名()"
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for aClass: T, kind: String, indexPath: IndexPath) -> T{
        return dequeueReusableSupplementaryView(for: T.self, kind: kind, indexPath: indexPath)
    }
    
    /// 通用方法cell
    @objc static func dequeueCTVCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionViewCell{
        let identifier = self.identifier;
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        return view;
    }
    
    /// UICollectionViewLayout默认布局
    @objc static var layoutDefault: UICollectionViewLayout {
        get {
            var layout = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UICollectionViewFlowLayout;
            if layout == nil {
                // 初始化
//                let width = UIScreen.main.bounds.width;
//                let spacing: CGFloat = 5.0
//                let itemSize = CGSize(width: (width - 5*spacing)/4.0,height: (width - 5*spacing)/4.0);
//                let headerSize = CGSize(width: width, height: 30);
//                let footerSize = CGSize(width: width, height: 30);
//                layout = UICollectionViewFlowLayout.create(itemSize, spacing: spacing, headerSize: headerSize, footerSize: footerSize)
                layout = UICollectionViewFlowLayout.create(<#T##itemSize: CGSize##CGSize#>, headerSize: <#T##CGSize#>, footerSize: <#T##CGSize#>)

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return layout!
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc var listClass: Array<String> {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! Array<String>;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            registerCTVCell(newValue)
        }
    }
    
    @objc var dictClass: Dictionary<String, Array<String>> {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! Dictionary<String, Array<String>>;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            registerCTVAll();
        }
    }
    
    /// dictClass注册
    @objc func registerCTVAll() {
        if dictClass.keys.count == 0 {
            return
        }
        dictClass.forEach { (arg0) in
//            DDLog(arg0)
            let (key, value) = arg0
            if key == UICollectionView.elementKindSectionItem {
                registerCTVCell(value)
            }else {
                registerCTVReusable(value, kind: key)
            }
        }
    }
    
    /// cell注册
    @objc func registerCTVCell(_ listClass: Array<String>) {
        listClass.forEach { (className: String) in
            let obj:AnyClass = SwiftClassFromString(className)
            register(obj, forCellWithReuseIdentifier: className)
        }
    }
    
    /// 获取 UICollectionViewElementKindSection 标志
    @objc func sectionReuseIdentifier(_ className: String, kind: String = UICollectionView.elementKindSectionHeader) -> String{
        let extra = kind == UICollectionView.elementKindSectionHeader ? "Header" : "Footer";
        let identifier = className + extra;
        return identifier;
    }
    
    /// headerView/FooterView注册
    @objc func registerCTVReusable(_ listClass: Array<String>, kind: String = UICollectionView.elementKindSectionHeader) {
        listClass.forEach { (className: String) in
            let identifier = sectionReuseIdentifier(className, kind: kind)
            register(SwiftClassFromString(className).self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
//    ///  默认布局配置(自上而下,自左而右)
//    @objc func create(_ rowNum: Int = 4, spacing: CGFloat = kPadding, headerHeight: CGFloat = 30, footerHeight: CGFloat = 30) -> UICollectionViewFlowLayout {
//        
//        let itemWidth = (bounds.width - (rowNum.toCGFloat + 1)*spacing)/rowNum.toCGFloat;
//        let itemHeight = itemWidth/kRatioIDCard;
//        let itemSize = CGSize(width: itemWidth, height: itemHeight);
//        let headerSize = CGSize(width: bounds.width, height: headerHeight);
//        let footerSize = CGSize(width: bounds.width, height: footerHeight);
//        let layout = UICollectionViewFlowLayout.create(itemSize, spacing: spacing, headerSize: headerSize, footerSize: footerSize);
//        return layout;
//    }

    
}


