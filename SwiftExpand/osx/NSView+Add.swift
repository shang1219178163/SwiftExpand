//
//  NSView+Add.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import AppKit

@objc public extension NSView {
    private struct AssociateKeys {
        static var lineTop       = "NSView" + "lineTop"
        static var lineBottom    = "NSView" + "lineBottom"
        static var lineRight     = "NSView" + "lineRight"
        static var gradientLayer = "NSView" + "gradientLayer"
    }
    ///视图方向(上左下右)
    enum Direction: Int {
        case top
        case left
        case bottom
        case right
        case center
    }

    ///视图角落(左上,左下,右上,右下)
    enum Location: Int {
        case none
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: frame.origin.x + frame.size.width*0.5,
                           y: frame.origin.y + frame.size.height*0.5)
        }
        set {
            self.frame = CGRect(x: newValue.x - frame.size.width*0.5,
                                y: newValue.y - frame.size.height*0.5,
                                width: frame.size.width,
                                height: frame.size.height)
        }
    }
    
    var lineTop: NSView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lineTop) as? NSView {
                return obj
            }
            let obj = NSView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW))
            obj.layer?.backgroundColor = NSColor.line.cgColor
            objc_setAssociatedObject(self, &AssociateKeys.lineTop, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return obj
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lineTop, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
     
    var lineBottom: NSView {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.lineBottom) as? NSView {
                return obj
            }
            let obj = NSView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW))
            obj.layer?.backgroundColor = NSColor.line.cgColor
            objc_setAssociatedObject(self, &AssociateKeys.lineBottom, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
            return obj
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.lineBottom, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC)
        }
    }
    
}


public extension NSView{
    
    ///更新各种子视图
    @discardableResult
    final func updateItems<T: NSControl>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
        if count == 0 {
            subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }
            return []
        }
        
        if let list = self.subviews.filter({ $0.isMember(of: type) }) as? [T], list.count == count {
            list.forEach { hanler($0) }
            return list
        }
        
        subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }

        var array: [T] = []
        for i in 0..<count {
            let sender = type.init(frame: .zero)
            sender.tag = i
            self.addSubview(sender)
            array.append(sender)
            
            hanler(sender)
        }
        return array
    }
    
}

