
//
//  UITableViewCell+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UITableViewCell{
    private struct AssociateKeys {
        static var imgViewLeft   = "UITableViewCell" + "imgViewLeft"
        static var imgViewRight  = "UITableViewCell" + "imgViewRight"
        static var labelLeft     = "UITableViewCell" + "labelLeft"
        static var labelLeftSub  = "UITableViewCell" + "labelLeftSub"
        static var labelRight    = "UITableViewCell" + "labelRight"
        static var labelRightSub = "UITableViewCell" + "labelRightSub"
        static var btn           = "UITableViewCell" + "btn"
        static var textfield     = "UITableViewCell" + "textfield"
        static var textView      = "UITableViewCell" + "textView"
    }
    /// [源]自定义 UITableViewCell 获取方法(兼容OC)
    static func dequeueReusableCell(_ tableView: UITableView, identifier: String = String(describing: self), style: UITableViewCell.CellStyle = .default) -> Self {
        var cell = tableView.dequeueReusableCell(withIdentifier: identifier);
        if cell == nil {
            cell = self.init(style: style, reuseIdentifier: identifier);
        }

        cell!.selectionStyle = .none;
        cell!.separatorInset = .zero;
        cell!.layoutMargins = .zero;
        return cell as! Self;
    }
    
    /// [OC简洁方法]自定义 UITableViewCell 获取方法
    static func dequeueReusableCell(_ tableView: UITableView) -> Self {
        return dequeueReusableCell(tableView, identifier: String(describing: self), style: .default)
    }
    
    ///调整AccessoryView位置(默认垂直居中)
    func positionAccessoryView(_ dx: CGFloat = 0, dy: CGFloat = 0) {
        var accessory: UIView?
        if let accessoryView = self.accessoryView {
            accessory = accessoryView
        } else if self.accessoryType != .none {
            for subview in self.subviews {
                if subview != self.textLabel && subview != self.detailTextLabel
                    && subview != self.backgroundView  && subview != self.selectedBackgroundView
                    && subview != self.imageView && subview != self.contentView
                    && subview.isKind(of: UIButton.self) {
                    accessory = subview
                    break
                }
            }
        }
        
        if accessory != nil {
            accessory!.center = CGPoint(x: accessory!.center.x + dx, y: self.bounds.midY + dy)
        }
    }
        
    var imgViewLeft: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.imgViewLeft) as? UIImageView {
                return obj
            }

            let view = UIImageView(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true;
            view.contentMode = .scaleAspectFit;
            view.backgroundColor = .clear

            objc_setAssociatedObject(self, &AssociateKeys.imgViewLeft, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.imgViewLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var imgViewRight: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.imgViewRight) as? UIImageView {
                return obj
            }

            let view = UIImageView(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true;
            view.contentMode = .scaleAspectFit;
            view.backgroundColor = .clear
            view.image = UIImage(named: kIMG_arrowRight);
            
            objc_setAssociatedObject(self, &AssociateKeys.imgViewRight, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.imgViewRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labelLeft: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelLeft) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            
            objc_setAssociatedObject(self, &AssociateKeys.labelLeft, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.labelLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
  
    var labelLeftSub: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelLeftSub) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            view.font = UIFont.systemFont(ofSize: UIFont.labelFontSize - 2.0);
            
            objc_setAssociatedObject(self, &AssociateKeys.labelLeftSub, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.labelLeftSub, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labelRight: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelRight) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            
            objc_setAssociatedObject(self, &AssociateKeys.labelRight, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.labelRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labelRightSub: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelRightSub) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.font = UIFont.systemFont(ofSize: 15);
            view.textAlignment = .right;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            view.font = UIFont.systemFont(ofSize: UIFont.labelFontSize - 2.0);
            view.isUserInteractionEnabled = true;
            
            
            objc_setAssociatedObject(self, &AssociateKeys.labelRightSub, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.labelRightSub, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var btn: UIButton {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.btn) as? UIButton {
                return obj;
            }
            
            let view = UIButton(type: .custom);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.titleLabel?.adjustsFontSizeToFitWidth = true;
            view.titleLabel?.minimumScaleFactor = 1.0;
            view.isExclusiveTouch = true;
            view.adjustsImageWhenHighlighted = false;
            view.setTitleColor(.black, for: .normal)
            
            objc_setAssociatedObject(self, &AssociateKeys.btn, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.btn, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textfield: UITextField {
        get {
             if let obj = objc_getAssociatedObject(self, &AssociateKeys.textfield) as? UITextField {
                 return obj
             }
    
             let view = UITextField(frame: .zero);
             view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
             view.textAlignment = .left;
             view.contentVerticalAlignment = .center;
             view.autocapitalizationType = .none;
             view.autocorrectionType = .no;
             view.clearButtonMode = .whileEditing;
             view.backgroundColor = .white;
             
             objc_setAssociatedObject(self, &AssociateKeys.textfield, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.textfield, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textView: UITextView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.textView) as? UITextView {
                return obj
            }
            
            let view = UITextView(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.font = UIFont.systemFont(ofSize: 15);
            view.textAlignment = .left;
            view.autocapitalizationType = .none;
            view.autocorrectionType = .no;
            view.backgroundColor = .white;
            
            view.layer.borderColor = UIColor.lightGray.cgColor
            view.layer.borderWidth = 0.5
            
            objc_setAssociatedObject(self, &AssociateKeys.textView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.textView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

public extension UITableViewCell{

    ///设置accessoryView 为 UIView
    @discardableResult
    final func assoryView<T: UIView>(_ type: T.Type, size: CGSize = CGSize(width: 80, height: 30), block:((T)->Void)? = nil) -> T {
        if let accessoryView = accessoryView as? T {
            return accessoryView
        }
        let view = type.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        block?(view)
        accessoryView = view
        return view
    }
}
