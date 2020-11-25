//
//  UIView+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/14.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc extension UIView{
    
    public var sizeWidth: CGFloat {
        get {
            return frame.size.width
        }
        set {
//            frame.size.width = newValue
            var rectTmp = frame;
            rectTmp.size.width = newValue;
            frame = rectTmp;
        }
    }
    
    public var sizeHeight: CGFloat {
        get {
            return frame.size.height
        }
        set {
//            frame.size.height = newValue
            var rectTmp = frame;
            rectTmp.size.height = newValue;
            frame = rectTmp;
        }
    }
        
    public var originX: CGFloat {
        get {
            return frame.origin.x
        }
        set {
//            frame.origin.x = newValue
            var rectTmp = frame;
            rectTmp.origin.x = newValue;
            frame = rectTmp;
        }
    }
    
    public var originY: CGFloat {
        get {
            return frame.origin.y
        }
        set {
//            frame.origin.y = newValue
            var rectTmp = frame;
            rectTmp.origin.y = newValue;
            frame = rectTmp;
        }
    }
    
    public var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
//            frame.origin = newValue
            var rectTmp = frame;
            rectTmp.origin = newValue;
            frame = rectTmp;
        }
    }
    
    public var minX: CGFloat {
        return frame.minX
    }
    
    public var minY: CGFloat {
        return frame.minY
    }
    
    public var midX: CGFloat {
        return frame.midX
    }
    
    public var midY: CGFloat {
        return frame.midY
    }
    
    public var maxX: CGFloat {
        return frame.maxX
    }
    
    public var maxY: CGFloat {
        return frame.maxY
    }
    
    //MARK: -funtions
    
    /// 图层调试
    public func getViewLayer(lineColor: UIColor = .blue) {
        #if DEBUG
            let subviews = self.subviews;
            if subviews.count == 0 {
                return;
            }
            for subview in subviews {
                subview.layer.borderWidth = kW_LayerBorder;
                subview.layer.borderColor = lineColor.cgColor;
                subview.getViewLayer(lineColor: lineColor)
            }
         #endif
    }
    
    /// 图层调试(兼容OC)
    public func getViewLayer() {
        #if DEBUG
        let subviews = self.subviews;
        if subviews.count == 0 {
            return;
        }
        for subview in subviews {
            subview.layer.borderWidth = kW_LayerBorder;
            subview.layer.borderColor = UIColor.blue.cgColor;
            subview.getViewLayer();
        }
        #endif
    }
    
    /// 寻找子视图
    public func findSubview(type: UIResponder.Type, resursion: Bool)-> UIView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element;
            }
        }
        
        if resursion == true {
            for e in self.subviews.enumerated() {
                let tmpView = e.element.findSubview(type: type, resursion: resursion)
                if tmpView != nil {
                    return tmpView;
                }
            }
        }
        return nil;
    }
    
    /// 移除所有子视图
    public func removeAllSubViews(){
        subviews.forEach { (view: UIView) in
            view.removeFromSuperview()
        }
    }
    /// 添加圆角
//    public func addCorners(_ corners: UIRectCorner = .allCorners,
//                          cornerRadii: CGSize = CGSize(width: 8.0, height: 8.0),
//                          width: CGFloat = 1,
//                          color: UIColor = UIColor.gray) -> CAShapeLayer {
//        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: cornerRadii)
//        let maskLayer = CAShapeLayer()
//        maskLayer.frame = bounds
//        maskLayer.path = path.cgPath
//        maskLayer.borderWidth = width
//        maskLayer.borderColor = color.cgColor
//        layer.mask = maskLayer;
//        return maskLayer
//    }
    
//    /// 高性能圆角
//    public func drawCorners(_ radius: CGFloat, width: CGFloat, color: UIColor, bgColor: UIColor) {
//        let image = drawCorners( .allCorners, radius: radius, width: width, color: color, bgColor: bgColor)
//        let imgView = UIImageView(image: image)
//        insertSubview(imgView, at: 0)
//    }
    
    /// [源]高性能圆角
