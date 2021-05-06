//
//  UIPageControl+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/11/9.
//

import UIKit

@objc public extension UIPageControl{

    convenience init(rect: CGRect = .zero, numberOfPages: Int, currentPage: Int = 0) {
        self.init(frame: rect);
        self.currentPageIndicatorTintColor = UIColor.theme;
        self.pageIndicatorTintColor = UIColor.lightGray;
        self.isUserInteractionEnabled = true;
        self.hidesForSinglePage = true;
        self.currentPage = currentPage;
        self.numberOfPages = numberOfPages;
    }
    
    func numberOfPagesChain(_ numberOfPages: Int) -> Self {
        self.numberOfPages = numberOfPages
        return self
    }

    func currentPageChain(_ currentPage: Int) -> Self {
        self.currentPage = currentPage
        return self
    }

    func hidesForSinglePageChain(_ hidesForSinglePage: Bool) -> Self {
        self.hidesForSinglePage = hidesForSinglePage
        return self
    }

    @available(iOS 6.0, *)
    func pageIndicatorTintColorChain(_ pageIndicatorTintColor: UIColor?) -> Self {
        self.pageIndicatorTintColor = pageIndicatorTintColor
        return self
    }

    @available(iOS 6.0, *)
    func currentPageIndicatorTintColorChain(_ currentPageIndicatorTintColor: UIColor?) -> Self {
        self.currentPageIndicatorTintColor = currentPageIndicatorTintColor
        return self
    }

    @available(iOS 14.0, *)
    func backgroundStyleChain(_ backgroundStyle: UIPageControl.BackgroundStyle) -> Self {
        self.backgroundStyle = backgroundStyle
        return self
    }

    @available(iOS 14.0, *)
    func allowsContinuousInteractionChain(_ allowsContinuousInteraction: Bool) -> Self {
        self.allowsContinuousInteraction = allowsContinuousInteraction
        return self
    }

    @available(iOS 14.0, *)
    func preferredIndicatorImageChain(_ preferredIndicatorImage: UIImage?) -> Self {
        self.preferredIndicatorImage = preferredIndicatorImage
        return self
    }

    @available(iOS, introduced: 2.0, deprecated: 14.0, message: "defersCurrentPageDisplay no longer does anything reasonable with the new interaction mode.")
    func defersCurrentPageDisplayChain(_ defersCurrentPageDisplay: Bool) -> Self {
        self.defersCurrentPageDisplay = defersCurrentPageDisplay
        return self
    }

}
