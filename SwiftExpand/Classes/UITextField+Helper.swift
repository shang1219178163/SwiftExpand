

//
//  UITextField+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/10.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit

@objc public extension UITextField{
    /// [源]UITextField创建
    static func create(_ rect: CGRect = .zero) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.borderStyle = .none;
        view.contentVerticalAlignment = .center;
        view.clearButtonMode = .whileEditing;
        view.autocapitalizationType = .none;
        view.autocorrectionType = .no;
        view.backgroundColor = .white;
        view.returnKeyType = .done
        view.textAlignment = .left;
        view.font = UIFont.systemFont(ofSize: 15)
        return view
    }
    
    /// 设置 leftView 图标
    func setupLeftView(image: UIImage?, viewMode: UITextField.ViewMode = .always) {
        if image == nil {
            return
        }
        if leftView != nil {
            leftViewMode = viewMode
            return
        }
     
        leftViewMode = viewMode; //此处用来设置leftview现实时机
        leftView = {
            let view: UIView = UIView(frame: CGRect(x: 0, y: 0, width: 30, height: 40))
            
            let imgView = UIImageView(frame:CGRect(x: 0, y: 0, width: 15, height: 15));
            imgView.image = image
            imgView.contentMode = UIView.ContentMode.scaleAspectFit;
            imgView.center = view.center;
            view.addSubview(imgView);
          
            return view;
        }()
    }
    
    ///RightView
    func asoryView(_ isRight: Bool, unit: String, viewSize: CGSize = CGSize(width: 25, height: 25)) -> UIView {
         if let image = UIImage(named: unit) {
            return asoryView(isRight, image: image, viewSize: viewSize)
         }
        return asoryView(isRight, text: unit, viewSize: viewSize)
    }
    ///字符串为单位
    func asoryView(_ isRight: Bool, text: String, viewSize: CGSize = CGSize(width: 25, height: 25)) -> UILabel {
         let size = sizeWithText(text, font: 15, width: kScreenWidth);
         let label = UILabel(frame: CGRect(x: 0, y: 0, width: size.width + 10, height: viewSize.height))
         label.tag = kTAG_LABEL;
         label.text = text;
         label.textColor = .gray;
         label.font = UIFont.systemFont(ofSize: 15);
         label.textAlignment = .center;
         label.lineBreakMode = .byCharWrapping;
         label.numberOfLines = 0;
         label.backgroundColor = .clear;
                
        if isRight == true {
            self.rightViewMode = .always;
            self.rightView = label
        } else {
            self.leftViewMode = .always;
            self.leftView = label
        }
        return label
    }
    
    ///图标为单位
    func asoryView(_ isRight: Bool, image: UIImage, viewSize: CGSize = CGSize(width: 25, height: 35)) -> UIImageView {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height))
        view.image = image
        view.contentMode = .scaleAspectFit;
        view.tag = kTAG_IMGVIEW;
        if isRight == true {
            self.rightView = view
            self.rightViewMode = .always;
        } else {
            self.leftView = view
            self.leftViewMode = .always;
        }
        return view
    }
    
    /// 返回当前文本框字符串(func textField(_ textField: shouldChangeCharactersIn:, replacementString:) -> Bool 中调用)
    func currentString(replacementString string: String) -> String {
        if self.text?.count == 1 {
            return "";
        }
        return string != "" ? self.text! + string : self.text!.substringTo(self.text!.count - 2);
    }
    
}
