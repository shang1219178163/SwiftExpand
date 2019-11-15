//
//  UIImageView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/27.
//

import UIKit

@objc public extension UIImageView{
    /// [源]UIImageView创建
    static func create(_ rect: CGRect = .zero, imgName: String) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true;
        view.contentMode = .scaleAspectFit;
        view.image = UIImage(named: imgName);
        
        return view
    }
    ///MARK:默认渲染AlwaysTemplate方式
    func renderTintColor(_ tintColor: UIColor = .theme, mode: UIImage.RenderingMode = .alwaysTemplate) {
        self.tintColor = tintColor
        self.image = self.image!.withRenderingMode(mode)
    }
    
}



