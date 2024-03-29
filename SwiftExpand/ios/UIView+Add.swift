
//
//  UIView+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/27.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UIView {
    private struct AssociateKeys {
//        static var isSelected    = "UIView" + "isSelected"
        static var lineTop       = "UIView" + "lineTop"
        static var lineBottom    = "UIView" + "lineBottom"
        static var lineRight     = "UIView" + "lineRight"
        static var gradientLayer = "UIView" + "gradientLayer"
    }
    ///视图方向(上左下右)
    @objc enum Direction: Int {
        case none
        case top
        case left
        case bottom
        case right
        case center
    }

    ///视图角落(左上,左下,右上,右下)
    @objc enum Location: Int {
        case none
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
            
    var lineTop: UIView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lineTop) as? UIView {
                return obj
            }
            
            let view = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW))
            view.backgroundColor = .line

            objc_setAssociatedObject(self, &AssociateKeys.lineTop, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lineTop, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var lineBottom: UIView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lineBottom) as? UIView {
                return obj
            }
            
            let view = UIView(frame: CGRect(x: 0, y: frame.maxY - kH_LINE_VIEW, width: frame.width, height: kH_LINE_VIEW))
            view.backgroundColor = .line

            objc_setAssociatedObject(self, &AssociateKeys.lineBottom, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lineBottom, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    var lineRight: UIView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lineRight) as? UIView {
                return obj
            }
            
            let view = UIView(frame: CGRect(x: frame.maxX - kH_LINE_VIEW, y: 0, width: kH_LINE_VIEW, height: frame.height))
            view.backgroundColor = .line

            objc_setAssociatedObject(self, &AssociateKeys.lineRight, view, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return view
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lineRight, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
    
    func addLineDashLayer(color: UIColor = .red,
                          width: CGFloat = 1,
                          dashPattern: [NSNumber] = [NSNumber(floatLiteral: 4), NSNumber(floatLiteral: 5)],
                          cornerRadius: CGFloat = 0,
                          start: CGPoint,
                          end: CGPoint) {
        let view: UIView = self

        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        let path = CGMutablePath()
        path.move(to: start)
        path.addLine(to: end)
        shapeLayer.path = UIBezierPath(cgPath: path).cgPath

        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.lineCap = .square
        if cornerRadius > 0 {
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
        }
        view.layer.addSublayer(shapeLayer)
    }
    
    func addDashLayer(color: UIColor = .red,
                      width: CGFloat = 1,
                    dashPattern: [NSNumber] = [NSNumber(floatLiteral: 4), NSNumber(floatLiteral: 5)],
                    cornerRadius: CGFloat = 0,
                    size: CGSize = CGSize.zero) {
        let view: UIView = self
        assert(CGRect.zero.equalTo(view.bounds) == true && CGSize.zero.equalTo(size))

        view.layer.borderColor = UIColor.clear.cgColor
        view.layer.borderWidth = 0
        
        let shapeLayer = CAShapeLayer()
        shapeLayer.strokeColor = color.cgColor
        shapeLayer.fillColor = UIColor.clear.cgColor
        
        shapeLayer.frame = CGSize.zero.equalTo(size) ? view.bounds : CGRect(x: 0, y: 0, width: size.width, height: size.height)
        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.frame, cornerRadius: cornerRadius).cgPath
        
        shapeLayer.lineWidth = width
        shapeLayer.lineDashPattern = dashPattern
        shapeLayer.lineCap = .square
        if cornerRadius > 0 {
            view.layer.cornerRadius = cornerRadius
            view.layer.masksToBounds = true
        }
        view.layer.addSublayer(shapeLayer)
    }
    
     /// 获取密集子视图的总高度
    static func groupViewHeight(_ count: Int = 9, numberOfRow: Int = 4, padding: CGFloat = 12, itemHeight: CGFloat = 40) -> CGFloat {
        let rowCount = count % numberOfRow == 0 ? count/numberOfRow : count/numberOfRow + 1
        return rowCount.cgFloatValue * itemHeight + (rowCount - 1).cgFloatValue * padding
    }
    
     ///视图添加圆角
    func addRoundCornerLayer(_ radius: CGFloat = 10, padding: CGFloat = 10, isHeader: Bool, lineColor: UIColor = .white) {
         // 获取显示区域大小
         let rect = bounds.insetBy(dx: padding, dy: 0)
         // 贝塞尔曲线
         var bezierPath: UIBezierPath?
         if isHeader == true {
             // 每组第一行（添加左上和右上的圆角）
             bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
         } else {
             // 每组最后一行（添加左下和右下的圆角）
             bezierPath = UIBezierPath(roundedRect: rect, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
         }

         // 创建两个layer
         let normalLayer = CAShapeLayer()
         // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
         normalLayer.path = bezierPath?.cgPath
         // 设置填充颜色
         normalLayer.fillColor = lineColor.cgColor
         normalLayer.strokeColor = UIColor.white.cgColor
         // 设置填充颜色
         layer.insertSublayer(normalLayer, at: 0)
     }
}


