//
//  UITabBar+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/2.
//

import UIKit

@objc public extension UITabBar {
 
    ///获取UITabBarItem 数组
    static func barItems(_ list: [[String]]) -> [UITabBarItem] {
        var marr = [UITabBarItem]()
        for e in list.enumerated() {
            let itemList = e.element
            let title: String = itemList.count > 1 ? itemList[1] : "";
            let imgN: String = itemList.count > 2 ? itemList[2] : "";
            let imgH: String = itemList.count > 3 ? itemList[3] : "";
            let badgeValue: String = itemList.count > 4 ? itemList[4] : "0";
            //
            let imageN = UIImage(named: imgN)?.withRenderingMode(.alwaysOriginal);
            let imageH = UIImage(named: imgH)?.withRenderingMode(.alwaysTemplate);
            let tabBarItem: UITabBarItem = UITabBarItem(title: title, image: imageN, selectedImage: imageH);
            tabBarItem.badgeValue = badgeValue;
            
            if #available(iOS 10.0, *) {
                tabBarItem.badgeColor = badgeValue.intValue <= 0 ? UIColor.clear : UIColor.red;
            }
            
            if tabBarItem.title == nil || tabBarItem.title == "" {
                tabBarItem.imageInsets = UIEdgeInsets(top: 5, left: 0, bottom: -5, right: 0)
            }
            marr.append(tabBarItem)
        }
        return marr
    }

}
