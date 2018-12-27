//
//  UIImageView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2018/12/27.
//

import UIKit

extension UIImageView{
    
    func renderTintColor(_ tintColor:UIColor, imgName:String, mode: UIImage.RenderingMode) -> Void {
        self.image = UIImage(named: imgName)!;
        renderTintColor(tintColor, mode: mode);
    }
    
    func renderTintColor(_ tintColor:UIColor, mode: UIImage.RenderingMode) -> Void {
        self.tintColor = tintColor
//        self.image = self.image!.withRenderingMode( .alwaysTemplate)
        self.image = self.image!.withRenderingMode( mode)
        
    }
}

