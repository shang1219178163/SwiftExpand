//
//  NSSegmentedControl+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSSegmentedControl {
    private struct AssociateKeys {
        static var items   = "NSSegmentedControl" + "items"
        static var closure = "NSSegmentedControl" + "closure"
    }
    
    var items: [String] {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.items) as? [String] {
                return obj
            }
            return [String]()
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.items, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            updateItems(newValue)
        }
    }
        
    func addActionHandler(_ handler: @escaping ((NSSegmentedControl) -> Void), trackingMode: NSSegmentedControl.SwitchTracking) {
        target = self
        action = #selector(p_invokeSegmentedCtl(_:))
        self.trackingMode = trackingMode
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    private func p_invokeSegmentedCtl(_ sender: NSSegmentedControl) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSSegmentedControl) -> Void) {
            handler(sender)
        }
    }
        
    /// 配置新item数组
    private func updateItems(_ items: [String]) {
        if items.count == 0 {
            return
        }
        segmentCount = items.count
        selectedSegment = 0
        for e in items.enumerated() {
            self.setLabel(e.element, forSegment: e.offset)
        }
    }
    
    static func create(_ rect: NSRect, items: [Any]) -> Self {
        let sender = self.init(frame: rect)
        sender.segmentStyle = .texturedRounded
        sender.trackingMode = .momentary
        
        sender.segmentCount = items.count
        
        let width: CGFloat = rect.width/CGFloat(sender.segmentCount)
        for e in items.enumerated() {
            if e.element is NSImage {
                sender.setImage((e.element as! NSImage), forSegment: e.offset)
            } else {
                sender.setLabel(e.element as! String, forSegment: e.offset)
            }
            sender.setWidth(width, forSegment: e.offset)
        }
        return sender
    }
    
}
