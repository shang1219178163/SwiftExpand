//
//  UITabBarController+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/2/13.
//

import UIKit
import Foundation

@objc public extension UITabBarController{
    ///当前选择索引
    static var selectedIdx: Int {
        guard let keyWindow = UIApplication.shared.keyWindow,
              let rootController = keyWindow.rootViewController as? UITabBarController else { return 0}
        return rootController.selectedIndex
    }

    /// 获取私有类视图
    func getSubviewsForName(_ name: String) -> [UIView] {
        var marr: [UIView] = []
        tabBar.subviews.forEach { (view) in
            if view.isKind(of: NNClassFromString(name)!) {
                marr.append(view)
            }
        }
        return marr
    }
    
    func setTabBarVisible(_ visible: Bool, animated: Bool) {
        
        // bail if the current state matches the desired state
        let isVisible = tabBar.frame.origin.y < UIScreen.main.bounds.height
        guard (isVisible != visible) else { return }
        
        // get a frame calculation ready
        let frame = tabBar.frame
        let height = frame.size.height
        let offsetY = (visible ? -height : height)
        
        // zero duration means no animation
        let duration: TimeInterval = (animated ? 0.3 : 0.0)
        
        //  animate the tabBar
        UIView.animate(withDuration: duration) {
            self.tabBar.frame = frame.offsetBy(dx: 0, dy: offsetY)
            
            var rect = self.view.frame
            rect.size.height += offsetY
            self.view.frame = rect
            
            self.view.setNeedsDisplay()
            self.view.layoutIfNeeded()
        }
    }
}
