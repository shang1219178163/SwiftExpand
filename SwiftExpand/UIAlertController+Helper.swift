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

public extension UIAlertController{
    /// 创建系统提示框
    @objc static func createAlert(_ title: String, placeholders: [String]? = nil, msg: String, actionTitles: [String]? = nil, handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
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
                    handler!(alertController, action)
                }
            }))
        })
        return alertController
    }
    
    /// 展示提示框
    @objc static func showAlert(_ title: String, placeholders: [String]? = nil, msg: String, actionTitles: [String]? = nil, handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        
        let alertController = UIAlertController.createAlert(title, placeholders: placeholders, msg: msg, actionTitles: actionTitles, handler: handler)
        if actionTitles == nil {
            UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: {
                DispatchQueue.main.after(TimeInterval(kDurationToast), execute: {
                    alertController.dismiss(animated: true, completion: nil)
                })
            })
        } else {
            UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: nil)

        }
        return alertController
    }
    
    /// 创建系统sheetView
    @objc static func createSheet(_ title: String?, msg: String? = nil, items: [String]? = nil, handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController(title: title, message: msg, preferredStyle: .actionSheet)
        
        items?.forEach({ (title:String) in
            let style: UIAlertAction.Style = title == kActionTitle_Cancell ? .cancel : .default
            alertController.addAction(UIAlertAction(title: title, style: style, handler: { (action: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        })
        
        if items?.contains(kActionTitle_Cancell) == false || items == nil {
            alertController.addAction(UIAlertAction(title: kActionTitle_Cancell, style: .cancel, handler: { (action: UIAlertAction) in
                alertController.dismiss(animated: true, completion: nil)
                if handler != nil {
                    handler!(alertController, action)
                }
            }))
        }
        return alertController
    }
    
    /// 展示提示框
    @objc static func showSheet(_ title: String?, msg: String? = nil, items: [String]? = nil, handler: ((UIAlertController, UIAlertAction) -> Void)? = nil) -> UIAlertController {
        let alertController = UIAlertController.createSheet(title, msg:msg, items: items, handler: handler)
        UIApplication.mainWindow.rootViewController?.present(alertController, animated: true, completion: nil)
        return alertController
    }

    /// 设置标题颜色
    @objc func setTitleColor(_ color: UIColor) -> Void {
        guard let title = title else {
            return;
        }
        
        let attrTitle = NSMutableAttributedString(string: title)
        attrTitle.addAttributes([NSAttributedString.Key.foregroundColor: color], range: NSRange(location: 0, length: title.count))
        setValue(attrTitle, forKey: kAlertCtlrTitle)
    }
    
    /// 设置Message文本换行,对齐方式
    @objc func setMessageParaStyle(_ paraStyle: NSMutableParagraphStyle) -> Void {
        guard let message = message else {
            return;
        }

        let attrMsg = NSMutableAttributedString(string: message)
        let attDic = [NSAttributedString.Key.paragraphStyle: paraStyle,
                      NSAttributedString.Key.font: UIFont.systemFont(ofSize: 13),]
        attrMsg.addAttributes(attDic, range: NSRange(location: 0, length: message.count))
        setValue(attrMsg, forKey: kAlertCtlrMessage)
    }
    
}
