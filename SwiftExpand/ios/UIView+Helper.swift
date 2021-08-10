//
//  UIView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/14.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UIView{
    
    var sizeWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
            var rectTmp = frame
            rectTmp.size.width = newValue
            frame = rectTmp
        }
    }
    
    var sizeHeight: CGFloat {
        get {
            return frame.size.height
        }
        set {
            var rectTmp = frame
            rectTmp.size.height = newValue
            frame = rectTmp
        }
    }
        
    var originX: CGFloat {
        get {
            return frame.origin.x
        }
        set {
            var rectTmp = frame
            rectTmp.origin.x = newValue
            frame = rectTmp
        }
    }
    
    var originY: CGFloat {
        get {
            return frame.origin.y
        }
        set {
            var rectTmp = frame
            rectTmp.origin.y = newValue
            frame = rectTmp
        }
    }
    
    
    //MARK: -funtions
    
    /// 图层调试
    func getViewLayer(_ lineColor: UIColor = .blue) {
        #if DEBUG
        for subview in subviews {
            subview.layer.borderWidth = kW_LayerBorder
            subview.layer.borderColor = lineColor.cgColor
            subview.getViewLayer(lineColor)
        }
        #endif
    }
        
    /// 寻找子视图
    func findSubview(type: UIResponder.Type, resursion: Bool)-> UIView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element
            }
        }
        
        if resursion == true {
            for e in self.subviews.enumerated() {
                let tmpView = e.element.findSubview(type: type, resursion: resursion)
                if tmpView != nil {
                    return tmpView
                }
            }
        }
        return nil
    }
    
    /// 移除所有子视图
    func removeAllSubViews(){
        subviews.forEach { (view: UIView) in
            view.removeFromSuperview()
        }
    }
    /// 添加圆角
//    func addCorners(_ corners: UIRectCorner = .allCorners,
//                          cornerRadii: CGSize = CGSize(width: 8.0, height: 8.0),
//                          width: CGFloat = 1,
//                          color: UIColor = UIColor.gray) -> CAShapeLayer {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bounds
//        maskLayer.path = path.cgPath
//        maskLayer.borderWidth = width
//        maskLayer.borderColor = color.cgColor
//        layer.mask = maskLayer
//        return maskLayer
//    }
    
//    /// 高性能圆角
//    func drawCorners(_ radius: CGFloat, width: CGFloat, color: UIColor, bgColor: UIColor) {
//        let image = drawCorners( .allCorners, radius: radius, width: width, color: color, bgColor: bgColor)
//        let imgView = UIImageView(image: image)
//        insertSubview(imgView, at: 0)
//    }
    
    /// [源]高性能圆角
