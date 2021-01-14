//
//  UISegmentedControl+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

@objc public extension UISegmentedControl{
    private struct AssociateKeys {
        static var items   = "UISegmentedControl" + "items"
        static var closure = "UISegmentedControl" + "closure"
    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UISegmentedControl) ->Void), for controlEvents: UIControl.Event = .valueChanged) {
        addTarget(self, action:#selector(p_handleActionSegment(_:)), for:controlEvents);
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /// 点击回调
    private func p_handleActionSegment(_ sender: UISegmentedControl) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UISegmentedControl) ->Void) {
            block(sender);
        }
    }
    
    var currentTitle: String? {
        let currentTitle = self.titleForSegment(at: self.selectedSegmentIndex)
        return currentTitle
    }
    /// [源]UISegmentControl创建
    static func create(_ rect: CGRect = .zero, items: [Any]?, selectedIdx: Int = 0, type: Int = 0, tintColor: UIColor = .theme, fontSize: CGFloat = 13) -> Self {
        let view = self.init(items: items)
        view.frame = rect
        view.autoresizingMask = .flexibleWidth
        view.selectedSegmentIndex = selectedIdx
        
        if #available(iOS 13, *) {
            view.ensureiOS13Style(tintColor: tintColor, fontSize: fontSize)
            return view;
        }
        
        switch type {
        case 1:
            view.tintColor = UIColor.theme
            view.backgroundColor = UIColor.white
            view.layer.borderWidth = 1.0
            view.layer.borderColor = UIColor.white.cgColor
            let dicN = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                         
                         ]
            view.setTitleTextAttributes(dicN, for: .normal)
            view.setDividerImage(UIImage(color: UIColor.white), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default);
            
        case 2:
            view.tintColor = UIColor.white
            view.backgroundColor = UIColor.white
            
            let dicN = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                         ]
            
            let dicH = [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                         ]
            view.setTitleTextAttributes(dicN, for: .normal)
            view.setTitleTextAttributes(dicH, for: .selected)
            
        case 3:
            view.tintColor = UIColor.clear
            view.backgroundColor = UIColor.line
            
            let dicN = [NSAttributedString.Key.foregroundColor: UIColor.black,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                         ]
            
            let dicH = [NSAttributedString.Key.foregroundColor: UIColor.theme,
                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                         ]
            view.setTitleTextAttributes(dicN, for: .normal)
            view.setTitleTextAttributes(dicH, for: .selected)
            
        default:
            view.tintColor = UIColor.theme
            view.backgroundColor = UIColor.white
            
            let dicN = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                        ]
            let dicH = [NSAttributedString.Key.font: UIFont.systemFont(ofSize: fontSize),
                        ]
            view.setTitleTextAttributes(dicN, for: .normal)
            view.setTitleTextAttributes(dicH, for: .selected)
        }
        return view;
    }
    
    /// Tint color doesn't have any effect on iOS 13.
    func ensureiOS13Style(tintColor: UIColor = .theme, fontSize: CGFloat = 13) {
        if #available(iOS 13, *) {
            let tintColorImage = UIImage(color: tintColor)
            let clearColorImage = UIImage(color: .clear)

            // Must set the background image for normal to something (even clear) else the rest won't work
            setBackgroundImage(UIImage(color: backgroundColor ?? .clear), for: .normal, barMetrics: .default)
            setBackgroundImage(clearColorImage, for: .selected, barMetrics: .default)
            setBackgroundImage(clearColorImage, for: .highlighted, barMetrics: .default)

            setTitleTextAttributes([.foregroundColor: tintColor as Any,
                                    .font: UIFont.systemFont(ofSize: fontSize)], for: .normal)
            setTitleTextAttributes([.foregroundColor: UIColor.white,
                                    .font: UIFont.systemFont(ofSize: fontSize)], for: .highlighted)
            setTitleTextAttributes([.foregroundColor: UIColor.white,
                                    .font: UIFont.systemFont(ofSize: fontSize)], for: .selected)
            setDividerImage(tintColorImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
            setDividerImage(clearColorImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
            setDividerImage(clearColorImage, forLeftSegmentState: .highlighted, rightSegmentState: .normal, barMetrics: .default)
            
            layer.borderColor = tintColor.cgColor;
            layer.borderWidth = 1.0;
            layer.masksToBounds = true;
            layer.cornerRadius = 1.0;
        }
    }
    
    /// 控件items
    var items: [String] {
        get {
            if let obj = objc_getAssociatedObject(self, &AssociateKeys.items) as? [String] {
                return obj
            }
            return []
        }
        set {
            objc_setAssociatedObject(self, &AssociateKeys.items, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            updateItems(newValue)
        }
    }
    
    /// 控件items
    var imageItems: [UIImage]? {
        get {
            let range = 0..<numberOfSegments
            return range.compactMap { imageForSegment(at: $0) }
        }
        set {
            guard let newValue = newValue else { return }
            updateImageItems(newValue)
        }
    }
        
    /// 配置新item数组
    private func updateItems(_ items: [String]) {
        if items.count == 0 {
            return
        }
        
        removeAllSegments()
        for e in items.enumerated() {
            insertSegment(withTitle: e.element, at: e.offset, animated: false)
        }
        selectedSegmentIndex = 0
    }
    
    /// 配置新item数组
    private func updateImageItems(_ items: [UIImage]) {
        if items.count == 0 {
            return
        }
        
        removeAllSegments()
        for e in items.enumerated() {
            insertSegment(with: e.element, at: e.offset, animated: false)
        }
        selectedSegmentIndex = 0
    }
    ///设置图片和标题
    func setCustom(_ title: String, image: UIImage, forSegmentAt segment: Int) {
        let image = UIImage.textEmbededImage(image: image, string: title, color: .systemGreen)
        setImage(image, forSegmentAt: segment)
    }

    func setCustom(_ dividerImage: UIImage, forSegmentAt segment: Int) {
        setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .highlighted, rightSegmentState: .normal, barMetrics: .default)
    }
    
    func setDivideColor(_ divideColor: UIColor, forSegmentAt segment: Int) {
        let dividerImage = UIImage(color: divideColor)
        setDividerImage(dividerImage, forLeftSegmentState: .selected, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default)
        setDividerImage(dividerImage, forLeftSegmentState: .highlighted, rightSegmentState: .normal, barMetrics: .default)
    }
    
}
