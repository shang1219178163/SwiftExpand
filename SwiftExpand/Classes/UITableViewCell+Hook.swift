//
//  UITableViewCell+Hook.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/9/2.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

@objc extension UITableViewCell{
    private struct AssociateKeys {
        static var assoryOffSet   = "UITableViewCell" + "assoryOffSet"
    }
    
    public var assoryOffSet: UIOffset {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.assoryOffSet) as? UIOffset {
                return obj
            }

            let offset = UIOffset(horizontal: 0, vertical: 0);
            
            objc_setAssociatedObject(self, &AssociateKeys.assoryOffSet, offset, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            return offset
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.assoryOffSet, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    
    // MARK: -lifecycle
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
        
        positionAccessoryView(assoryOffSet.horizontal, dy: assoryOffSet.vertical)
    }
    
}
