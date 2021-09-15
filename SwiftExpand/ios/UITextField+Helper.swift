

//
//  UITextField+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UITextField{
    
    /// [源]UITextField创建
    static func create(_ rect: CGRect = .zero) -> Self {
        let view = self.init(frame: rect)
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.borderStyle = .none
        view.contentVerticalAlignment = .center
        view.clearButtonMode = .whileEditing
        view.autocapitalizationType = .none
        view.autocorrectionType = .no
        view.backgroundColor = .white
        view.returnKeyType = .done
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }
    
    func clear() {
        text = ""
        attributedText = NSAttributedString(string: "")
    }
    
    //设置 attributedPlaceholder
    func setPlaceHolder(_ holder: String? = nil, font: UIFont = UIFont.systemFont(ofSize: 15), baseline: CGFloat = 0) {
        guard let holder = holder ?? placeholder, !holder.isEmpty else { return }
        let dic: [NSAttributedString.Key: Any] = [
            .foregroundColor: UIColor.gray.withAlphaComponent(0.7),
            .font: self.font ?? font,
            .baselineOffset: baseline,
        ]
        attributedPlaceholder = NSAttributedString(string: holder, attributes: dic)
    }
    
    ///设置密码明暗文切换
    func addPasswordEveBlock(_ image: UIImage? = UIImage.icon_eye_close,
                             selectedImage: UIImage? = UIImage.icon_eye_open,
                             edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5),
                             block: @escaping ((UIButton) ->Void)) {
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: 40, height: 30)
//        view.backgroundColor = .systemGreen
        
        let sender = UIButton(type: .custom)
        sender.setImage(image, for: .normal)
        sender.setImage(selectedImage, for: .selected)
        sender.addActionHandler({ (sender) in
            sender.isSelected = !sender.isSelected
            self.isSecureTextEntry = !sender.isSelected
            block(sender)
        }, for: .touchUpInside)
        
        sender.frame = CGRect(x: edge.left,
                              y: edge.top,
                              width: view.bounds.width - edge.left - edge.right,
                              height: view.bounds.height - edge.top - edge.bottom)
//        sender.backgroundColor = .systemRed
        view.addSubview(sender)
        rightView = view
        rightViewMode = .always
        
        clearButtonMode = .never
        isSecureTextEntry = true
    }
    
    ///设置 Button 为 RightView
    func addRightViewButton(_ size: CGSize = CGSize(width: 40, height: 30),
                            edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5),
                            block: ((UIButton) ->Void)?,
                            action: @escaping ((UIButton) ->Void)) {
        if let sender = rightView as? UIButton {
            block?(sender)
            sender.addActionHandler({ (sender) in
                sender.isSelected = !sender.isSelected
                action(sender)
            }, for: .touchUpInside)
            return
        }

        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        view.backgroundColor = .systemGreen
        
        let sender = UIButton(type: .custom)
        sender.titleLabel?.font = self.font
        sender.frame = CGRect(x: edge.left,
                              y: edge.top,
                              width: view.bounds.width - edge.left - edge.right,
                              height: view.bounds.height - edge.top - edge.bottom)
        sender.addActionHandler({ (sender) in
            sender.isSelected = !sender.isSelected
            action(sender)
        }, for: .touchUpInside)
        
        block?(sender)
//        sender.backgroundColor = .systemRed
        view.addSubview(sender)
        rightView = view
        rightViewMode = .always
        
        clearButtonMode = .never
    }
    ///设置 Label 为 RightView
    func addRightViewLabel(_ block: ((UILabel) ->Void)?) {
        if let sender = rightView as? UILabel {
            block?(sender)
            return
        }
        

        let view = UIView()
//        view.backgroundColor = .systemGreen
        
        let sender = UILabel()
        sender.font = self.font
        block?(sender)

        let size = sender.sizeThatFits(.zero)
        view.frame = CGRect(x: 0, y: 0, width: size.width + 10, height: size.height)
        sender.frame = CGRect(x: 5, y: 0, width: size.width, height: size.height)
        
//        sender.backgroundColor = .systemRed
        view.addSubview(sender)
        rightView = view
        rightViewMode = .always
        
        clearButtonMode = .never
    }
    
    ///设置 Button 为 LeftView
    func addLeftViewButton(_ size: CGSize = CGSize(width: 40, height: 30),
                           edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5),
                           block: ((UIButton) ->Void)?,
                           action: ((UIButton) ->Void)? = nil) {
        if let sender = leftView as? UIButton {
            block?(sender)
            if let action = action {
                sender.addActionHandler(action)
            }
            return
        }
        
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)
//        view.backgroundColor = .systemGreen
        
        let sender = UIButton(type: .custom)
        sender.frame = CGRect(x: edge.left,
                              y: edge.top,
                              width: view.bounds.width - edge.left - edge.right,
                              height: view.bounds.height - edge.top - edge.bottom)
        if let action = action {
            sender.addActionHandler(action)
        }
        block?(sender)
