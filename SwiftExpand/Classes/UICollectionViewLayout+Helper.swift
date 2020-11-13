//
//  UICollectionViewLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension UICollectionViewFlowLayout{

    ///  默认布局配置(自上而下,自左而右)
    static func createFlowLayout(_ numOfRow: Int = 4,
                                 width: CGFloat = UIScreen.main.bounds.width,
                                 spacing: CGFloat = 10,
                                 headerHeight: CGFloat = 30,
                                 footerHeight: CGFloat = 30,
                                 sectionInset: UIEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)) -> UICollectionViewFlowLayout {
        //
        let layout = UICollectionViewFlowLayout();
        layout.sectionInset = sectionInset;
        layout.minimumLineSpacing = spacing;
        layout.minimumInteritemSpacing = spacing;

        let itemWidth = (width - (numOfRow.toCGFloat - 1)*spacing - sectionInset.left - sectionInset.right)/numOfRow.toCGFloat;
        let itemHeight = itemWidth/0.62;
        layout.itemSize = CGSize(width: round(itemWidth), height: itemHeight);
        layout.headerReferenceSize = CGSize(width: width, height: headerHeight);
        layout.footerReferenceSize = CGSize(width: width, height: footerHeight);
        return layout;
    }
    
    ///获取代理方法里的布局基础属性值
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
    
    
    func reloadItemSize(_ size: CGSize) {
        itemSize = size
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
    }
}
