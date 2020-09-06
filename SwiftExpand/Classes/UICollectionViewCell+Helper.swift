//
//  UICollectionViewCell+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/22.
//

import UIKit

@objc public extension UICollectionViewCell{
    
    /// [源]自定义 UICollectionViewCell 获取方法(兼容OC)
    static func dequeueReusableCell(_ collectionView: UICollectionView, indexPath: IndexPath) -> Self {
        let view = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: self), for: indexPath)
        return view as! Self
    }

 
}