//    func drawCorners(_ corners: UIRectCorner = UIRectCorner.allCorners,
//                           radius: CGFloat,
//                           width: CGFloat,
//                           color: UIColor,
//                           bgColor: UIColor) -> UIImage? {
//        UIGraphicsBeginImageContextWithOptions(bounds.size, false, UIScreen.main.scale)
//        let ctx = UIGraphicsGetCurrentContext()
//
//        ctx?.setLineWidth(width)
//        ctx?.setStrokeColor(color.cgColor)
//        ctx?.setFillColor(bgColor.cgColor)
//
//        let halfBorderWidth = width/2.0
//        let point0 = CGPointMake(bounds.width - halfBorderWidth, radius + halfBorderWidth)
//        let point1 = CGPointMake(bounds.width - halfBorderWidth, bounds.height - halfBorderWidth)
//        let point2 = CGPointMake(bounds.width - radius - halfBorderWidth, bounds.height - halfBorderWidth)
//        let point3 = CGPointMake(halfBorderWidth, halfBorderWidth)
//        let point4 = CGPointMake(bounds.width - halfBorderWidth, halfBorderWidth)
//        let point5 = CGPointMake(bounds.width - halfBorderWidth, halfBorderWidth)
//        let point6 = CGPointMake(bounds.width - halfBorderWidth, radius + halfBorderWidth)
//
//        ctx?.move(to: point0)
//        ctx?.addArc(tangent1End: point1, tangent2End: point2, radius: radius)
//        ctx?.addArc(tangent1End: point3, tangent2End: point4, radius: radius)
//        ctx?.addArc(tangent1End: point5, tangent2End: point6, radius: radius)
//
//        ctx?.drawPath(using: .fillStroke)
//        let image = UIGraphicsGetImageFromCurrentImageContext()
//        UIGraphicsEndImageContext()
//        return image
//    }
    
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    func addGestureTap(_ target: Any?, action: Selector?) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: target, action: action)
        obj.numberOfTapsRequired = 1  //轻点次数
        obj.numberOfTouchesRequired = 1  //手指个数

        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    func addGestureTap(_ action: @escaping ((UITapGestureRecognizer) ->Void)) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        obj.numberOfTapsRequired = 1  //轻点次数
        obj.numberOfTouchesRequired = 1  //手指个数

        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)

        obj.addAction(action)
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    func addGestureLongPress(_ target: Any?, action: Selector?, for minimumPressDuration: TimeInterval = 0.5) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: target, action: action)
        obj.minimumPressDuration = minimumPressDuration
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    func addGestureLongPress(_ action: @escaping ((UILongPressGestureRecognizer) ->Void), for minimumPressDuration: TimeInterval = 0.5) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer as! UILongPressGestureRecognizer)
        }
        return obj
    }
      
    ///手势 - 拖拽 UIPanGestureRecognizer
    @discardableResult
    func addGesturePan(_ action: @escaping ((UIPanGestureRecognizer) ->Void)) -> UIPanGestureRecognizer {
        let obj = UIPanGestureRecognizer(target: nil, action: nil)
          //最大最小的手势触摸次数
        obj.minimumNumberOfTouches = 1
        obj.maximumNumberOfTouches = 3
          
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let gesture = recognizer as? UIPanGestureRecognizer {
                let translate: CGPoint = gesture.translation(in: gesture.view?.superview)
                gesture.view!.center = CGPoint(x: gesture.view!.center.x + translate.x, y: gesture.view!.center.y + translate.y)
                gesture.setTranslation( .zero, in: gesture.view!.superview)
                             
                action(gesture)
            }
        }
        return obj
    }
      
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    func addGestureEdgPan(_ action: @escaping ((UIScreenEdgePanGestureRecognizer) ->Void), for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
       
        obj.addAction { (recognizer) in
            action(recognizer as! UIScreenEdgePanGestureRecognizer)
        }
        return obj
    }
      
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: target, action: action)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    func addGestureSwip(_ action: @escaping ((UISwipeGestureRecognizer) ->Void), for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: nil, action: nil)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer as! UISwipeGestureRecognizer)
        }
        return obj
    }
      
    ///手势 - 捏合 UIPinchGestureRecognizer
    @discardableResult
    func addGesturePinch(_ action: @escaping ((UIPinchGestureRecognizer) ->Void)) -> UIPinchGestureRecognizer {
        let obj = UIPinchGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let gesture = recognizer as? UIPinchGestureRecognizer {
                let location = recognizer.location(in: gesture.view!.superview)
                gesture.view!.center = location
                gesture.view!.transform = gesture.view!.transform.scaledBy(x: gesture.scale, y: gesture.scale)
                gesture.scale = 1.0
                action(gesture)
            }
        }
        return obj
    }
    
    ///手势 - 旋转 UIRotationGestureRecognizer
    @discardableResult
    func addGestureRotation(_ action: @escaping ((UIRotationGestureRecognizer) ->Void)) -> UIRotationGestureRecognizer {
        let obj = UIRotationGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let gesture = recognizer as? UIRotationGestureRecognizer {
                gesture.view!.transform = gesture.view!.transform.rotated(by: gesture.rotation)
                gesture.rotation = 0.0
                          
                action(gesture)
            }
        }
        return obj
    }

    ///呈现到 UIApplication.shared.keyWindow 上
    func show(_ animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        if keyWindow.subviews.contains(self) {
            self.dismiss()
        }
        
        if self.frame.equalTo(.zero) {
            self.frame = UIScreen.main.bounds
        }
        
        keyWindow.endEditing(true)
        keyWindow.addSubview(self)

//        self.transform = self.transform.scaledBy(x: 1.5, y: 1.5)
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.3)
//            self.transform = CGAffineTransform.identity
            
        }, completion: completion)
    }
    ///从 UIApplication.shared.keyWindow 上移除
    func dismiss(_ animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0)
