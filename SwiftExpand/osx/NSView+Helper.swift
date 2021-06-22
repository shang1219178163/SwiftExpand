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
    
    var size: CGSize  {
        get {
            return frame.size
        }
        set{
            var rectTmp = frame
            rectTmp.size = newValue
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
//            frame.origin.y = newValue
            var rectTmp = frame
            rectTmp.origin.y = newValue
            frame = rectTmp
        }
    }
    
    var origin: CGPoint {
        get {
            return frame.origin
        }
        set {
//            frame.origin = newValue
            var rectTmp = frame
            rectTmp.origin = newValue
            frame = rectTmp
        }
    }
    
    var minX: CGFloat {
        return frame.minX
    }
    
    var minY: CGFloat {
        return frame.minY
    }
    
    var midX: CGFloat {
        return frame.midX
    }
    
    var midY: CGFloat {
        return frame.midY
    }
    
    var maxX: CGFloat {
        return frame.maxX
    }
    
    var maxY: CGFloat {
        return frame.maxY
    }

    /// 图层调试
    func getViewLayer() {
        #if DEBUG
        for subview in subviews {
            subview.layer?.borderWidth = kW_LayerBorder
            subview.layer?.borderColor = NSColor.blue.cgColor
            subview.getViewLayer()
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
    
    ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    func addGestureClick(_ action: @escaping ((NSClickGestureRecognizer) -> Void)) -> NSClickGestureRecognizer {
        let obj = NSClickGestureRecognizer()
        obj.addAction(action)

        addGestureRecognizer(obj)
        return obj
    }
}
