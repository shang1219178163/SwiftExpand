//
//  UISegmentedControl+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

@objc public extension UISegmentedControl{

    /// [源]UISegmentControl创建
    static func create(_ rect: CGRect = .zero, items: Array<Any>!, selectedIdx: Int = 0, type: Int = 0) -> UISegmentedControl {
        let view = UISegmentedControl(items: items)
        view.frame = rect
        view.autoresizingMask = UIView.AutoresizingMask.flexibleWidth
        view.selectedSegmentIndex = selectedIdx
        
        switch type {
        case 1:
            view.tintColor = UIColor.theme
            view.backgroundColor = UIColor.white
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.white.cgColor
            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                         
                         ]
            view.setTitleTextAttributes(dic_N, for: .normal)
            view.setDividerImage(UIImageColor(UIColor.white), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default);
            
        case 2:
            view.tintColor = UIColor.white
            view.backgroundColor = UIColor.white
            
            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                         ]
            
            let dic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                         ]
            
            view.setTitleTextAttributes(dic_N, for: .normal)
            view.setTitleTextAttributes(dic_H, for: .selected)
            
        case 3:
            view.tintColor = UIColor.clear
            view.backgroundColor = UIColor.line
            
            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                         
                         ]
            
            let dic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                         
                         ]
            
            view.setTitleTextAttributes(dic_N, for: .normal)
            view.setTitleTextAttributes(dic_H, for: .selected)
            
        default:
            view.tintColor = UIColor.theme
            view.backgroundColor = UIColor.white
            
            let dic_N = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
                
                ]
            
            let dic_H = [
                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
                
                ]
            
            view.setTitleTextAttributes(dic_N, for: .normal)
            view.setTitleTextAttributes(dic_H, for: .selected)
        }
        return view;
    }
    
    /// 控件items
    var itemList: Array<String> {
        get {
            return objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as! Array<String>
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            
            p_handleSegmentItems(newValue);
        }
    }
    
    /// 配置新item数组
    private func p_handleSegmentItems(_ itemList: Array<String>) {
        if itemList.count == 0 {
            return
        }
        
        removeAllSegments()
        for e in itemList.enumerated() {
            insertSegment(withTitle: e.element, at: e.offset, animated: false)
        }
        selectedSegmentIndex = 0
    }
    

    
}
