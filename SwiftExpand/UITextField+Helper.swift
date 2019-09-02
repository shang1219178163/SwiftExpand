

//
//  UITextField+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

public extension UITextField{

    ///  RightView
    @objc func asoryView(_ isRight: Bool, unitName: String!, viewSize: CGSize = CGSize(width: 25, height: 25)) -> UIView! {
        assert(unitName != nil && unitName.valid() == true);
        
        if unitName.contains("img") {
            let view = UIImageView(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height));
            view.image = UIImage(named: unitName);
            view.contentMode = .scaleAspectFit;
            view.tag = kTAG_IMGVIEW;
            return view;
        }
       
        let size = sizeWithText(unitName, font: UIFont.labelFontSize, width: kScreenWidth);
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width, height: viewSize.height));
        label.tag = kTAG_LABEL;
        label.text = unitName;
        label.font = UIFont.systemFont(ofSize: 15);
        label.textAlignment = .center;
        label.lineBreakMode = .byCharWrapping;
        label.numberOfLines = 0;
        label.backgroundColor = .clear;
        
        if isRight == true {
            self.rightView = label;
            self.rightViewMode = .always;
            
        } else {
            self.leftView = label;
            self.leftViewMode = .always;
        }
        return label;
    }

}
