//
//  UITableHeaderFooterView+Add.swift
//  BuildUI
//
//  Created by Bin Shang on 2018/12/20.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UITableViewHeaderFooterView{
    
//    private struct AssociateKeys {
//        static var indicatorView = "UITableViewHeaderFooterView" + "indicatorView"
//        static var imgViewLeft   = "UITableViewHeaderFooterView" + "imgViewLeft"
//        static var imgViewRight  = "UITableViewHeaderFooterView" + "imgViewRight"
//        static var labelLeft     = "UITableViewHeaderFooterView" + "labelLeft"
//        static var labelLeftSub  = "UITableViewHeaderFooterView" + "labelLeftSub"
//        static var labelRight    = "UITableViewHeaderFooterView" + "labelRight"
//        static var labelRightSub = "UITableViewHeaderFooterView" + "labelRightSub"
//        static var btn           = "UITableViewHeaderFooterView" + "btn"
//        static var textfield     = "UITableViewHeaderFooterView" + "textfield"
//        static var isOpen        = "UITableViewHeaderFooterView" + "isOpen"
//        static var isCanOpen     = "UITableViewHeaderFooterView" + "isCanOpen"
//    }
    
    /// [源]自定义 UITableViewHeaderFooterView 获取方法(兼容OC)
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView, identifier: String) -> Self {
        let view = tableView.dequeueReusableHeaderFooterView(withIdentifier: identifier) ?? self.init(reuseIdentifier: identifier)
        view.contentView.lineTop.isHidden = false
        view.contentView.lineBottom.isHidden = false
        return view as! Self
    }
    
    /// [OC简洁方法]自定义 UITableViewHeaderFooterView 获取方法
    static func dequeueReusableHeaderFooterView(_ tableView: UITableView) -> Self {
        return dequeueReusableHeaderFooterView(tableView, identifier: String(describing: self))
    }
    
//
//    var indicatorView: UIImageView {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.indicatorView) as? UIImageView {
//                return obj
//            }
//
//            let view = UIImageView(frame: .zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.isUserInteractionEnabled = true
//            view.contentMode = .scaleAspectFit
//            view.backgroundColor = .clear
//
//            objc_setAssociatedObject(self, &AssociateKeys.indicatorView, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.indicatorView, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var imgViewLeft: UIImageView {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.imgViewLeft) as? UIImageView {
//                return obj
//            }
//
//            let view = UIImageView(frame: .zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.isUserInteractionEnabled = true
//            view.contentMode = .scaleAspectFit
//            view.backgroundColor = .clear
//
//            objc_setAssociatedObject(self, &AssociateKeys.imgViewLeft, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.imgViewLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var imgViewRight: UIImageView {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.imgViewRight) as? UIImageView {
//                return obj
//            }
//
//            let view = UIImageView(frame: .zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.isUserInteractionEnabled = true
//            view.contentMode = .scaleAspectFit
//            view.backgroundColor = .clear
//            view.image = UIImage(named: "img_arrowRight_gray")
//
//            objc_setAssociatedObject(self, &AssociateKeys.imgViewRight, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.imgViewRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var labelLeft: UILabel {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelLeft) as? UILabel {
//                return obj
//            }
//
//            let view = UILabel(frame: CGRect.zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.textAlignment = .left
//            view.numberOfLines = 0
//            view.lineBreakMode = .byCharWrapping
//
//            objc_setAssociatedObject(self, &AssociateKeys.labelLeft, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.labelLeft, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var labelLeftSub: UILabel {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelLeftSub) as? UILabel {
//                return obj
//            }
//
//            let view = UILabel(frame: CGRect.zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.textAlignment = .left
//            view.numberOfLines = 0
//            view.lineBreakMode = .byCharWrapping
//            view.font = UIFont.systemFont(ofSize: UIFont.labelFontSize - 2.0)
//
//            objc_setAssociatedObject(self, &AssociateKeys.labelLeftSub, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.labelLeftSub, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var labelRight: UILabel {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.labelRight) as? UILabel {
//                return obj
//            }
//
//            let view = UILabel(frame: CGRect.zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.textAlignment = .left
//            view.numberOfLines = 0
//            view.lineBreakMode = .byCharWrapping
//
//            objc_setAssociatedObject(self, &AssociateKeys.labelRight, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.labelRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var btn: UIButton {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.btn) as? UIButton {
//                return obj
//            }
//
//            let view = UIButton(type: .custom)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.titleLabel?.adjustsFontSizeToFitWidth = true
//            view.titleLabel?.minimumScaleFactor = 1.0
//            view.isExclusiveTouch = true
//            view.setTitleColor(.black, for: .normal)
//
//            objc_setAssociatedObject(self, &AssociateKeys.btn, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.btn, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var textfield: UITextField {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.textfield) as? UITextField {
//                return obj
//            }
//
//            let view = UITextField(frame: .zero)
//            view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//            view.textAlignment = .left
//            view.contentVerticalAlignment = .center
//            view.autocapitalizationType = .none
//            view.autocorrectionType = .no
//            view.clearButtonMode = .whileEditing
//            view.backgroundColor = .white
//
//            objc_setAssociatedObject(self, &AssociateKeys.textfield, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//            return view
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.textfield, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var isOpen: Bool {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.isOpen) as? Bool {
//                return obj
//            }
//            return false
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.isOpen, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
//
//    var isCanOpen: Bool {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.isCanOpen) as? Bool {
//                return obj
//            }
//            return false
//        }
//        set {
//            objc_setAssociatedObject(self, &AssociateKeys.isCanOpen, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
//        }
//    }
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
