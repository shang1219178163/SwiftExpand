//
//  UICollectionReusableView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/22.
//


/*
 UICollectionViewCell继承于UICollectionReusableView,所以两者属性,方法不能同名
 */


import UIKit

extension UICollectionReusableView{
 
    @objc public static var identifier: String {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? String;
            if obj == nil {
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            obj = NStringShortFromClass(classForCoder());
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    ///获取UICollectionReusableView
    @objc public static func dequeueCTVReusable(_ collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> UICollectionReusableView{
        
        let kindSuf = kind.components(separatedBy: "KindSection").last;
        let identifier = NStringShortFromClass(classForCoder()) + kindSuf!;
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.textLabel.text = kindSuf! + "\(indexPath.section)";
        
        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? UIColor.green : UIColor.yellow;
        return view;
    }
    
//    @objc public static func dequeueCTVReusable(_ collectionView: UICollectionView, indexPath: IndexPath) -> UICollectionReusableView{
//        return dequeueCTVReusable(collectionView, kind: UICollectionElementKindSectionItem, indexPath: indexPath);
//    }

    @objc public var imageView: UIImageView {
        get {
            var view = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIImageView;
            if view == nil {
                view = UIImageView(frame: .zero);
                view!.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)

                view!.isUserInteractionEnabled = true;
                view!.contentMode = .scaleAspectFit;
                view!.backgroundColor = UIColor.random

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return view!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc public var imageViewRight: UIImageView {
        get {
            var view = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIImageView;
            if view == nil {
                view = UIImageView(frame: .zero);
                view!.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)

                view!.isUserInteractionEnabled = true;
                view!.contentMode = .scaleAspectFit;
                view!.image = UIImage(named: kIMG_arrowRight);
                view!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return view!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc public var textLabel: UILabel {
        get {
            var view = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UILabel;
            if view == nil {
                view = UILabel(frame: .zero);
                view!.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)

                view!.numberOfLines = 2;
                view!.lineBreakMode = .byCharWrapping;
                view!.textAlignment = .left;
                view!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return view!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    @objc public var textLabelRight: UILabel {
        get {
            var view = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UILabel;
            if view == nil {
                view = UILabel(frame: .zero);
                view!.autoresizingMask = UIView.AutoresizingMask(rawValue: UIView.AutoresizingMask.flexibleWidth.rawValue | UIView.AutoresizingMask.flexibleHeight.rawValue)

                view!.numberOfLines = 1;
                view!.adjustsFontSizeToFitWidth = true
                view!.textAlignment = .center;
                view!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return view!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
