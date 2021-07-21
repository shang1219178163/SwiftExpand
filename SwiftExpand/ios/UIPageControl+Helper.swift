//
//  UIPageControl+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit

@objc public extension UIPageControl{
    ///便利方法
    convenience init(rect: CGRect = .zero, numberOfPages: Int, currentPage: Int = 0) {
        self.init(frame: rect)
        self.currentPageIndicatorTintColor = UIColor.theme
        self.pageIndicatorTintColor = UIColor.lightGray
        self.isUserInteractionEnabled = true
        self.hidesForSinglePage = true
        self.currentPage = currentPage
        self.numberOfPages = numberOfPages
    }
    
}
