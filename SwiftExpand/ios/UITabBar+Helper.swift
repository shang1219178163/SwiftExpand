//
//  UITabBar+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2018 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UITabBar {
         
    func setColor(_ color: UIColor, background: UIColor) {
        if #available(iOS 13, *) {
            let appearance = UITabBarAppearance.create(color, background: background)
            standardAppearance = appearance
            if #available(iOS 15, *) {
                scrollEdgeAppearance = appearance
            }
        }
    }
    
}


public extension UITabBar{
    
    ///刷新 items
    func reloadTabarItems(_ list: [(String, UIImage?, UIImage?)]) {
        self.items = list.map({ (title, image, imageH) -> UITabBarItem in
            if let image = image?.withRenderingMode(.alwaysOriginal),
               let imageH = imageH?.withRenderingMode(.alwaysTemplate) {
                return UITabBarItem(title: title, image: image, selectedImage: imageH)
            }
            return UITabBarItem(title: title, image: nil, selectedImage: nil)
        })
    }
}


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


@available(iOS 13.0, *)
@objc public extension UITabBarAppearance{
    
    /// 创建
    static func create(_ color: UIColor, background: UIColor) -> UITabBarAppearance {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = background
        appearance.selectionIndicatorTintColor = color

        let itemAppearance = UITabBarItemAppearance.create([.foregroundColor: UIColor.gray], selectedAttrs: [.foregroundColor: color])
        appearance.stackedLayoutAppearance = itemAppearance
        return appearance
    }

}


@available(iOS 13.0, *)
@objc public extension UITabBarItemAppearance{
    
    /// 创建
    static func create(_ normalAttrs: [NSAttributedString.Key: Any], selectedAttrs: [NSAttributedString.Key: Any]) -> UITabBarItemAppearance {
        let appearance = UITabBarItemAppearance()
        appearance.normal.titleTextAttributes = normalAttrs
        appearance.selected.titleTextAttributes = selectedAttrs

        return appearance
    }
    
}


