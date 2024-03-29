//
//  NSBezierPath+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2020/3/29.
//  Copyright © 2020 Bin Shang. All rights reserved.
//

import AppKit

extension NSBezierPath {
    /// 自定义方法
    public var cgPath: CGPath {
        let path = CGMutablePath()
        var points = [CGPoint](repeating: .zero, count: 3)
        
        for i in 0 ..< self.elementCount {
            let type = self.element(at: i, associatedPoints: &points)
            switch type {
            case .moveTo:
                path.move(to: points[0])
            case .lineTo:
                path.addLine(to: points[0])
            case .curveTo:
                path.addCurve(to: points[2], control1: points[0], control2: points[1])
            case .closePath:
                path.closeSubpath()
            @unknown default:
                fatalError()
            }
        }
        return path
    }
}
