//
//  UIAlertController+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/12.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

/// UIAlertController标题富文本key
public let kAlertCtlrTitle = "attributedTitle"
/// UIAlertController信息富文本key
public let kAlertCtlrMessage = "attributedMessage"
/// UIAlertController按钮颜色key
public let kAlertActionColor = "titleTextColor"
/// UIAlertController按钮颜色image
public let kAlertActionImage = "image"
/// UIAlertController按钮颜色imageTintColor
public let kAlertActionImageTintColor = "imageTintColor"
/// UIAlertController按钮 checkmark
public let kAlertActionChecked = "checked"

@objc public extension UIAlertController{

    /// 创建包含图片不含message的提示框
    static func createAlertImage(_ title: String?,
                                 image: String,
                                 contentMode: UIView.ContentMode = .scaleAspectFit,
                                  count: Int = 10,
                                  actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                  handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        assert(UIImage(named: image) != nil)
        
        let msg = String(repeating: "\n", count: count)
        let alertVC = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        // 配置图片
        let image = UIImage(named: image)
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        alertVC.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        alertVC.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: alertVC.view, attribute: .centerX, multiplier: 1, constant: 0))
        alertVC.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: alertVC.view, attribute: .centerY, multiplier: 1, constant: 15))
        alertVC.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        alertVC.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 17*CGFloat(count) - 30))
        // 配置按钮
        actionTitles?.forEach({ (title:String) in
            let style: UIAlertAction.Style = [kTitleCancell, kTitleNo].contains(title) ? .destructive : .default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) in
                handler?(action)
            }))
        })
        return alertVC
    }
    
    /// 创建系统sheetView
    static func createSheet(_ title: String?,
                            message: String? = nil,
                            items: [String]? = nil,
                            handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
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
                handler?(action)
            }))
        })
        return alertVC
    }
    
    /// 展示提示框
    static func showSheet(_ title: String?,
                          message: String? = nil,
                          items: [String]? = nil,
                          handler: ((UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController.createSheet(title, message:message, items: items, handler: handler)
        alertVC.present()
    }

    ///添加多个 UIAlertAction
    @discardableResult
    func addActionTitles(_ titles: [String]? = [kTitleCancell, kTitleSure], handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        titles?.forEach({ (string) in
            let style: UIAlertAction.Style = string == kTitleCancell ? .destructive : .default
            self.addAction(UIAlertAction(title: string, style: style, handler: handler))
        })
        return self
    }
    ///添加多个 textField
    @discardableResult
    func addTextFieldPlaceholders(_ placeholders: [String]?, handler: ((UITextField) -> Void)? = nil) -> UIAlertController {
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
    func setTitleColor(_ color: UIColor = .theme) -> UIAlertController {
        guard let title = title else {
            return self;
        }
        
        let attrTitle = NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: title.count))
        setValue(attrTitle, forKey: kAlertCtlrTitle)
        return self;
    }
    
    /// 设置Message文本换行,对齐方式
    @discardableResult
    func setMessageParaStyle(_ paraStyle: NSMutableParagraphStyle) -> UIAlertController {
        guard let message = message else {
            return self;
        }

        let attrMsg = NSMutableAttributedString(string: message)
        let attDic = [NSAttributedString.Key.paragraphStyle: paraStyle,
                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),]
        attrMsg.addAttributes(attDic, range: NSRange(location: 0, length: message.count))
        setValue(attrMsg, forKey: kAlertCtlrMessage)
        return self;
    }
    
    ///设置 Message 样式
    @discardableResult
    func setMessageStyle(_ font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byCharWrapping, lineSpacing: CGFloat = 5.0) -> UIAlertController {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byCharWrapping;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.alignment = alignment;
        return setMessageParaStyle(paraStyle)
    }
    
    /// [便利方法]提示信息
    static func showAlert(_ title: String? = "提示",
                          message: String?,
                          actionTitles: [String]? = [kTitleSure],
                          block: ((NSMutableParagraphStyle) -> Void)? = nil,
                          handler: ((UIAlertAction) -> Void)? = nil){
        //富文本效果
        let paraStyle = NSMutableParagraphStyle.create(.byCharWrapping, alignment: .center)
        block?(paraStyle)
        UIAlertController(title: title, message: message, preferredStyle: .alert)
            .addActionTitles(actionTitles, handler: handler)
            .setMessageParaStyle(paraStyle)
            .present()
    }
    
    /// [便利方法1]提示信息(兼容 OC)
    static func showAlert(_ title: String? = "提示", message: String?){
        //富文本效果
        UIAlertController(title: title, message: message, preferredStyle: .alert)
            .addActionTitles([kTitleSure], handler: nil)
            .present()
    }
    
    /// 创建包含图片不含message的提示框
    static func showAlertImage(_ title: String?,
                                 image: String,
                                 contentMode: UIView.ContentMode = .scaleAspectFit,
                                  count: Int = 20,
                                  actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                  handler: ((UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController.createAlertImage(title, image: image, contentMode: contentMode, count: count, actionTitles: actionTitles, handler: handler)
        alertVC.present()
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
}


public extension UIAlertController {

    ///添加子视图(仅限 actionSheet)
    @discardableResult
    final func addCustomView<T:UIView>(_ type: T.Type, height: CGFloat, inset: UIEdgeInsets, block: @escaping((T)->Void)) -> UIAlertController {
        if preferredStyle == .alert {
            return self
        }
        let customView = type.init()
        view.addSubview(customView)
        customView.translatesAutoresizingMaskIntoConstraints = false
        customView.topAnchor.constraint(equalTo: view.topAnchor, constant: inset.top).isActive = true
        customView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -inset.right).isActive = true
        customView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: inset.left).isActive = true
        customView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -inset.bottom).isActive = true
        customView.backgroundColor = .systemGreen

        view.translatesAutoresizingMaskIntoConstraints = false
        view.heightAnchor.constraint(equalToConstant: inset.top + height).isActive = true
        block(customView)
        return self
    }
    
    /// 创建包含图片不含message的提示框
    static func createSheet<T:UIView>(_ title: String?,
                                    message: String?,
                                    type: T.Type,
                                    height: CGFloat,
                                    block: @escaping ((T)->Void),
                                  handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController{
        let alertVC = UIAlertController(title: title,
                                        message: message,
                                        preferredStyle: .actionSheet)

        var top: CGFloat = alertVC.title == nil ? 0.0 : 45
        if let message = alertVC.message {
            let width = UIScreen.main.bounds.width - 52
//            let attDic = [NSAttributedString.Key.font: UIFont.systemFont(ofSize:15),];
//            let options: NSStringDrawingOptions = [.usesLineFragmentOrigin, .usesFontLeading]
//
//            let size = message.boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: options, attributes: attDic, context: nil).size;
//            let messageSize = CGSize(width: ceil(size.width), height: ceil(size.height))
            
            let messageSize = message.size(15, width: width)
            top += messageSize.height
        }
        
        let inset = UIEdgeInsetsMake(top + 3, 16, 75, 16)
        alertVC.addCustomView(type, height: height, inset: inset, block: block)

        alertVC.addAction(UIAlertAction(title: kTitleCancell, style: .cancel, handler: { (action) in
            handler?(action)
        }))
        return alertVC
    }
    
    /// 创建包含图片不含message的提示框
    static func showSheet<T:UIView>(_ title: String?,
                                    message: String?,
                                    type: T.Type,
                                    height: CGFloat,
                                    block: @escaping ((T)->Void),
                                  handler: ((UIAlertAction) -> Void)? = nil){
        
        UIAlertController.createSheet(title, message: message, type: type, height: height, block: block, handler: handler)
        .present()
    }
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

    /// 创建系统sheetView
    static func createSheet(_ title: String?,
                            message: String? = nil,
                            items: [String]? = nil,
                            handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        
        items?.forEach({ (title) in
            let style: UIAlertAction.Style = title == "取消" ? .cancel : .default
            alertVC.addAction(UIAlertAction(title: title, style: style, handler: { (action) in
                alertVC.actions.forEach {
                    if action.title != "确定" {
                        let number = NSNumber(booleanLiteral: ($0 == action))
                        $0.setValue(number, forKey: "checked")
                    }
                }
                alertVC.dismiss(animated: true, completion: nil)
                handler?(action)
            }))
        })
        return alertVC
    }
}
 */
