
//
//  UITableViewCell+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/29.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UITableViewCell{
    
    /// [源]自定义 UITableViewCell 获取方法(兼容OC)
    static func dequeueReusableCell(_ tableView: UITableView, identifier: String, style: UITableViewCell.CellStyle = .default) -> Self {
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? Self.init(style: style, reuseIdentifier: identifier)

        cell.selectionStyle = .none
        cell.separatorInset = .zero
        cell.layoutMargins = .zero
        cell.backgroundColor = .white
        return cell as! Self
    }
    
    /// [OC简洁方法]自定义 UITableViewCell 获取方法
    static func dequeueReusableCell(_ tableView: UITableView) -> Self {
        return dequeueReusableCell(tableView, identifier: String(describing: self), style: .default)
    }
        
    ///调整AccessoryView位置(默认垂直居中)
    @discardableResult
    func positionAccessoryView(_ dx: CGFloat = 0, dy: CGFloat = 0) -> UIView? {
        var accessory: UIView?
        if let accessoryView = self.accessoryView {
            accessory = accessoryView
        } else if self.accessoryType != .none {
            for subview in self.subviews {
                if subview != self.textLabel && subview != self.detailTextLabel
                    && subview != self.backgroundView && subview != self.selectedBackgroundView
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
        return accessory
    }
    
    ///隐藏分割线
    func separatorHidden() {
        separatorInset = UIEdgeInsets(0, 0, 0, kScreenWidth);
    }
    ///展示分割线
    func separatorShow() {
        separatorInset = .zero
    }
    
    ///添加前缀星号
    func appendPrefixAsterisk(_ title: String) {
        guard let textLabel = textLabel,
              let text = textLabel.text else { return }
        if title.contains("*") {
            textLabel.attributedText = text.matt.appendPrefix(font: textLabel.font)
        }
    }

}

public extension UITableViewCell{

    ///设置accessoryView 为 UIView
    @discardableResult
    final func assoryView<T: UIView>(_ type: T.Type, size: CGSize = CGSize(width: 80, height: 30), block:((T)->Void)? = nil) -> T {
        if let view = accessoryView as? T {
            block?(view)
            return view
        }
        let view = type.init(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        accessoryView = view
        block?(view)
        return view
    }
    
}
