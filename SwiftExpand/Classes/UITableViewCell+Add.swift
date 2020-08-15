
//
//  UITableViewCell+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UITableViewCell{
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
        
    var imgViewLeft: UIImageView {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIImageView {
                return obj
            }

            let view = UIImageView(frame: .zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.isUserInteractionEnabled = true;
            view.contentMode = .scaleAspectFit;
            
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
                return obj
            }

            let view = UIImageView(frame: .zero);
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
    
    var labelLeft: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
  
    var labelLeftSub: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            view.font = UIFont.systemFont(ofSize: UIFont.labelFontSize - 2.0);
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labelRight: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
                return obj
            }

            let view = UILabel(frame: CGRect.zero);
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            view.textAlignment = .left;
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var labelRightSub: UILabel {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UILabel {
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
            view.titleLabel?.adjustsFontSizeToFitWidth = true;
            view.titleLabel?.minimumScaleFactor = 1.0;
            view.isExclusiveTouch = true;
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textfield: UITextField {
        get {
             if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UITextField {
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
             
             objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
             return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var textView: UITextView {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UITextView {
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
            
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return view
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
}

public extension UITableViewCell{

    ///设置accessoryView 为 UIButton
    final func assoryBtn<T: UIButton>(_ type: T.Type) -> T {
        assoryView(type)
    }
    ///设置accessoryView 为 UIView
    final func assoryView<T: UIView>(_ type: T.Type) -> T {
        if let accessoryView = accessoryView, accessoryView.isKind(of: type) {
            return accessoryView as! T;
        }
        
        let sender: T = {
            let view: T = {
                let view = type.init(frame: .zero)
                view.frame = CGRect(x: 0, y: 0, width: 80, height: 30)
                return view
            }()
            accessoryView = view
            return view
        }()
        return sender
    }
}
