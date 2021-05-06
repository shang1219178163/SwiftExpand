//
//  UICollectionViewLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension UICollectionViewFlowLayout{

    func minimumLineSpacingChain(_ minimumLineSpacing: CGFloat) -> Self {
        self.minimumLineSpacing = minimumLineSpacing
        return self
    }

    func minimumInteritemSpacingChain(_ minimumInteritemSpacing: CGFloat) -> Self {
        self.minimumInteritemSpacing = minimumInteritemSpacing
        return self
    }

    func itemSizeChain(_ itemSize: CGSize) -> Self {
        self.itemSize = itemSize
        return self
    }

    // defaults to CGSizeZero - setting a non-zero size enables cells that self-size via -preferredLayoutAttributesFittingAttributes:
    @available(iOS 8.0, *)
    func estimatedItemSizeChain(_ estimatedItemSize: CGSize) -> Self {
        self.estimatedItemSize = estimatedItemSize
        return self
    }

    // default is UICollectionViewScrollDirectionVertical
    func scrollDirectionChain(_ scrollDirection: UICollectionView.ScrollDirection) -> Self {
        self.scrollDirection = scrollDirection
        return self
    }

    func headerReferenceSizeChain(_ headerReferenceSize: CGSize) -> Self {
        self.headerReferenceSize = headerReferenceSize
        return self
    }

    func footerReferenceSizeChain(_ footerReferenceSize: CGSize) -> Self {
        self.footerReferenceSize = footerReferenceSize
        return self
    }

    func sectionInsetChain(_ sectionInset: UIEdgeInsets) -> Self {
        self.sectionInset = sectionInset
        return self
    }

    @available(iOS 11.0, *)
    func sectionInsetReferenceChain(_ sectionInsetReference: UICollectionViewFlowLayout.SectionInsetReference) -> Self {
        self.sectionInsetReference = sectionInsetReference
        return self
    }

    @available(iOS 9.0, *)
    func sectionHeadersPinToVisibleBoundsChain(_ sectionHeadersPinToVisibleBounds: Bool) -> Self {
        self.sectionHeadersPinToVisibleBounds = sectionHeadersPinToVisibleBounds
        return self
    }

    @available(iOS 9.0, *)
    func sectionFootersPinToVisibleBoundsChain(_ sectionFootersPinToVisibleBounds: Bool) -> Self {
        self.sectionFootersPinToVisibleBounds = sectionFootersPinToVisibleBounds
        return self
    }

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
    
    
    func reloadItemSize(_ size: CGSize) {
        itemSize = size
        guard let collectionView = collectionView else { return }
        collectionView.reloadData()
    }
}
