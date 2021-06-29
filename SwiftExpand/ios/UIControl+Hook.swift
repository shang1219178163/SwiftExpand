
//
//  UIButton+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/9/19.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit


@objc extension UIControl{
    override public class func initializeMethod() {
        super.initializeMethod()
                        
        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))"
        DispatchQueue.once(token: onceToken) {
            let oriSel = #selector(self.addTarget(_:action:for:))
            let repSel = #selector(self.hook_addTarget(_:action:for:))
            hookInstanceMethod(of: oriSel, with: repSel)
        }
    }
    
    private func hook_addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event){
//        handleTracker(target, action: action, for: controlEvents)
        hook_addTarget(target, action: action, for: controlEvents)
    }
    
    private func handleTracker(_ target: Any, action: Selector, for controlEvents: UIControl.Event) {
        switch self {
        case let sender as UIButton:
            DDLog(sender.currentTitle ?? sender.image(for: .normal)?.assetName)

        case let sender as UISegmentedControl:
            DDLog(sender.selectedSegmentIndex)

        case let sender as UISwitch:
            DDLog(sender.isOn)

        default:
            break
        }
    }
}


@objc extension UIGestureRecognizer{
    
    override public class func initializeMethod() {
        super.initializeMethod()
        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))"
        //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
        DispatchQueue.once(token: onceToken) {
            let oriSel = #selector(self.init(target:action:))
            let repSel = #selector(self.hook_init(target:action:))
            hookInstanceMethod(of: oriSel, with: repSel)
            
            let oriSel1 = #selector(self.addTarget(_:action:))
            let repSel1 = #selector(self.hook_addTarget(_:action:))
            hookInstanceMethod(of: oriSel1, with: repSel1)
        }
        
    }
    
    private func hook_init(target: Any?, action: Selector?){
//        handleTracker(target: target, action: action)
        hook_init(target: target, action: action)
    }

    private func hook_addTarget(_ target: Any, action: Selector) {
//        handleTracker(target: target, action: action)
        hook_addTarget(target, action: action)
    }
    
    private func handleTracker(target: Any, action: Selector){
        switch self {
        case let sender as UITapGestureRecognizer:
            DDLog(sender)

        case let sender as UILongPressGestureRecognizer:
            DDLog(sender)

        case let sender as UISwipeGestureRecognizer:
            DDLog(sender)

        default:
            DDLog("\(type(of: self))未埋点处理")
            break
        }
    }
}
