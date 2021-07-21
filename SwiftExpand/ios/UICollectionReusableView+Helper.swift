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
    private struct AssociateKeys {
        static var imgView   = "UICollectionReusableView" + "imgView"
        static var lab       = "UICollectionReusableView" + "lab"
        static var labDetail = "UICollectionReusableView" + "labDetail"
        static var btn       = "UICollectionReusableView" + "btn"

    }
    
    /// [源]自定义 UICollectionReusableView 获取方法(兼容OC)
    static func dequeueSupplementaryView(_ collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> Self{

//        let kindSuf = kind.components(separatedBy: "KindSection").last
//        let identifier = String(describing: self) + kindSuf!
        let identifier = kind == UICollectionView.elementKindSectionHeader ? reuseIdentifierHeader : reuseIdentifierFooter
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.lab.text = identifier + "\(indexPath.section)"

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
 
    var imgView: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.imgView) as? UIImageView {
                return obj
            }

            let view = UIImageView(frame: CGRect.zero)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true
            view.contentMode = .scaleAspectFit
            view.backgroundColor = .clear

            objc_setAssociatedObject(self, &AssociateKeys.imgView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.imgView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
                
    var lab: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lab) as? UILabel {
                return obj
            }
            
            let view = UILabel(frame: .zero)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.font = UIFont.systemFont(ofSize: 15)
            view.numberOfLines = 0
            view.lineBreakMode = .byCharWrapping
            view.textAlignment = .center
//            view.backgroundColor = UIColor.random

            objc_setAssociatedObject(self, &AssociateKeys.lab, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lab, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var labDetail: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labDetail) as? UILabel {
                return obj
            }
            let view = UILabel(frame: .zero)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.numberOfLines = 1
            view.adjustsFontSizeToFitWidth = true
            view.textAlignment = .center
            
            objc_setAssociatedObject(self, &AssociateKeys.labDetail, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.labDetail, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }

    var btn: UIButton {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.btn) as? UIButton {
                return obj
            }
            
            let view = UIButton(type: .custom)
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            view.titleLabel?.adjustsFontSizeToFitWidth = true
            view.titleLabel?.minimumScaleFactor = 1.0
            view.isExclusiveTouch = true
            view.setTitleColor(.textColor3, for: .normal)
            view.setTitleColor(.theme, for: .selected)
            
            objc_setAssociatedObject(self, &AssociateKeys.btn, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.btn, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}
