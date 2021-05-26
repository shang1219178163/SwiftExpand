//
//  NSVisualEffectView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/26.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSVisualEffectView {
        
    // MARK: -funtions
    static func create(_ rect: CGRect = .zero) -> NSVisualEffectView {
        let effectView = NSVisualEffectView(frame: rect)
        effectView.blendingMode = .behindWindow
        effectView.state = .active
//        effectView.appearance = NSAppearance(named: .vibrantDark)
        if #available(OSX 10.14, *) {
            effectView.material = .underWindowBackground
        }
        return effectView;
    }
    
}
