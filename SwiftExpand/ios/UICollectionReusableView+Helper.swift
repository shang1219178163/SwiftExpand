//
//  UICollectionReusableView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/22.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

/*
 UICollectionViewCell继承于UICollectionReusableView,所以两者属性,方法不能同名
 */

import UIKit


@objc public extension UICollectionReusableView{

    /// [源]自定义 UICollectionReusableView 获取方法(兼容OC)
    static func dequeueSupplementaryView(_ collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> Self{

//        let kindSuf = kind.components(separatedBy: "KindSection").last
//        let identifier = String(describing: self) + kindSuf!
        let identifier = kind == UICollectionView.elementKindSectionHeader ? reuseIdentifierHeader : reuseIdentifierFooter
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
//        view.lab.text = identifier + "\(indexPath.section)"

        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? UIColor.green : UIColor.yellow
        return view as! Self
    }
    
    /// 表头值
    static var reuseIdentifierHeader: String {
        return String(describing: self) + "Header"
     }
    /// 表尾值
    static var reuseIdentifierFooter: String {
        return String(describing: self) + "Footer"
     }
 
}