//        sender.backgroundColor = .systemRed
        view.addSubview(sender)
        leftView = view
        leftViewMode = .always
    }
    ///设置 Label 为 LeftView
    func addLeftViewLabel(_ block: ((UILabel) ->Void)?) {
        if let sender = rightView as? UILabel {
            block?(sender)
            return
        }
        
        let view = UIView()
//        view.backgroundColor = .systemGreen
        
        let sender = UILabel()
        sender.font = self.font
        block?(sender)

        let size = sender.sizeThatFits(.zero)
        view.frame = CGRect(x: 0, y: 0, width: size.width + 10, height: size.height)
        sender.frame = CGRect(x: 5, y: 0, width: size.width, height: size.height)
        
//        sender.backgroundColor = .systemRed
        view.addSubview(sender)
        rightView = view
        rightViewMode = .always
    }
    
}

public extension UITextField{
    ///设置rightView 为 T: UIView
    @discardableResult
    final func rightView<T: UIView>(_ type: T.Type,
                                    viewMode: UITextField.ViewMode = .always,
                                    size: CGSize = CGSize(width: 30, height: 35),
                                    edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5),
                                    block:((T)->Void)? = nil) -> T {
        if let accessoryView = rightView as? T {
            return accessoryView
        }
                
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        let sender = type.init()
        sender.frame = CGRect(x: edge.left,
                              y: edge.top,
                              width: view.bounds.width - edge.left - edge.right,
                              height: view.bounds.height - edge.top - edge.bottom)
        block?(sender)
        
        switch sender {
        case let obj as UILabel:
            let size = obj.sizeThatFits(.zero)
            view.frame = CGRect(x: 0,
                                y: 0,
                                width: size.width + edge.left + edge.right,
                                height: size.height + edge.top + edge.bottom)
            sender.frame = CGRect(x: edge.left, y: edge.top, width: size.width, height: size.height)
            
        default:
            break
        }
        
        view.addSubview(sender)
        rightView = view
        rightViewMode = viewMode
        return sender
    }
    
    ///设置leftView 为 T: UIView
    @discardableResult
    final func leftView<T: UIView>(_ type: T.Type,
                                   viewMode: UITextField.ViewMode = .always,
                                   size: CGSize = CGSize(width: 30, height: 35),
                                   edge: UIEdgeInsets = UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5),
                                   block:((T)->Void)? = nil) -> T {
        if let accessoryView = leftView as? T {
            return accessoryView
        }
        let view = UIView()
        view.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height)

        let sender = type.init()
        sender.frame = CGRect(x: edge.left,
                              y: edge.top,
                              width: view.bounds.width - edge.left - edge.right,
                              height: view.bounds.height - edge.top - edge.bottom)
        block?(sender)
        
        switch sender {
        case let obj as UILabel:
            let size = obj.sizeThatFits(.zero)
            view.frame = CGRect(x: 0,
                                y: 0,
                                width: size.width + edge.left + edge.right,
                                height: size.height + edge.top + edge.bottom)
            sender.frame = CGRect(x: edge.left, y: edge.top, width: size.width, height: size.height)
            
        default:
            break
        }
        
        view.addSubview(sender)
        leftView = view
        leftViewMode = viewMode
        return sender
    }
}
