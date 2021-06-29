//
//  UICollectionViewLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension UICollectionViewFlowLayout{

    /// 默认布局配置(自上而下,自左而右)
    convenience init(numOfRow: Int = 4, width: CGFloat = UIScreen.main.bounds.width, heightScale: CGFloat = 1.3, spacing: CGFloat = 10, headerHeight: CGFloat = 30, footerHeight: CGFloat = 30, sectionInset: UIEdgeInsets = .zero) {
        self.init()
        self.minimumInteritemSpacing = spacing
        self.minimumLineSpacing = spacing
        self.sectionInset = sectionInset

        let itemWidth = (width - (numOfRow.toCGFloat - 1)*spacing - sectionInset.left - sectionInset.right)/numOfRow.toCGFloat
        self.itemSize = CGSize(width: round(itemWidth) - 2, height: itemWidth * heightScale)
        self.headerReferenceSize = CGSize(width: width, height: headerHeight)
        self.footerReferenceSize = CGSize(width: width, height: footerHeight)
    }
        
    /// 默认布局配置(自上而下,自左而右)
    static func createFlowLayout(_ numOfRow: Int = 4, width: CGFloat = UIScreen.main.bounds.width, heightScale: CGFloat = 1.3, spacing: CGFloat = 10, headerHeight: CGFloat = 30, footerHeight: CGFloat = 30, sectionInset: UIEdgeInsets = .zero) -> UICollectionViewFlowLayout {
        return UICollectionViewFlowLayout.init(numOfRow: numOfRow,
                                               width: width,
                                               heightScale: heightScale,
                                               spacing: spacing,
                                               headerHeight: headerHeight,
                                               footerHeight: footerHeight,
                                               sectionInset: sectionInset)
    }
    
    /// 获取代理方法里的布局基础属性值
    func refreshValueFromDelegate(_ indexPath: IndexPath) {
        if let collectionView = collectionView, let delegate = collectionView.delegate {
            if delegate.conforms(to: UICollectionViewDelegateFlowLayout.self) == true {
                if let flowDelegate: UICollectionViewDelegateFlowLayout = delegate as? UICollectionViewDelegateFlowLayout{
                    if let value = flowDelegate.collectionView?(collectionView, layout: self, minimumLineSpacingForSectionAt: indexPath.section) as CGFloat? {
                        minimumLineSpacing = value
                    }
                    
                    if let inset = flowDelegate.collectionView?(collectionView, layout: self, minimumInteritemSpacingForSectionAt: indexPath.section) as CGFloat? {
                        minimumInteritemSpacing = inset
                    }
                    
                    if let inset = flowDelegate.collectionView?(collectionView, layout: self, insetForSectionAt: indexPath.section) as UIEdgeInsets? {
                        sectionInset = inset
                    }
                    
                    if let size = flowDelegate.collectionView?(collectionView, layout: self, referenceSizeForHeaderInSection: indexPath.section) as CGSize? {
                        headerReferenceSize = size
                    }
                    
                    if let size = flowDelegate.collectionView?(collectionView, layout: self, referenceSizeForFooterInSection: indexPath.section) as CGSize? {
                        footerReferenceSize = size
                    }
                }
            }
        }
    }
    
    func reloadItemSize(_ numOfRow: Int = 4, width: CGFloat = UIScreen.main.bounds.width, heightScale: CGFloat = 1.6, minimumInteritemSpacing: CGFloat = 8, sectionInset: UIEdgeInsets = .zero) {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        self.sectionInset = sectionInset

        let itemWidth = (width - (numOfRow.toCGFloat - 1) * minimumInteritemSpacing - sectionInset.left - sectionInset.right)/numOfRow.toCGFloat
        let itemSize = CGSize(width: round(itemWidth) - 2, height: itemWidth * heightScale)
        reloadItemSize(itemSize)
    }
    
    func reloadItemSize(_ size: CGSize) {
        itemSize = size
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
    }
    
}