public extension UIView{
    
    ///更新各种子视图
    @discardableResult
    final func updateItems<T: UIView>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
        if count == 0 {
            subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }
            return []
        }
        
        if let list = self.subviews.filter({ $0.isMember(of: type) }) as? [T] {
            if list.count == count {
                list.forEach { hanler($0) }
                return list
            }
        }
        
        subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }

        var arr: [T] = []
        for i in 0..<count {
            let subview = type.init(frame: .zero)
            subview.tag = i
            self.addSubview(subview)
            arr.append(subview)
            
            hanler(subview)
        }
        return arr
    }
    
    ///更新各种子类按钮
    @discardableResult
    final func updateButtonItems<T: UIButton>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
        return updateItems(count, type: type) {
            if $0.title(for: .normal) == nil {
                $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                $0.setTitle("\(type)\($0.tag)", for: .normal)
                $0.setTitleColor(.black, for: .normal)
                $0.setBackgroundColor(.lightGray, for: .disabled)
            }
            hanler($0)
        }
    }
    
    ///更新各种子类UILabel
    @discardableResult
    final func updateLabelItems<T: UILabel>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
        return updateItems(count, type: type) {
            if $0.text == nil {
                $0.text = "\(type)\($0.tag)"
                $0.font = UIFont.systemFont(ofSize: 15)
            }
            hanler($0)
        }
    }
    
    /// [源]创建子类型的 view(例如 cell headerView)
    @discardableResult
    final func createSubTypeView<T: UIView>(_ type: T.Type, height: CGFloat = 30, inset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), block: @escaping ((T)->Void)) -> UIView{
        if let subView = viewWithTag(tag) as? T {
            block(subView)
            return subView
        }
        let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: height))
        sectionView.backgroundColor = .background

        let view = type.init(frame: CGRect(x: inset.left,
                                           y: inset.top,
                                           width: bounds.width - inset.left - inset.right,
                                           height: height - inset.top - inset.bottom))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight, ]
        view.tag = tag
        sectionView.addSubview(view)
        block(view)
        return sectionView
    }
    
    /// [源]创建子类型的 view(cell 添加视图)
    @discardableResult
    final func createSubTypeView<T: UIView>(_ type: T.Type, tag: Int, inset: UIEdgeInsets = .zero, block: @escaping ((T)->Void)) -> UIView{
        if let subView = viewWithTag(tag) as? T {
            block(subView)
            return subView
        }
        
        let view = type.init(frame: CGRect(x: inset.left,
                                           y: inset.top,
                                           width: bounds.width - inset.left - inset.right,
                                           height: bounds.height - inset.top - inset.bottom))
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight, ]
        view.tag = tag
        addSubview(view)
        block(view)
        return view
    }
}

