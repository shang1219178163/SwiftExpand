//
//  UITableViewCell+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/9/2.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

@objc extension UITableViewCell{

    override public class func initializeMethod() {
        super.initializeMethod();
        
        if self != UITableViewCell.self {
            return
        }

        let onceToken = "Hook_\(NSStringFromClass(classForCoder()))";
        DispatchQueue.once(token: onceToken) {
            let oriSel = NSSelectorFromString("layoutSubviews")
            let repSel = #selector(self.hook_layoutSubviews)
            _ = hookInstanceMethod(of: oriSel, with: repSel);
        }
    }
    
    private func hook_layoutSubviews() {
        hook_layoutSubviews()
        
        positionAccessoryView()
    }
    
}
