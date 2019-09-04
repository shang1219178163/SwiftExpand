
//
//  UICollectionViewFlowLayout+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/9/4.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation

public extension UICollectionViewFlowLayout{

    ///  默认布局配置(自上而下,自左而右)
    @objc func create(_ rowNum: Int = 4, spacing: CGFloat = kPadding, headerHeight: CGFloat = 30, footerHeight: CGFloat = 30) -> UICollectionViewFlowLayout {
        
        let itemWidth = (bounds.width - (rowNum.toCGFloat + 1)*spacing)/rowNum.toCGFloat;
        let itemHeight = itemWidth/kRatioIDCard;
        let itemSize = CGSize(width: itemWidth, height: itemHeight);
        let headerSize = CGSize(width: bounds.width, height: headerHeight);
        let footerSize = CGSize(width: bounds.width, height: footerHeight);
        let sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0);
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout.create(CGSize(width: itemWidth, height: itemHeight), spacing: spacing, headerSize: headerSize, footerSize: footerSize);
        layout.sectionInset = sectionInset;
        return layout;
    }

}