//            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)

        }) { (isFinished) in
            completion?(isFinished)
            self.removeFromSuperview()
        }
    }
    
    /// 获取特定类型父视图
    func findSupView(_ type: UIView.Type) -> UIView? {
        var supView = superview
        while supView != nil {
            if supView!.isKind(of: type) {
                return supView
            }
            supView = supView?.superview
        }
        return nil
    }
        
    /// 获取特定类型子视图
    func findSubView(_ type: UIView.Type) -> UIView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element
            }
        }
        return nil
    }
//    ///获取下一级别响应者
//    func nextResponder(_ type: AnyClass, isPrint: Bool = false) -> NSObject? {
//        var nextResponder: UIResponder? = self
//        while nextResponder != nil {
//            if let window = nextResponder as? UIWindow {
//                return window
//            }
//            nextResponder = nextResponder?.next
//            if isPrint && nextResponder != nil {
//                print("responder - \(nextResponder!)")
//            }
//        }
//        return nil
//    }

    func findViewController() -> UIViewController? {
        if let nextResponder = self.next as? UIViewController {
            return nextResponder
        } else if let nextResponder = self.next as? UIView {
            return nextResponder.findViewController()
        } else {
            return nil
        }
    }
    
    ///往复动画
    func animationCycle(_ transformBlock: @escaping ((CGAffineTransform) -> Void), animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, animations: {
            if self.transform.isIdentity == true {
                transformBlock(self.transform)
            } else {
                self.transform = CGAffineTransform.identity
            }
        }, completion: completion)
    }
    
    ///移动动画
    func move(_ x: CGFloat, y: CGFloat, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, animations: {
            if self.transform.isIdentity == true {
                self.transform = self.transform.translatedBy(x: x, y: y)
            } else {
                self.transform = CGAffineTransform.identity
            }
        }, completion: completion)
    }
    
    ///旋转动画
    func rotate(_ angle: CGFloat, animated: Bool, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.3 : 0
        UIView.animate(withDuration: duration, animations: {
            if self.transform.isIdentity == true {
                self.transform = self.transform.rotated(by: angle)
            } else {
                self.transform = CGAffineTransform.identity
            }

        }, completion: completion)
    }
    ///转为图像
    func convertToImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        self.layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!
    }
    
    func snapshotImage() -> UIImage?{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        defer {
            UIGraphicsEndImageContext()
        }
        
        guard let ctx = UIGraphicsGetCurrentContext() else { return nil }
        // 截图:实际是把layer上面的东西绘制到上下文中
        layer.render(in: ctx)
//        self.drawHierarchy(in: self.frame, afterScreenUpdates: true)
        guard let image = UIGraphicsGetImageFromCurrentImageContext() else { return nil }
        // 保存相册
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil)
        return image
    }
    
    func snapshotImageAfterScreenUpdates(_ afterUpdates: Bool) -> UIImage?{
        if !self.responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))) {
            return self.snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates)
        let snap = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap
    }
        
    /// 保存图像到相册
    func imageToSavedPhotosAlbum(_ action: @escaping((NSError?) -> Void)) {
        var image: UIImage = self.convertToImage()
        if let imgView = self as? UIImageView {
            if imgView.image != nil {
                image = imgView.image!
            }
        }
        //保存相册
        image.toSavedPhotoAlbum { (error) in
            action(error)
        }
    }

    /// 插入模糊背景
    func insertVisualEffectView(style: UIBlurEffect.Style = .light) -> UIVisualEffectView {
        let blurView = UIVisualEffectView(effect: UIBlurEffect(style: style))
        blurView.frame = self.bounds
        blurView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        insertSubview(blurView, at: 0)
        return blurView
    }
}


public extension UIView{
    
    /// 获取特定类型父视图
    final func supView<T: UIView>(_ type: T.Type) -> T? {
        var supView = superview
        while supView?.isKind(of: type.self) == false {
            supView = supView?.superview
        }
        return supView.self as? T
    }
        
    /// 获取特定类型子视图
    final func subView<T: UIView>(_ type: T.Type) -> T? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return (e.element.self as! T)
            }
        }
        return nil
    }
}

public extension Array where Element : UIView {
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    func addGestureTap(_ action: @escaping ((UIGestureRecognizer) ->Void)) -> [UITapGestureRecognizer] {
        
        var list = [UITapGestureRecognizer]()
        forEach {
            let obj = $0.addGestureTap(action)
            list.append(obj)
        }
        return list
    }
}

