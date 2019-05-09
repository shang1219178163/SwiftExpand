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

extension UIAlertController{
    /// 创建系统提示框
    @objc public static func createAlert(_ title: String, placeholders: [String]? = nil, msg: String, actionTitles: [String]? = nil, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .alert)
       
        placeholders?.forEach { (placeholder: String) in
            alertController.addTextField(configurationHandler: { (textField: UITextField) in
                textField.placeholder = placeholder

            })
        }
        
        actionTitles?.forEach({ (title:String) in
            let style: UIAlertAction.Style = title == kActionTitle_Cancell ? .destructive : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                if handler != nil {
                    handler!(action)
                }
            }))
        })
        return alertController
    }
    
    /// 展示提示框
    @objc public static func showAlert(_ title: String, placeholders: [String]? = nil, msg: String, actionTitles: [String]? = nil, handler: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController.createAlert(title, placeholders: placeholders, msg: msg, actionTitles: actionTitles, handler: handler)
        if actionTitles == nil {
            UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: {
                DispatchQueue.main.after(TimeInterval(kDurationToast), execute: {
                    alertController.dismiss(animated: true, completion: nil)
                })
            })
        }
        UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        return alertController
    }
    
    /// 创建系统sheetView
    @objc public static func createSheet(_ title: String?, items: [String]? = nil, completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: nil, preferredStyle: .actionSheet)
        
        items?.forEach({ (title:String) in
            let style: UIAlertAction.Style = title == kActionTitle_Cancell ? .cancel : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                if completion != nil {
                    completion!(action)
                }
            }))
        })
        
        if items?.contains(kActionTitle_Cancell) == false || items == nil {
            alertController.addAction(UIAlertAction(title: kActionTitle_Cancell, style: .cancel, handler: { (action: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                if completion != nil {
                    completion!(action)
                }
            }))
        }
        return alertController
    }
    
    /// 展示提示框
    @objc public static func showSheet(_ title: String?, items: [String]? = nil, completion: ((UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController.createSheet(title, items: items, completion: completion)
        UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        return alertController
    }

    /// 设置标题颜色
    @objc public func setTitleColor(_ color: UIColor) -> Void {
        guard let title = title else {
            return;
        }
        
        let attrTitle = NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: title.count))
        setValue(attrTitle, forKey: kAlertCtlrTitle)
    }
    
    /// 设置Message文本换行,对齐方式
    @objc public func setMessageParaStyle(_ paraStyle: NSMutableParagraphStyle) -> Void {
        guard let message = message else {
            return;
        }

        let attrMsg = NSMutableAttributedString(string: message)
        attrMsg.addAttributes([NSAttributedString.Key.paragraphStyle: paraStyle], range: NSRange(location: 0, length: message.count))
        setValue(attrMsg, forKey: kAlertCtlrMessage)
    }
    
}