//    public func drawCorners(_ corners: UIRectCorner = UIRectCorner.allCorners,
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
    
    //MARK: -通用响应添加方法
    public func addActionClosure(_ action: @escaping ViewClosure) {
        if let sender = self as? UIButton {
            sender.addActionHandler({ (control) in
                action(nil, control, control.tag);

            }, for: .touchUpInside)
        }
        else if let sender = self as? UIControl {
            sender.addActionHandler({ (control) in
                action(nil, control, control.tag);

            }, for: .valueChanged)
            
        } else {
            _ = self.addGestureTap { (reco) in
                action((reco as! UITapGestureRecognizer), reco.view!, reco.view!.tag);
            }
        }
    }
    
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    public func addGestureTap(_ target: Any?, action: Selector?) -> UITapGestureRecognizer {
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
    public func addGestureTap(_ action: @escaping RecognizerClosure) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        obj.numberOfTapsRequired = 1  //轻点次数
        obj.numberOfTouchesRequired = 1  //手指个数

        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)

        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    public func addGestureLongPress(_ target: Any?, action: Selector?, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: target, action: action)
        obj.minimumPressDuration = minimumPressDuration;
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    public func addGestureLongPress(_ action: @escaping RecognizerClosure, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration;
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 拖拽 UIPanGestureRecognizer
    @discardableResult
    public func addGesturePan(_ action: @escaping RecognizerClosure) -> UIPanGestureRecognizer {
        let obj = UIPanGestureRecognizer(target: nil, action: nil)
          //最大最小的手势触摸次数
        obj.minimumNumberOfTouches = 1
        obj.maximumNumberOfTouches = 3
          
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPanGestureRecognizer {
                let translate:CGPoint = sender.translation(in: sender.view?.superview)
                sender.view!.center = CGPoint(x: sender.view!.center.x + translate.x, y: sender.view!.center.y + translate.y)
                sender.setTranslation( .zero, in: sender.view!.superview)
                             
                action(recognizer)
            }
        }
        return obj
    }
      
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    public func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    public func addGestureEdgPan(_ action: @escaping RecognizerClosure, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
       
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    public func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: target, action: action)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    public func addGestureSwip(_ action: @escaping RecognizerClosure, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: nil, action: nil)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 捏合 UIPinchGestureRecognizer
    @discardableResult
    public func addGesturePinch(_ action: @escaping RecognizerClosure) -> UIPinchGestureRecognizer {
        let obj = UIPinchGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPinchGestureRecognizer {
                let location = recognizer.location(in: sender.view!.superview)
                sender.view!.center = location;
                sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale = 1.0
                action(recognizer)
            }
        }
        return obj
    }
    
    ///手势 - 旋转 UIRotationGestureRecognizer
    @discardableResult
    public func addGestureRotation(_ action: @escaping RecognizerClosure) -> UIRotationGestureRecognizer {
        let obj = UIRotationGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIRotationGestureRecognizer {
                sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
                sender.rotation = 0.0;
                          
                action(recognizer)
            }
        }
        return obj
    }

    ///呈现到 UIApplication.shared.keyWindow 上
    public func show(_ animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        guard let keyWindow = UIApplication.shared.keyWindow else { return }
        if keyWindow.subviews.contains(self) {
            self.dismiss()
        }
        
        if self.frame.equalTo(.zero) {
            self.frame = UIScreen.main.bounds
        }
        
        keyWindow.endEditing(true)
        keyWindow.addSubview(self);

//        self.transform = self.transform.scaledBy(x: 1.5, y: 1.5)
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0.3);
//            self.transform = CGAffineTransform.identity
            
        }, completion: completion);
    }
    ///从 UIApplication.shared.keyWindow 上移除
    public func dismiss(_ animated: Bool = true, completion: ((Bool) -> Void)? = nil) {
        let duration = animated ? 0.15 : 0
        UIView.animate(withDuration: duration, animations: {
            self.backgroundColor = UIColor.black.withAlphaComponent(0);
//            self.transform = self.transform.scaledBy(x: 0.5, y: 0.5)

        }) { (isFinished) in
            completion?(isFinished)
            self.removeFromSuperview();
        }
    }
    
    /// 获取特定类型父视图
    public func supView(_ type: UIView.Type) -> UIView? {
        var supView = superview
        while supView?.isKind(of: type) == false {
            supView = supView?.superview
        }
        return supView ?? nil
    }
        
    /// 获取特定类型子视图
    public func subView(_ type: UIView.Type) -> UIView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element
            }
        }
        return nil
    }
    ///获取下一级别响应者
    public func nextResponder(_ type: AnyClass, isPrint: Bool = false) -> NSObject? {
        var nextResponder: UIResponder? = self
        while nextResponder != nil {
            if let controller = nextResponder as? UIWindow {
                return controller
            }
            nextResponder = nextResponder?.next
            if isPrint && nextResponder != nil {
                print("responder - \(nextResponder!)")
            }
        }
        return nil
    }
    
    ///移动动画
    public func move(_ x: CGFloat, y: CGFloat, animated: Bool, completion: ((Bool) -> Void)? = nil) {
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
    public func rotate(_ angle: CGFloat, animated: Bool, completion: ((Bool) -> Void)? = nil) {
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
    public func convertToImage() -> UIImage{
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, false, UIScreen.main.scale)
        let ctx = UIGraphicsGetCurrentContext()
        self.layer.render(in: ctx!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        return image!;
    }
    
    public func snapshotImage() -> UIImage?{
        guard let context = UIGraphicsGetCurrentContext() else { return nil}
        
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.layer.render(in: context)
        let snap: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap ?? nil
    }
    
    public func snapshotImageAfterScreenUpdates(_ afterUpdates: Bool) -> UIImage?{
        if !self.responds(to: #selector(drawHierarchy(in:afterScreenUpdates:))) {
            return self.snapshotImage()
        }
        UIGraphicsBeginImageContextWithOptions(self.bounds.size, self.isOpaque, 0)
        self.drawHierarchy(in: self.bounds, afterScreenUpdates: afterUpdates)
        let snap: UIImage? = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return snap ?? nil
    }
        
    /// 保存图像到相册
    public func imageToSavedPhotosAlbum(_ action: @escaping((NSError?) -> Void)) {
        var image: UIImage = self.convertToImage();
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
    public func insertVisualEffectView() -> UIVisualEffectView {
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .light))
        effectView.frame = self.bounds
        self.insertSubview(effectView, at: 0)
        return effectView;
    }
    
}

extension Array where Element : UIView {
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    public func addGestureTap(_ action: @escaping RecognizerClosure) -> [UITapGestureRecognizer] {
        
        var list = [UITapGestureRecognizer]()
        forEach {
            let obj = $0.addGestureTap(action)
            list.append(obj)
        }
        return list
    }
}
