//
//  UIAlertController+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/12.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit
import Foundation

/// UIAlertController标题富文本key
public let kAlertTitle = "attributedTitle"
/// UIAlertController信息富文本key
public let kAlertMessage = "attributedMessage"
/// UIAlertController信息富文本key
public let kAlertContentViewController = "contentViewController"
/// UIAlertController按钮颜色key
public let kAlertActionColor = "titleTextColor"
/// UIAlertController按钮颜色image
public let kAlertActionImage = "image"
/// UIAlertController按钮颜色imageTintColor
public let kAlertActionImageTintColor = "imageTintColor"
/// UIAlertController按钮 checkmark
public let kAlertActionChecked = "checked"

@objc public extension UIAlertController{
    
    private var subView5: UIView? {
        guard let subView1: UIView = self.view.subviews.first,
              let subView2: UIView = subView1.subviews.first,
              let subView3: UIView = subView2.subviews.first,
              let subView4: UIView = subView3.subviews.first,
              let subView5: UIView = subView4.subviews.first
              else { return nil }
        return subView5
    }
    
    var titleLabel: UILabel? {
        guard let _ = self.title,
              let subView5 = subView5,
              subView5.subviews.count > 2,
              let label = subView5.subviews[1] as? UILabel
              else { return nil }
        return label
    }
    
    var messageLabel: UILabel? {
        guard let subView5 = subView5
              else { return nil }
        let messageLabelIndex = self.title == nil ? 1 : 2
        if subView5.subviews.count > messageLabelIndex,
           let label = subView5.subviews[messageLabelIndex] as? UILabel
           {
            return label
        }
        return nil
    }
    
