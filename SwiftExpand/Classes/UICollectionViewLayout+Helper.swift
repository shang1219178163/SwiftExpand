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
    convenience init(_ numOfRow: Int = 4,
                     width: CGFloat = UIScreen.main.bounds.width,
                     spacing: CGFloat = 10,
                     headerHeight: CGFloat = 30,
                     footerHeight: CGFloat = 30,
                     sectionInset: UIEdgeInsets = .zero) {
        self.init()
        self.sectionInset = sectionInset;
        self.minimumLineSpacing = spacing;
        self.minimumInteritemSpacing = spacing;

        let itemWidth = (width - (numOfRow.toCGFloat - 1)*spacing - sectionInset.left - sectionInset.right)/numOfRow.toCGFloat;
        let itemHeight = itemWidth/0.62;
        self.itemSize = CGSize(width: round(itemWidth), height: itemHeight);
        self.headerReferenceSize = CGSize(width: width, height: headerHeight);
        self.footerReferenceSize = CGSize(width: width, height: footerHeight);
    }
    
    ///  默认布局配置(自上而下,自左而右)
    static func createFlowLayout(_ numOfRow: Int = 4,
                                 width: CGFloat = UIScreen.main.bounds.width,
                                 spacing: CGFloat = 10,
                                 headerHeight: CGFloat = 30,
                                 footerHeight: CGFloat = 30,
                                 sectionInset: UIEdgeInsets = .zero) -> UICollectionViewFlowLayout {
        return UICollectionViewFlowLayout.init(numOfRow,
                                               width: width,
                                               spacing: spacing,
                                               headerHeight: headerHeight,
                                               footerHeight: footerHeight,
                                               sectionInset: sectionInset)
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
    
    
    func reloadItemSize(_ numOfRow: Int = 4,
                        width: CGFloat = UIScreen.main.bounds.width,
                        spacing: CGFloat = 10,
                        sectionInset: UIEdgeInsets = .zero) {
        self.sectionInset = sectionInset;
        minimumLineSpacing = spacing;
        minimumInteritemSpacing = spacing;

        let itemWidth = (width - (numOfRow.toCGFloat - 1)*spacing - sectionInset.left - sectionInset.right)/numOfRow.toCGFloat;
        let itemHeight = itemWidth/0.62;
        let itemSize = CGSize(width: round(itemWidth), height: itemHeight);
        reloadItemSize(itemSize)
    }
    
    func reloadItemSize(_ size: CGSize) {
        itemSize = size
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
    }
}
