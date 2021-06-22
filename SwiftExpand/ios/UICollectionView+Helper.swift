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
    
    static let elementKindSectionItem: String = "UICollectionView.elementKindSectionItem"
    static let sectionKindBackgroud: String = "UICollectionView.sectiinKindBackgroud"

    /// 默认流水布局
    static func layoutDefault(_ headerHeight: CGFloat = 40, footerHeight: CGFloat = 0) -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = .zero
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let screenWidth = UIScreen.main.bounds.width
        
        let itemWidth = floor(screenWidth/4.0)
        let itemHeight = itemWidth*0.75
        layout.itemSize = CGSize(width: round(itemWidth), height: itemHeight)
        layout.headerReferenceSize = CGSize(width: screenWidth, height: 40)
        layout.footerReferenceSize = CGSize(width: screenWidth, height: 0)
        return layout
    }
    /// [源]UICollectionView创建
    static func create(_ rect: CGRect = .zero, layout: UICollectionViewLayout = UICollectionView.layoutDefault()) -> Self{
        let view = self.init(frame: rect, collectionViewLayout: layout)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isPagingEnabled = true

        view.register(UICollectionViewCell.self, forCellWithReuseIdentifier: String(describing: self))
        view.backgroundColor = UIColor.background
        return view
    }
            
    var dictClass: [String: [String]] {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.dictClass) as? [String: [String]] {
                return obj
            }
            return [String: [String]]()
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.dictClass, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            registerReuseIdentifier(newValue)
        }
    }
    
    /// dictClass注册
    /// - Parameter dictClass: key(UICollectionView.elementKindSectionItem/UICollectionView.elementKindSectionHeader/UICollectionView.elementKindSectionFooter)
    /// - Parameter dictClass: Value(["UICollectionViewCell", ])
    func registerReuseIdentifier(_ dictClass: [String: [String]]) {
        dictClass.forEach { (key, value) in
            registerReuseIdentifier(key, list: value)
        }
    }
    
    /// 注册 cell
    /// - Parameters:
    ///   - kind: UICollectionView.elementKindSectionItem/UICollectionView.elementKindSectionHeader/UICollectionView.elementKindSectionFooter
    ///   - list: ["UICollectionViewCell", ]
    func registerReuseIdentifier(_ kind: String = UICollectionView.elementKindSectionHeader, list: [String]) {
        list.forEach { className in
            if kind == UICollectionView.elementKindSectionItem {
                register(NNClassFromString(className).self, forCellWithReuseIdentifier: className)
            } else {
                let identifier = className + (kind == UICollectionView.elementKindSectionHeader ? "Header" : "Footer")
                register(NNClassFromString(className).self, forSupplementaryViewOfKind: kind, withReuseIdentifier: identifier)
            }
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
            return
        }
        let identifier = String(describing: T.self) + kindSuf
        register(supplementaryViewType.self, forSupplementaryViewOfKind: elementKind, withReuseIdentifier: identifier)
    }
    
    /// 泛型复用cell - cellType: "类名.self" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: UICollectionViewCell>(for cellType: T.Type, identifier: String = String(describing: T.self), indexPath: IndexPath) -> T{
        let cell = self.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell as! T
    }
    
    /// 泛型复用SupplementaryView - cellType: "类名.self" (默认identifier: 类名字符串 + Header/Footer)
    final func dequeueReusableSupplementaryView<T: UICollectionReusableView>(for cellType: T.Type, kind: String, indexPath: IndexPath) -> T{
        let kindSuf = kind.components(separatedBy: "KindSection").last
        let identifier = String(describing: T.self) + kindSuf!
        let view = self.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.lab.text = kindSuf! + "\(indexPath.section)"
        #if DEBUG
        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? .green : .yellow
        #endif
        return view as! T
    }
    
}


