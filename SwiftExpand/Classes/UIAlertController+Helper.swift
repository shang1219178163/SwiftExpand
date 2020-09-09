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
    /// 创建系统提示框
    static func createAlert(_ title: String?,
                                  placeholders: [String]? = nil,
                                  msg: String,
                                  actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
       
        placeholders?.forEach { (placeholder: String) in
            alertController.addTextField(configurationHandler: { (textField: UITextField) in
                textField.placeholder = placeholder

            })
        }
        
        actionTitles?.forEach({ (title:String) in
            let style: UIAlertAction.Style = [kTitleCancell, kTitleNo].contains(title) ? .destructive : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        })
        return alertController
    }
    
    /// 展示提示框
    static func showAlert(_ title: String?,
                                placeholders: [String]? = nil,
                                msg: String,
                                actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) {
        let rootVC = UIApplication.shared.delegate?.window??.rootViewController

        let alertController = UIAlertController.createAlert(title, placeholders: placeholders, msg: msg, actionTitles: actionTitles, handler: handler)
        if actionTitles == nil {
            rootVC?.present(alertController, animated: true, completion: {
                DispatchQueue.main.after(TimeInterval(kDurationToast), execute: {
                    alertController.dismiss(animated: true, completion: nil)
                })
            })
        } else {
            rootVC?.present(alertController, animated: true, completion: nil)
        }
    }
    
    /// 创建包含图片不含message的提示框
    static func createAlertImage(_ title: String?,
                                 image: String,
                                 contentMode: UIView.ContentMode = .scaleAspectFit,
                                  count: Int = 10,
                                  actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        assert(UIImage(named: image) != nil)
        
        let msg = String(repeating: "\n", count: count)
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        // 配置图片
        let image = UIImage(named: image)
        let imageView = UIImageView(image: image)
        imageView.contentMode = contentMode
        alertController.view.addSubview(imageView)

        imageView.translatesAutoresizingMaskIntoConstraints = false
        alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerX, relatedBy: .equal, toItem: alertController.view, attribute: .centerX, multiplier: 1, constant: 0))
        alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .centerY, relatedBy: .equal, toItem: alertController.view, attribute: .centerY, multiplier: 1, constant: 15))
        alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 240))
        alertController.view.addConstraint(NSLayoutConstraint(item: imageView, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1.0, constant: 17*CGFloat(count) - 30))
        // 配置按钮
        actionTitles?.forEach({ (title:String) in
            let style: UIAlertAction.Style = [kTitleCancell, kTitleNo].contains(title) ? .destructive : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        })
        return alertController
    }
    
    /// 创建系统sheetView
    static func createSheet(_ title: String?,
                                  msg: String? = nil,
                                  items: [String]? = nil,
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        items?.forEach({ (title) in
            let style: UIAlertAction.Style = title == kTitleCancell ? .cancel : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                alertController.actions.forEach {
                    if action.title != kTitleCancell {
                        let number = NSNumber(booleanLiteral: ($0 == action))
                        $0.setValue(number, forKey: "checked")
                    }
                }
                alertController.dismiss(animated: true, completion: nil)
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        })
        
        if items?.contains(kTitleCancell) == false || items == nil {
            alertController.addAction(UIAlertAction(title: kTitleCancell, style: .cancel, handler: { (action: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        }
        return alertController
    }
    
    /// 展示提示框
    static func showSheet(_ title: String?,
                                msg: String? = nil,
                                items: [String]? = nil,
                                handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) {
        let alertVC = UIAlertController.createSheet(title, msg:msg, items: items, handler: handler)
        alertVC.present()
    }

    ///添加 UIAlertAction
    func addActionTitle(_ title: String?, style: UIAlertAction.Style, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        self.addAction(UIAlertAction(title: title, style: style, handler: handler))
        return self
    }
    ///添加 textField
    func addTextFieldPlaceholder(_ placeholder: String, handler: ((UITextField) -> Void)? = nil) -> UIAlertController {
        self.addTextField { (textField: UITextField) in
            textField.placeholder = placeholder
            handler?(textField)
        }
        return self
    }
    
    ///添加多个 UIAlertAction
    func addActionTitles(_ titles: [String]?, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        titles?.forEach({ (string) in
            let style: UIAlertAction.Style = string == kTitleCancell ? .destructive : .default
            self.addAction(UIAlertAction(title: string, style: style, handler: handler))
        })
        return self
    }
    ///添加多个 textField
    func addTextFieldPlaceholders(_ placeholders: [String]?, handler: ((UITextField) -> Void)? = nil) -> UIAlertController {
        placeholders?.forEach({ (string) in
            self.addTextField { (textField: UITextField) in
                textField.placeholder = string
                handler?(textField)
            }
        })
        return self
    }
    
    /// 设置标题颜色
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
    func setMessageStyle(_ font: UIFont, textColor: UIColor, alignment: NSTextAlignment = .left, lineBreakMode: NSLineBreakMode = .byCharWrapping, lineSpacing: CGFloat = 5.0) -> UIAlertController {
        
        let paraStyle = NSMutableParagraphStyle()
        paraStyle.lineBreakMode = .byCharWrapping;
        paraStyle.lineSpacing = lineSpacing;
        paraStyle.alignment = alignment;
        return setMessageParaStyle(paraStyle)
    }
    
    /// [便利方法]提示信息
    static func showAlert(_ title: String = "提示", message: String, alignment: NSTextAlignment = .center, actionTitles: [String]? = [kTitleSure], handler: ((UIAlertController, UIAlertAction) -> Void)? = nil){
        //富文本效果
        let paraStyle = NSMutableParagraphStyle.create(.byCharWrapping, alignment: alignment)
        
        UIAlertController.createAlert(title, placeholders: nil, msg: message, actionTitles: actionTitles, handler: handler)
            .setMessageParaStyle(paraStyle)
            .present()
    }
    
    /// 创建包含图片不含message的提示框
    static func showAlertImage(_ title: String?,
                                 image: String,
                                 contentMode: UIView.ContentMode = .scaleAspectFit,
                                  count: Int = 10,
                                  actionTitles: [String]? = [kTitleCancell, kTitleSure],
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil){
        let alertVC = UIAlertController.createAlertImage(title, image: image, contentMode: contentMode, count: count, actionTitles: actionTitles, handler: handler)
        alertVC.present()
    }

}


public extension UIAlertController {

    ///添加子视图
    final func addCustomView<T:UIView>(_ type: T.Type, height: CGFloat, inset: UIEdgeInsets, block: @escaping((T)->Void)) {
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
    }
    
    /// 创建包含图片不含message的提示框
    static func createSheet<T:UIView>(_ title: String?,
                                    message: String?,
                                    type: T.Type,
                                    height: CGFloat,
                                    block: @escaping ((T)->Void),
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController{
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
            handler?(alertVC, action)
        }))
        return alertVC
    }
    
    /// 创建包含图片不含message的提示框
    static func showSheet<T:UIView>(_ title: String?,
                                    message: String?,
                                    type: T.Type,
                                    height: CGFloat,
                                    block: @escaping ((T)->Void),
                                  handler: ((UIAlertController, UIAlertAction) -> Void)? = nil){
        
        UIAlertController.createSheet(title, message: message, type: type, height: height, block: block, handler: handler)
        .present()
    }
}