    /// 创建系统sheetView
    static func createSheet(_ title: String?,
                            message: String? = nil,
                            items: [String]? = nil,
                            handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> Self {
        let alertVC = self.init(title: title, message: message, preferredStyle: .actionSheet)
        
        items?.forEach({ (title) in
            let style: UIAlertAction.Style = title == kTitleCancell ? .cancel : .default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) in
                alertVC.actions.forEach {
                    if action.title != kTitleCancell {
                        let number = NSNumber(booleanLiteral: ($0 == action))
                        $0.setValue(number, forKey: "checked")
                    }
                }
                alertVC.dismiss(animated: true, completion: nil)
                handler?(alertVC, action)
            }))
        })
        return alertVC
    }
    
    /// 展示提示框
    static func showSheet(_ title: String?,
                          message: String? = nil,
                          items: [String]? = nil,
                          handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) {
        UIAlertController.createSheet(title, message:message, items: items, handler: handler)
            .present()
    }

    
    /// [便利方法]提示信息
    static func showAlert(_ title: String? = "提示",
                          message: String?,
                          actionTitles: [String]? = [kTitleSure],
                          block: ((NSMutableParagraphStyle) -> Void)? = nil,
                          handler: ((UIAlertController, UIAlertAction) -> Void)? = nil){
        //富文本效果
        let paraStyle = NSMutableParagraphStyle()
            .lineBreakModeChain(.byCharWrapping)
            .lineSpacingChain(5)
            .alignmentChain(.center)
        block?(paraStyle)
        
        UIAlertController(title: title, message: message, preferredStyle: .alert)
            .addActionTitles(actionTitles, handler: handler)
            .setMessageParaStyle(paraStyle)
            .present()
    }
    
    /// [便利方法1]提示信息(兼容 OC)
    static func showAlert(_ title: String? = "提示", message: String?) {
        //富文本效果
        UIAlertController(title: title, message: message, preferredStyle: .alert)
            .addActionTitles([kTitleSure], handler: nil)
            .present()
    }

    ///根据 fmt 进行相隔时间展示
    static func canShow(_ interval: Int = Int(kDateWeek)) -> Bool {
        let nowTimestamp = Date().timeStamp
        
        if let lastTimestamp = UserDefaults.standard.integer(forKey: "lastShowAlert") as Int?,
           (nowTimestamp - lastTimestamp) < Int(interval) {
            DDLog("一个 fmt 只能提醒一次")
            return false
        }

        UserDefaults.standard.set(nowTimestamp, forKey: "lastShowAlert")
        UserDefaults.standard.synchronize()
        return true
    }
    
    ///添加多个 UIAlertAction
    @discardableResult
    func addActionTitles(_ titles: [String]? = [kTitleCancell, kTitleSure], handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> Self {
        titles?.forEach({ (string) in
            let style: UIAlertAction.Style = string == kTitleCancell ? .cancel : .default
            self.addAction(UIAlertAction(title: string, style: style, handler: { (action) in
                handler?(self, action)
            }))
        })
        return self
    }
    ///添加多个 textField
    @discardableResult
    func addTextFieldPlaceholders(_ placeholders: [String]?, handler: ((UITextField) -> Void)? = nil) -> Self {
        if self.preferredStyle != .alert {
            return self
        }
        placeholders?.forEach({ (string) in
            self.addTextField { (textField: UITextField) in
                textField.placeholder = string
                handler?(textField)
            }
        })
        return self
    }
        
    /// 设置标题颜色
    @discardableResult
    func setTitleColor(_ color: UIColor = .theme) -> Self {
        guard let title = title else {
            return self
        }
        
        let attrTitle = NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: title.count))
        setValue(attrTitle, forKey: kAlertTitle)
        return self
    }
    
    /// 设置Message文本换行,对齐方式
    @discardableResult
    func setMessageParaStyle(_ paraStyle: NSMutableParagraphStyle) -> Self {
        guard let message = message else {
            return self
        }

        let attrMsg = NSMutableAttributedString(string: message)
        let attDic = [NSAttributedString.Key.paragraphStyle: paraStyle,
                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),]
        attrMsg.addAttributes(attDic, range: NSRange(location: 0, length: message.count))
        setValue(attrMsg, forKey: kAlertMessage)
        return self
    }
    
    ///设置 Message 样式
    @discardableResult
    func setMessageStyle(_ font: UIFont,
                         textColor: UIColor,
                         alignment: NSTextAlignment = .left,
                         lineBreakMode: NSLineBreakMode = .byCharWrapping,
                         lineSpacing: CGFloat = 5.0) -> Self {
        let paraStyle = NSMutableParagraphStyle()
            .lineBreakModeChain(lineBreakMode)
            .lineSpacingChain(lineSpacing)
            .alignmentChain(alignment)
        
        return setMessageParaStyle(paraStyle)
    }
    
    @discardableResult
    func setContent(vc: UIViewController, height: CGFloat) -> Self {
        setValue(vc, forKey: kAlertContentViewController)
        vc.preferredContentSize.height = height
        preferredContentSize.height = height
        return self
    }
    
    @discardableResult
    func setContent(view: UIView, height: CGFloat, inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)) -> Self {
        let bgView = UIView()
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(view)
        
//        let inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)
        view.topAnchor.constraint(equalTo: bgView.topAnchor, constant: inset.top).isActive = true
        view.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -inset.right).isActive = true
        view.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: inset.left).isActive = true
        view.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -inset.bottom).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let vc = AlertContentController(contentView: bgView)
        setContent(vc: vc, height: height + inset.top + inset.bottom)
        return self
    }

    /// 改变宽度
    @discardableResult
    func changeWidth(_ newWidth: CGFloat = UIScreen.main.bounds.width * 0.8) -> Self {
        if preferredStyle != .alert {
            return self
        }
//        let newWidth = UIScreen.main.bounds.width * 0.90 - 270
        // Filtering width constraints of alert base view width
        let widthConstraints = view.constraints.filter({ return $0.firstAttribute == .width})
        view.removeConstraints(widthConstraints)
        // Here you can enter any width that you want
//        let newWidth = UIScreen.main.bounds.width * 0.90
        // Adding constraint for alert base view
        let widthConstraint = NSLayoutConstraint(item: view as Any,
                                                 attribute: .width,
                                                 relatedBy: .equal,
                                                 toItem: nil,
                                                 attribute: .notAnAttribute,
                                                 multiplier: 1,
                                                 constant: newWidth)
        view.addConstraint(widthConstraint)
        let firstContainer = view.subviews[0]
        // Finding first child width constraint
        let constraint = firstContainer.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        firstContainer.removeConstraints(constraint)
        // And replacing with new constraint equal to view width constraint that we setup earlier
        view.addConstraint(NSLayoutConstraint(item: firstContainer,
                                                    attribute: .width,
                                                    relatedBy: .equal,
                                                    toItem: view,
                                                    attribute: .width,
                                                    multiplier: 1.0,
                                                    constant: 0))
        // Same for the second child with width constraint with 998 priority
        let innerBackground = firstContainer.subviews[0]
        let innerConstraints = innerBackground.constraints.filter({ return $0.firstAttribute == .width && $0.secondItem == nil })
        innerBackground.removeConstraints(innerConstraints)
        firstContainer.addConstraint(NSLayoutConstraint(item: innerBackground,
                                                        attribute: .width,
                                                        relatedBy: .equal,
                                                        toItem: firstContainer,
                                                        attribute: .width,
                                                        multiplier: 1.0,
                                                        constant: 0))
        return self
    }
}

