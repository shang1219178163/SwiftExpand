//
//  UIImageView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/27.
//

import UIKit

public extension UIImageView{

    ///MARK:默认渲染AlwaysTemplate方式
    @objc func renderTintColor(_ tintColor: UIColor) -> Void {
        renderTintColor(tintColor, mode: .alwaysTemplate);
    }
    
    ///MARK:渲染
    @objc func renderTintColor(_ tintColor: UIColor, mode: UIImage.RenderingMode) -> Void {
        self.tintColor = tintColor
        self.image = self.image!.withRenderingMode(mode)
//        self.image = self.image!.withRenderingMode( .alwaysTemplate)
        
    }
    
    ///MARK:翻转图像
    @objc func transformImage(_ duration: TimeInterval = 1.5) -> Void {
        UIView.animate(withDuration: duration, animations: {
            self.transform = self.transform.isIdentity == true ? self.transform.rotated(by: CGFloat(Double.pi)) : CGAffineTransform.identity;
        })
        
    }
}



