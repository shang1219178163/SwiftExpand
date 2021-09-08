//
//  UICollectionViewCell+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/22.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UICollectionViewCell{
    
    /// [源]自定义 UICollectionViewCell 获取方法(兼容OC)
    static func dequeueReusableCell(_ collectionView: UICollectionView, identifier: String, indexPath: IndexPath) -> Self {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath)
        cell.backgroundColor = .white
        return cell as! Self
    }

    /// [OC简洁方法]自定义 UITableViewCell 获取方法
    static func dequeueReusableCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        return dequeueReusableCell(collectionView, identifier: String(describing: self), indexPath: indexPath)
    }
}
