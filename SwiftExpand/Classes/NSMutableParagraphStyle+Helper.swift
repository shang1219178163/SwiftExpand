//
//  NSMutableParagraphStyle+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/4/25.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

@objc public extension NSMutableParagraphStyle{
    
    func lineSpacing(_ value: CGFloat) -> Self {
        self.lineSpacing = value
        return self
    }
    
    func paragraphSpacing(_ value: CGFloat) -> Self {
        self.paragraphSpacing = value
        return self
    }
    
    func alignment(_ value: NSTextAlignment) -> Self {
        self.alignment = value
        return self
    }
    
    func firstLineHeadIndent(_ value: CGFloat) -> Self {
        self.firstLineHeadIndent = value
        return self
    }
    
    func headIndent(_ value: CGFloat) -> Self {
        self.headIndent = value
        return self
    }
    
    func tailIndent(_ value: CGFloat) -> Self {
        self.tailIndent = value
        return self
    }
    
    func lineBreakMode(_ value: NSLineBreakMode) -> Self {
        self.lineBreakMode = value
        return self
    }
    
    func minimumLineHeight(_ value: CGFloat) -> Self {
        self.minimumLineHeight = value
        return self
    }
    
    func maximumLineHeight(_ value: CGFloat) -> Self {
        self.maximumLineHeight = value
        return self
    }
    
    func baseWritingDirection(_ value: NSWritingDirection) -> Self {
        self.baseWritingDirection = value
        return self
    }
    
    func lineHeightMultiple(_ value: CGFloat) -> Self {
        self.lineHeightMultiple = value
        return self
    }
    
    func paragraphSpacingBefore(_ value: CGFloat) -> Self {
        self.paragraphSpacingBefore = value
        return self
    }
    
    func hyphenationFactor(_ value: Float) -> Self {
        self.hyphenationFactor = value
        return self
    }
    
    func tabStops(_ value: [NSTextTab]) -> Self {
        self.tabStops = value
        return self
    }
    
    func defaultTabInterval(_ value: CGFloat) -> Self {
        self.defaultTabInterval = value
        return self
    }
    
    func allowsDefaultTighteningForTruncation(_ value: Bool) -> Self {
        self.allowsDefaultTighteningForTruncation = value
        return self
    }
    
    func lineBreakStrategy(_ value: NSParagraphStyle.LineBreakStrategy) -> Self {
        self.lineBreakStrategy = value
        return self
    }
        
    func addTabStopChain(_ value: NSTextTab) -> Self {
        self.addTabStop(value)
        return self
    }
    
    func removeTabStopChain(_ value: NSTextTab) -> Self {
        self.removeTabStop(value)
        return self
    }
    
    func setParagraphStyleChain(_ value: NSParagraphStyle) -> Self {
        self.setParagraphStyle(value)
        return self
    }
}

