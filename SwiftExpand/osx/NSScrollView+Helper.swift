//
//  NSScrollView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//

import AppKit

@objc public extension NSScrollView {

    
    static func create(_ rect: CGRect) -> Self {
        let view = self.init(frame: rect)
        view.autoresizingMask = [.width, .height]
                      
        view.hasHorizontalScroller = false
        view.hasVerticalScroller = true
        view.autohidesScrollers = true
        
        view.drawsBackground = true
        return view
    }
    
    func scrollToTop() {
        guard let documentView = documentView else { return }

        if isFlipped == true {
            documentView.scroll(.zero)
        } else {
            let maxHeight = max(bounds.height, documentView.bounds.height)
            documentView.scroll(CGPoint(x: 0, y: maxHeight))
        }
    }
    
}
