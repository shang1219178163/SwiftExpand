//
//  UICollectionViewLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/16.
//  Copyright © 2019 BN. All rights reserved.
//

import UIKit

public extension UICollectionViewLayout{
    
    public static var layoutDefault: UICollectionViewLayout {
        get {
            var layout = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UICollectionViewFlowLayout;
            if layout == nil {
                // 初始化
                layout = UICollectionViewFlowLayout()
                
                let spacing: CGFloat = 5.0
          
                let itemW = (kScreenWidth - 5*spacing)/4.0
                layout!.itemSize = CGSize(width: itemW, height: itemW)
                layout!.minimumLineSpacing = spacing
                layout!.minimumInteritemSpacing = spacing
                //        layout.scrollDirection = .vertical
                layout!.sectionInset = UIEdgeInsets(top: spacing, left: spacing, bottom: spacing, right: spacing)
                // 设置分区头视图和尾视图宽高
                layout!.headerReferenceSize = CGSize(width: kScreenWidth, height: 60)
                layout!.footerReferenceSize = CGSize(width: kScreenWidth, height: 60)
                
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), layout, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);

            }
            return layout!
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    
}
