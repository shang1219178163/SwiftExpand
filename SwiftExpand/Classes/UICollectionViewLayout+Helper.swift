//
//  UICollectionViewLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension UICollectionViewLayout{
    
    private struct AssociateKeys {
        static var minimumLineSpacing      = "UICollectionViewLayout" + "minimumLineSpacing"
        static var minimumInteritemSpacing = "UICollectionViewLayout" + "minimumInteritemSpacing"
        static var itemSize                = "UICollectionViewLayout" + "itemSize"
        static var headerReferenceSize     = "UICollectionViewLayout" + "headerReferenceSize"
        static var footerReferenceSize     = "UICollectionViewLayout" + "footerReferenceSize"
        static var sectionInset            = "UICollectionViewLayout" + "sectionInset"
    }
    
    /// 仿 flowLayout
    var minimumLineSpacing: CGFloat {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.minimumLineSpacing) as? CGFloat {
                return obj
            }
            return 5.0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.minimumLineSpacing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 仿 flowLayout
    var minimumInteritemSpacing: CGFloat {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.minimumInteritemSpacing) as? CGFloat {
                return obj
            }
            return 5.0
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.minimumInteritemSpacing, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 仿 flowLayout
    var itemSize: CGSize {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.itemSize) as? CGSize {
                return obj
            }
            return CGSize.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.itemSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 仿 flowLayout
    var headerReferenceSize: CGSize {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.headerReferenceSize) as? CGSize {
                return obj
            }
            return CGSize.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.headerReferenceSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 仿 flowLayout
    var footerReferenceSize: CGSize {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.footerReferenceSize) as? CGSize {
                return obj
            }
            return CGSize.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.footerReferenceSize, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 仿 flowLayout
    var sectionInset: UIEdgeInsets {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.sectionInset) as? UIEdgeInsets {
                return obj
            }
            return UIEdgeInsets.zero
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.sectionInset, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
   
    /// 默认布局配置(自上而下,自左而右)
    static func createLayout(_ itemSize: CGSize,
                                   spacing: CGFloat = kPadding,
                                   headerSize: CGSize,
                                   footerSize: CGSize,
                                   sectionInset: UIEdgeInsets = .zero) -> UICollectionViewLayout {
        let layout = UICollectionViewLayout();
        //item水平间距
        layout.minimumLineSpacing = spacing;
        //item垂直间距
        layout.minimumInteritemSpacing = spacing;
        //item的UIEdgeInsets
        layout.sectionInset = sectionInset;
        //item的尺寸
        layout.itemSize = itemSize;
        //滑动方向,默认垂直
        //sectionView 尺寸
        layout.headerReferenceSize = headerSize;
        layout.footerReferenceSize = footerSize;
        return layout;
    }
}

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
}
