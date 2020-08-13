
//
//  UIButton+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/9/19.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc extension UIButton{
    override public class func initializeMethod() {
        super.initializeMethod();
        
        if self != UIButton.self {
            return
        }
                
        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
        DispatchQueue.once(token: onceToken) {
            let oriSel = #selector(setBackgroundImage(_:for:))
            let repSel = #selector(hook_setBackgroundImage(_:for:))
            _ = hookInstanceMethod(of: oriSel, with: repSel);
            
            let oriSel1 = #selector(setImage(_:for:))
            let repSel1 = #selector(hook_setImage(_:for:))
            _ = hookInstanceMethod(of: oriSel1, with: repSel1);
            
            let oriSel2 = #selector(self.addTarget(_:action:for:))
            let repSel2 = #selector(self.hook_addTarget(_:action:for:))
            _ = hookInstanceMethod(of: oriSel2, with: repSel2)
            
        }
    }
    
    private func hook_setBackgroundImage(_ image: UIImage?, for state: UIControl.State){
        //需要注入的代码写在此处
        hook_setBackgroundImage(image, for: state);
        if image != nil {
            adjustsImageWhenHighlighted = false;
        }
    }
    
    private func hook_setImage(_ image: UIImage?, for state: UIControl.State){
        //需要注入的代码写在此处
        hook_setImage(image, for: state);
        if image != nil {
            adjustsImageWhenHighlighted = false;
        }
    }
    
    private func hook_addTarget(_ target: Any?, action: Selector, for controlEvents: UIControl.Event){
        self.hook_addTarget(target, action: action, for: controlEvents)
        DDLog(action)
    }
}

@objc extension UITapGestureRecognizer{
    
    override public class func initializeMethod() {
        super.initializeMethod()
        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
        //DispatchQueue函数保证代码只被执行一次，防止又被交换回去导致得不到想要的效果
        DispatchQueue.once(token: onceToken) {
            let oriSel = #selector(self.init(target:action:))
            let repSel = #selector(self.hook_init(target:action:))
            _ = hookInstanceMethod(of: oriSel, with: repSel)
            
            let oriSel1 = #selector(self.addTarget(_:action:))
            let repSel1 = #selector(self.hook_addTarget(_:action:))
            _ = hookInstanceMethod(of: oriSel1, with: repSel1)
        }
        
    }
    
    private func hook_init(target: Any?, action: Selector?){
        self.hook_init(target: target, action: action)
        
        DDLog(action)
    }

    private func hook_addTarget(_ target: Any, action: Selector) {
        self.hook_addTarget(target, action: action)
        
        DDLog(action)
    }
    
    
}
