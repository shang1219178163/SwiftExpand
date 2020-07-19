//
//  UITableHeaderFooterView+Add.swift
//  BuildUI
//
//  Created by Bin Shang on 2018/12/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UITableViewHeaderFooterView{
    /// [源]自定义 UITableViewHeaderFooterView 获取方法(兼容OC)
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView, identifier: String = String(describing: self)) -> Self {
        var view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
        if view == nil {
            view = self.init(reuseIdentifier: identifier)
        }
      
        view!.contentView.lineTop.isHidden = false
        view!.contentView.lineBottom.isHidden = false
        return view as! Self;
    }
    
    /// [OC简洁方法]自定义 UITableViewHeaderFooterView 获取方法
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView) -> Self {
        return dequeueReusableHeaderFooterView(tableView, identifier: String(describing: self))
    }
    
    /// UITableViewHeaderFooterView -源方法生成,自定义identifier
//    static func viewWithTableView(_ tableView: UITableView, identifier: String = identifier) -> UITableViewHeaderFooterView! {
//        var obj = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier)
//        if obj == nil {
//            obj = self.init(reuseIdentifier: identifier)
//        }
//
//        obj!.contentView.lineTop.isHidden = false
//        obj!.contentView.lineBottom.isHidden = false
//        return obj!;
//    }
    
    var indicatorView: UIImageView {
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
    
    var isOpen: Bool {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? Bool {
                return obj
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var isCanOpen: Bool {
        get {
            if let obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? Bool {
                return obj
            }
            return false
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
}

@objcMembers public class NNFoldSectionModel: NSObject{
    public var title = "标题"
    public var titleSub = "子标题"
    public var image = "图片名称"
    public var isOpen = false
    public var isCanOpen = false
    public var headerHeight: CGFloat = 10.0
    public var footerHeight: CGFloat = 0.01
    public var headerColor: UIColor = .background
    public var footerColor: UIColor = .background
    public var sectionModel: AnyObject?

    public var dataList: [Any] = []
//    public var dataList: NSMutableArray = []
    public var cellList: NSMutableArray = []
}
