//
//  NSView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSView {
    
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

    /// 图层调试
    func getViewLayer(_ lineColor: NSColor = NSColor.blue) {
        #if DEBUG
        for subview in subviews {
            subview.layer?.borderWidth = kW_LayerBorder
            subview.layer?.borderColor = lineColor.cgColor
            subview.getViewLayer(lineColor)
         }
        #endif
     }
    /// 寻找子视图
    func findSubview(type: NSResponder.Type, resursion: Bool)-> NSView? {
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
    
    /// 获取特定类型父视图
    func findSupView(_ type: NSView.Type) -> NSView? {
        var supView = superview
        while supView?.isKind(of: type) == false {
            supView = supView?.superview
        }
        return supView ?? nil
    }
    
    /// 获取特定类型子视图
    func findSubView(_ type: NSView.Type) -> NSView? {
        for e in self.subviews.enumerated() {
            if e.element.isKind(of: type) {
                return e.element
            }
        }
        return nil
    }
    
    /// 插入模糊背景
    func addVisualEffectView(_ rect: CGRect = .zero) -> NSVisualEffectView {
        let tmpRect = CGRect.zero.equalTo(rect) == false ? rect : self.bounds
        let effectView = NSVisualEffectView(frame: tmpRect)
        effectView.blendingMode = .behindWindow
        effectView.state = .active
//        effectView.appearance = NSAppearance(named: .vibrantDark)
        if #available(OSX 10.14, *) {
            effectView.material = .underWindowBackground
        }
        addSubview(effectView)
        return effectView
    }
    
    ///手势 - 轻点 NSTapGestureRecognizer
    @discardableResult
    func addGestureClick(_ action: @escaping ((NSClickGestureRecognizer)->Void)) -> NSClickGestureRecognizer {
        let obj = NSClickGestureRecognizer()
        obj.addAction(action)

        addGestureRecognizer(obj)
        return obj
    }
    
    
    ///手势 - 长按 NSPressGestureRecognizer
    @discardableResult
    func addGesturePress(_ action: @escaping ((NSPressGestureRecognizer) ->Void), for minimumPressDuration: TimeInterval = 0.5) -> NSPressGestureRecognizer {
        let obj = NSPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer as! NSPressGestureRecognizer)
        }
        return obj
    }
      
    ///手势 - 拖拽 NSPanGestureRecognizer
    @discardableResult
    func addGesturePan(_ action: @escaping ((NSPanGestureRecognizer) ->Void)) -> NSPanGestureRecognizer {
        let obj = NSPanGestureRecognizer(target: nil, action: nil)
        addGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let gesture = recognizer as? NSPanGestureRecognizer {
                let translate: CGPoint = gesture.translation(in: gesture.view?.superview)
                gesture.view!.center = CGPoint(x: gesture.view!.center.x + translate.x, y: gesture.view!.center.y + translate.y)
                gesture.setTranslation( .zero, in: gesture.view!.superview)
                             
                action(gesture)
            }
        }
        return obj
    }
      

    ///手势 - 捏合 NSMagnificationGestureRecognizer
    @discardableResult
    func addGesturePinch(_ action: @escaping ((NSMagnificationGestureRecognizer) ->Void), for magnification: CGFloat = 0.5) -> NSMagnificationGestureRecognizer {
        let obj = NSMagnificationGestureRecognizer(target: nil, action: nil)
        obj.magnification = magnification
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer as! NSMagnificationGestureRecognizer)
        }
        return obj
    }
        
    ///手势 - 旋转 NSRotationGestureRecognizer
    @discardableResult
    func addGestureRotation(_ action: @escaping ((NSRotationGestureRecognizer) ->Void)) -> NSRotationGestureRecognizer {
        let obj = NSRotationGestureRecognizer(target: nil, action: nil)
        addGestureRecognizer(obj)

        obj.addAction { (recognizer) in
            if let gesture = recognizer as? NSRotationGestureRecognizer {
                gesture.view!.layer!.setAffineTransform(gesture.view!.layer!.affineTransform().rotated(by: gesture.rotation))
                gesture.rotation = 0.0
                action(gesture)
            }
        }
        return obj
    }
}
