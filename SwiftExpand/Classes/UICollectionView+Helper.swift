//
//  UICollectionView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/16.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UICollectionView{
    private struct AssociateKeys {
        static var dictClass   = "UICollectionView" + "dictClass"
    }
    
    static let elementKindSectionItem: String = "UICollectionView.elementKindSectionItem";
    static let sectionKindBackgroud: String = "UICollectionView.sectiinKindBackgroud";

    /// 默认流水布局
    static func layoutDefault(_ headerHeight: CGFloat = 40, footerHeight: CGFloat = 0) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero;
        layout.minimumLineSpacing = 0;
        layout.minimumInteritemSpacing = 0;
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = floor(screenWidth/4.0);
        let itemHeight = itemWidth*0.75;
        layout.itemSize = CGSize(width: round(itemWidth), height: itemHeight);
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 40);
        layout.footerReferenceSize = CGSize(width: screenWidth, height: 0);
        return layout;
    }
    /// [源]UICollectionView创建
    static func create(_ rect: CGRect = .zero, layout: UICollectionViewLayout = UICollectionView.layoutDefault()) -> Self{
        let view = self.init(frame: rect, collectionViewLayout: layout)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isPagingEnabled = true;

        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: UICollectionViewCell.identifier)
        view.backgroundColor = UIColor.background
        return view
    }
    
    var dictClass: [String: [String]] {
        get {
            return objc_getAssociatedObject(self, &AssociateKeys.dictClass) as! [String: [String]];
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.dictClass, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            registerCTVAll();
        }
    }
    
    /// dictClass注册
    func registerCTVAll() {
        if dictClass.keys.count == 0 {
            return
        }
        dictClass.forEach { (key, value) in
            if key == UICollectionView.elementKindSectionItem {
                registerCTVCell(value)
            } else {
                registerCTVReusable(value, kind: key)
            }
        }
    }
    
    /// cell注册
    func registerCTVCell(_ listClass: [String]) {
        listClass.forEach { (className) in
            register(NNClassFromString(className).self, forCellWithReuseIdentifier: className)
        }
    }
    
    /// 获取 UICollectionViewElementKindSection 标志
    func sectionReuseIdentifier(_ className: String, kind: String = UICollectionView.elementKindSectionHeader) -> String{
        let extra = kind == UICollectionView.elementKindSectionHeader ? "Header" : "Footer";
        let identifier = className + extra;
        return identifier;
    }
    
    /// headerView/FooterView注册
    func registerCTVReusable(_ listClass: [String], kind: String = UICollectionView.elementKindSectionHeader) {
        listClass.forEach { (className) in
            let identifier = sectionReuseIdentifier(className, kind: kind)
            register(NNClassFromString(className).self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
        }
    }
    
}


public extension UICollectionView{
    
    /// 泛型复用register cell - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UICollectionViewCell>(cellType: T.Type, forCellWithReuseIdentifier identifier: String = String(describing: T.self)){
        register(cellType.self, forCellWithReuseIdentifier: identifier)
    }
    
    /// 泛型复用register supplementaryView - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UICollectionReusableView>(supplementaryViewType: T.Type, ofKind elementKind: String = UICollectionView.elementKindSectionHeader){
        guard elementKind.contains("KindSection"), let kindSuf = elementKind.components(separatedBy: "KindSection").last else {
            return;
        }
        let identifier = String(describing: T.self) + kindSuf
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /// 泛型复用cell - cellType: "类名.self" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: UICollectionViewCell>(for cellType: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell as! T;
    }
    
    /// 泛型复用cell - aClass: "类名()" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: UICollectionViewCell>(for aClass: T, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        return dequeueReusableCell(for: T.self, identifier: identifier, indexPath: indexPath)
    }
    
    /// 泛型复用SupplementaryView - cellType: "类名.self" (默认identifier: 类名字符串 + Header/Footer)
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for cellType: T.Type, kind: String, indexPath: IndexPath) -> T{
        let kindSuf = kind.components(separatedBy: "KindSection").last;
        let identifier = String(describing: T.self) + kindSuf!;
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.lab.text = kindSuf! + "\(indexPath.section)";
        #if DEBUG
        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? .green : .yellow;
        #endif
        return view as! T;
    }
    
    /// 泛型复用SupplementaryView - aClass: "类名()" (默认identifier: 类名字符串 + Header/Footer)
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for aClass: T, kind: String, indexPath: IndexPath) -> T{
        return dequeueReusableSupplementaryView(for: T.self, kind: kind, indexPath: indexPath)
    }
    
}


