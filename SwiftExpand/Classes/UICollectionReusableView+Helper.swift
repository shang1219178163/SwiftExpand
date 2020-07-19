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

@objc public extension UICollectionReusableView{
    /// [源]自定义 UICollectionReusableView 获取方法(兼容OC)
    static func dequeueSupplementaryView(_ collectionView: UICollectionView, kind: String = UICollectionView.elementKindSectionHeader, indexPath: IndexPath) -> Self{

//        let kindSuf = kind.components(separatedBy: "KindSection").last;
//        let identifier = self.identifier + kindSuf!;
        let identifier = kind == UICollectionView.elementKindSectionHeader ? identifyHeader : identifyFooter;
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        view.lab.text = identifier + "\(indexPath.section)";

        view.backgroundColor = kind == UICollectionView.elementKindSectionHeader ? UIColor.green : UIColor.yellow;
        return view as! Self;
    }
    
    /// 表头值
    static var identifyHeader: String {
        return String(describing: self) + "Header";
     }
    /// 表尾值
    static var identifyFooter: String {
        return String(describing: self) + "Footer";
     }
 
    var imgView: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIImageView {
                return obj;
            }

            let view = UIImageView(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true;
            view.contentMode = .scaleAspectFit;
//             view.backgroundColor = UIColor.random

            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var imgViewRight: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIImageView {
                return obj;
            }

            let view = UIImageView(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true;
            view.contentMode = .scaleAspectFit;
            view.image = UIImage(named: kIMG_arrowRight);
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
            
    var labRight: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj;
            }
            let view = UILabel(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.numberOfLines = 1;
            view.adjustsFontSizeToFitWidth = true
            view.textAlignment = .center;
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var lab: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj;
            }
            
            let view = UILabel(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.font = UIFont.systemFont(ofSize: 15)
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            view.textAlignment = .center;
//                obj!.backgroundColor = UIColor.random

            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labSub: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj;
            }
            
            let view = UILabel(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.font = UIFont.systemFont(ofSize: 13)
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            view.textAlignment = .center;
//                obj!.backgroundColor = UIColor.random

            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var btn: UIButton {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIButton {
                return obj;
            }
            
            let view = UIButton(type: .custom);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.titleLabel?.font = UIFont.systemFont(ofSize: 15);
            view.titleLabel?.adjustsFontSizeToFitWidth = true;
            view.titleLabel?.minimumScaleFactor = 1.0;
            view.isExclusiveTouch = true;
            view.setTitleColor(.textColor3, for: .normal)
            view.setTitleColor(.theme, for: .selected)
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
