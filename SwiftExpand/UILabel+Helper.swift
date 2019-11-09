//
//  UILabel+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/4.
//

/*
 Range与NSRange区别很大
 */

import UIKit

@objc public extension UILabel{
    /// [源]UILabel创建
    static func create(_ rect: CGRect = .zero, type: Int = 0) -> UILabel {
        let view = UILabel(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true;
        view.textAlignment = .left;
        view.font = UIFont.systemFont(ofSize: 15);
        
        switch type {
        case 1:
            view.numberOfLines = 1;
            view.lineBreakMode = .byTruncatingTail;
            
        case 2:
            view.numberOfLines = 1;
            view.lineBreakMode = .byTruncatingTail;
            view.adjustsFontSizeToFitWidth = true;
            
        case 3:
            view.numberOfLines = 1;
            view.lineBreakMode = .byTruncatingTail;
            
            view.layer.borderColor = view.textColor.cgColor;
            view.layer.borderWidth = 1.0;
            view.layer.masksToBounds = true;
            view.layer.cornerRadius = rect.width*0.5;
            
        case 4:
            view.numberOfLines = 1;
            view.lineBreakMode = .byTruncatingTail;
            
            view.layer.borderColor = view.textColor.cgColor;
            view.layer.borderWidth = 1.0;
            view.layer.masksToBounds = true;
            view.layer.cornerRadius = 3;
            
        default:
            view.numberOfLines = 0;
            view.lineBreakMode = .byCharWrapping;
        }
        return view;
    }
    /// UILabel富文本设置
    func setContent(_ content: String, attDic: Dictionary<NSAttributedString.Key, Any>) -> NSMutableAttributedString{
        assert((self.text?.contains(content))!)
        
        let text: NSString = self.text! as NSString
        let attString = NSMutableAttributedString(string: text as String)
        let range:NSRange = text.range(of: content)
        attString.addAttributes(attDic, range: range)
        attributedText = attString
        return attString
    }
}
