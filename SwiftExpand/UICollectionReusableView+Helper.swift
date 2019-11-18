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
    /// 表头值
    static var identifyHeader: String {
        return String(describing: self) + "Header";
     }
    /// 表尾值
    static var identifyFooter: String {
        return String(describing: self) + "Footer";
     }
 
    var imageView: UIImageView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIImageView;
            if obj == nil {
                obj = UIImageView(frame: CGRect.zero);
                obj!.autoresizingMask = [.flexibleWidth, .flexibleHeight]

                obj!.isUserInteractionEnabled = true;
                obj!.contentMode = .scaleAspectFit;
                obj!.backgroundColor = UIColor.random

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var imageViewRight: UIImageView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIImageView;
            if obj == nil {
                obj = UIImageView(frame: CGRect.zero);
                obj!.autoresizingMask = [.flexibleWidth, .flexibleHeight]

                obj!.isUserInteractionEnabled = true;
                obj!.contentMode = .scaleAspectFit;
                obj!.image = UIImage(named: kIMG_arrowRight);
                obj!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textLabel: UILabel {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UILabel;
            if obj == nil {
                obj = UILabel(frame: CGRect.zero);
                obj!.autoresizingMask = [.flexibleWidth, .flexibleHeight]

                obj!.numberOfLines = 2;
                obj!.lineBreakMode = .byCharWrapping;
                obj!.textAlignment = .left;
                obj!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textLabelRight: UILabel {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UILabel;
            if obj == nil {
                obj = UILabel(frame: CGRect.zero);
                obj!.autoresizingMask = [.flexibleWidth, .flexibleHeight]

                obj!.numberOfLines = 1;
                obj!.adjustsFontSizeToFitWidth = true
                obj!.textAlignment = .center;
                obj!.backgroundColor = UIColor.random
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
                
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}