public extension UIAlertAction{
    
    @discardableResult
    func setContent(view: UIView, inset: UIEdgeInsets = UIEdgeInsets(top: 8, left: 15, bottom: 8, right: 15)) -> Self {
        let bgView = UIView()
        bgView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        bgView.addSubview(view)
        
        view.topAnchor.constraint(equalTo: bgView.topAnchor, constant: inset.top).isActive = true
        view.rightAnchor.constraint(equalTo: bgView.rightAnchor, constant: -inset.right).isActive = true
        view.leftAnchor.constraint(equalTo: bgView.leftAnchor, constant: inset.left).isActive = true
        view.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -inset.bottom).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        
        let vc = AlertContentController(contentView: bgView)
        setValue(vc, forKey: kAlertContentViewController)
        return self
    }
}

fileprivate final class AlertContentController: UIViewController {
        
    var contentView: UIView?
    
//    deinit {
//        DDLog("has deinitialized")
//    }
    
    convenience init(contentView: UIView) {
        self.init()
        self.contentView = contentView
    }
        
    override func loadView() {
        view = contentView
    }
    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//        view.addSubview(contentView!)
//
//        view.getViewLayer()
//    }
//
//    override func viewDidLayoutSubviews() {
//        super.viewDidLayoutSubviews()
//
//        contentView?.frame = CGRectMake(20, 20, view.bounds.width - 40, view.bounds.height - 40)
//    }
//
}

/**

public final class SwiftExpand<Base> {
    public let base: Base
    public init(_ base: Base) {
        self.base = base
    }
}

/**
 A type that has Kingfisher extensions.
 */
public protocol SwiftExpandCompatible {
    associatedtype CompatibleType
    var se: CompatibleType { get }
}

public extension SwiftExpandCompatible {
    var se: SwiftExpand<Self> {
        return SwiftExpand(self)
    }
}

extension UIImage: SwiftExpandCompatible { }


extension SwiftExpand where Base: UIAlertController {

     ///添加多个 UIAlertAction
     @discardableResult
     func addActionTitles(_ titles: [String]? = [kTitleCancell, kTitleSure],
                          handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> Self  {
         titles?.forEach({ (string) in
             let style: UIAlertAction.Style = string == kTitleCancell ? .cancel : .default
             self.addAction(UIAlertAction(title: string, style: style, handler: { (action) in
                 handler?(self, action)
             }))
         })
         return self
     }
}
 */
