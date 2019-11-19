
//
//  UIView+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/27.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


@objc public extension UIView {
    
    var lineTop: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW));
                obj!.backgroundColor = .line

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var lineBottom: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: CGRect(x: 0, y: frame.maxY - kH_LINE_VIEW, width: frame.width, height: kH_LINE_VIEW));
                obj!.backgroundColor = .line
//                addSubview(obj!)

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 渐变色层
    var gradientLayer: CAGradientLayer {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? CAGradientLayer;
            if obj == nil {
                let colors = [UIColor.theme.withAlphaComponent(0.5).cgColor, UIColor.theme.withAlphaComponent(0.9).cgColor]
                obj = CAGradientLayer.layerRect(CGRect.zero, colors: colors, start: CGPointMake(0, 0), end: CGPointMake(1.0, 0))
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// (与holderView配置方法)配套使用
    var holderView: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(#function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: bounds);
                obj!.backgroundColor = UIColor.white

                obj!.isHidden = true;

                let height = bounds.height - 25*2
                let YGap = height*0.2
                let imgView = UIImageView(frame: CGRectMake(0, YGap, bounds.width, height*0.3))
                imgView.contentMode = .scaleAspectFit
                imgView.tag = kTAG_IMGVIEW
                obj!.addSubview(imgView)

                let label = UILabel(frame: CGRectMake(0, imgView.frame.maxY + 25, bounds.width, 25))
                label.textAlignment = .center
                label.text = "暂无数据"
                label.textColor = UIColorHexValue(0x999999)
                label.tag = kTAG_LABEL
                obj!.addSubview(label)
                
                addSubview(obj!)
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(#function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// 配置HolderView
    func holderView(_ title: String = "暂无数据", image: String?) {
        let imgView: UIImageView = holderView.viewWithTag(kTAG_IMGVIEW) as! UIImageView
        let label: UILabel = holderView.viewWithTag(kTAG_LABEL) as! UILabel
        label.text = title
        if image == nil {
            label.center = CGPointMake(holderView.center.x, holderView.sizeHeight*0.35)

        } else {
            imgView.image = UIImageNamed(image!)

        }
    }
    
    /// 增加虚线边框
    func addLineDashLayer(color: UIColor = UIColor.red,
                                    width: CGFloat = 1,
                                    dashPattern: [NSNumber] = [NSNumber(floatLiteral: 4), NSNumber(floatLiteral: 5)],
                                    cornerRadius: CGFloat = 0,
                                    size: CGSize = CGSize.zero) {
        let view: UIView = self;
        assert(CGRect.zero.equalTo(view.bounds) == true && CGSize.zero.equalTo(size));

        view.layer.borderColor = UIColor.clear.cgColor;
        view.layer.borderWidth = 0;
        
        let shapeLayer = CAShapeLayer();
        shapeLayer.strokeColor = color.cgColor;
        shapeLayer.fillColor = UIColor.clear.cgColor;
        
        shapeLayer.frame = CGSize.zero.equalTo(size) ? view.bounds : CGRect(x: 0, y: 0, width: size.width, height: size.height);
        shapeLayer.path = UIBezierPath(roundedRect: shapeLayer.frame, cornerRadius: cornerRadius).cgPath;
        
        shapeLayer.lineWidth = width;
        shapeLayer.lineDashPattern = dashPattern;
        shapeLayer.lineCap = .square;
        if cornerRadius > 0 {
            view.layer.cornerRadius = cornerRadius;
            view.layer.masksToBounds = true;
        }
        view.layer.addSublayer(shapeLayer);
    }
    
//    /// 线条位置
//    func rectWithLine(type: Int = 0, width: CGFloat = 0.8, paddingScale: CGFloat = 0) -> CGRect {
//        var rect = CGRect.zero;
//        switch type {
//        case 1://左边框
//            let paddingY = bounds.height*paddingScale;
//            rect = CGRectMake(0, paddingY, bounds.width, bounds.height - paddingY*2)
//            
//        case 2://下边框
//            let paddingX = bounds.width*paddingScale;
//            rect = CGRectMake(paddingX, bounds.height - width, bounds.width - paddingX*2, width)
//            
//        case 3://右边框
//            let paddingY = bounds.height*paddingScale;
//            rect = CGRectMake(bounds.width - width, paddingY, bounds.width, bounds.height - paddingY*2)
//            
//        default: //上边框
//            let paddingX = bounds.width*paddingScale;
//            rect = CGRectMake(paddingX, 0, bounds.width - paddingX*2, width)
//        }
//        return rect;
//    }
//    /// 创建CALayer 线条
//    func createLayer(type: Int = 0, color: UIColor = UIColor.line, width: CGFloat = 0.8, paddingScale: CGFloat = 0) -> CALayer {
//        let linView = CALayer()
//        linView.backgroundColor = color.cgColor;
//        linView.frame = self.rectWithLine(type: type, width: width, paddingScale: paddingScale);
//        return linView;
//    }
    
//    /// [源]UITableView创建
//    static func createTableView(_ rect: CGRect = .zero, style: UITableView.Style = .plain, rowHeight: CGFloat = 70.0) -> UITableView{
//        let table = UITableView(frame: rect, style: style);
//        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//
//        table.separatorStyle = .singleLine;
//        table.separatorInset = .zero;
//        table.rowHeight = rowHeight;
////        table.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self));
//        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier);
//        table.keyboardDismissMode = .onDrag
//        table.backgroundColor = UIColor.background;
////        table.tableHeaderView = UIView();
////        table.tableFooterView = UIView();
//
//        return table
//    }
//    /// [源]UILabel创建
//    static func createLabel(_ rect: CGRect = .zero, type: Int = 0) -> UILabel {
//        let view = UILabel(frame: rect);
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.isUserInteractionEnabled = true;
//        view.textAlignment = .left;
//        view.font = UIFont.systemFont(ofSize: 15);
//
//        switch type {
//        case 1:
//            view.numberOfLines = 1;
//            view.lineBreakMode = .byTruncatingTail;
//
//        case 2:
//            view.numberOfLines = 1;
//            view.lineBreakMode = .byTruncatingTail;
//            view.adjustsFontSizeToFitWidth = true;
//
//        case 3:
//            view.numberOfLines = 1;
//            view.lineBreakMode = .byTruncatingTail;
//
//            view.layer.borderColor = view.textColor.cgColor;
//            view.layer.borderWidth = 1.0;
//            view.layer.masksToBounds = true;
//            view.layer.cornerRadius = rect.width*0.5;
//
//        case 4:
//            view.numberOfLines = 1;
//            view.lineBreakMode = .byTruncatingTail;
//
//            view.layer.borderColor = view.textColor.cgColor;
//            view.layer.borderWidth = 1.0;
//            view.layer.masksToBounds = true;
//            view.layer.cornerRadius = 3;
//
//        default:
//            view.numberOfLines = 0;
//            view.lineBreakMode = .byCharWrapping;
//        }
//        return view;
//    }
//    /// [源]UIImageView创建
//    static func createImgView(_ rect: CGRect = .zero, imgName: String) -> UIImageView {
//        let view = UIImageView(frame: rect);
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.isUserInteractionEnabled = true;
//        view.contentMode = .scaleAspectFit;
//        view.image = UIImage(named: imgName);
//
//        return view
//    }
//    /// [源]UIButton创建
//    static func createBtn(_ rect: CGRect = .zero, title: String?, imgName: String?, type: Int = 0) -> UIButton {
//        let view = UIButton(type: .custom);
//        view.titleLabel?.font = UIFont.systemFont(ofSize:16);
//        view.titleLabel?.adjustsFontSizeToFitWidth = true;
//        view.titleLabel?.minimumScaleFactor = 1.0;
//        view.imageView?.contentMode = .scaleAspectFit
//        view.isExclusiveTouch = true;
//        view.adjustsImageWhenHighlighted = false;
//
//        view.frame = rect;
//        view.setTitle(title, for: .normal)
//        if imgName != nil && UIImageNamed(imgName!) != nil {
//            view.setImage(UIImageNamed(imgName!), for: .normal)
//        }
//
//        switch type {
//        case 1://白色字体,主题色背景
//            view.setTitleColor( .white, for: .normal)
//            view.backgroundColor = .theme
//
//        case 2:
//            view.setTitleColor( .red, for: .normal);
//
//        case 3://导航栏专用
//            view.setTitleColor( .white, for: .normal);
//
//        case 4://地图定位按钮一类
//            view.setBackgroundImage(UIImageNamed(imgName!), for: .normal)
//            view.setBackgroundImage(UIImageColor( .lightGray), for: .disabled)
//
//        case 5://主题色字体,边框
//            view.setTitleColor( .theme, for: .normal);
//            view.layer.borderColor = UIColor.theme.cgColor;
//            view.layer.borderWidth = kW_LayerBorder;
//
//        case 6://主题色字体,无边框
//            view.setTitleColor( .theme, for: .normal);
//
//        default://黑色字体,白色背景
//            view.setTitleColor( .black, for: .normal)
//
//        }
//        return view
//    }
//    /// [源]UITextField创建
//    static func createTextField(_ rect: CGRect = .zero) -> UITextField {
//        let view = UITextField(frame: rect);
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.borderStyle = .roundedRect;
//        view.contentVerticalAlignment = .center;
//        view.clearButtonMode = .whileEditing;
//        view.autocapitalizationType = .none;
//        view.autocorrectionType = .no;
//        view.backgroundColor = .white;
//        view.returnKeyType = .done
//        view.textAlignment = .left;
//        view.font = UIFont.systemFont(ofSize: 15)
//
//        return view
//    }
//    /// [源]UITextView创建
//    static func createTextView(_ rect: CGRect = .zero) -> UITextView {
//        let view = UITextView(frame: rect);
//        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        view.autocapitalizationType = .none;
//        view.autocorrectionType = .no;
//        view.backgroundColor = .white;
//
//        view.layer.borderWidth = 0.5;
//        view.layer.borderColor = UIColor.line.cgColor;
//
//        view.textAlignment = .left;
//        view.font = UIFont.systemFont(ofSize: 15)
//
//        return view
//    }
//
//    /// 展示性质UITextView创建
//    static func createShowTextView(_ rect: CGRect = .zero) -> UITextView {
//        let view = UITextView.createTextView(rect);
//        view.contentOffset = CGPoint(x: 0, y: 8)
//        view.isEditable = false;
//        view.dataDetectorTypes = .all;
//
//        return view
//    }
    
    /// [源]HeaderView,footerView
    static func createSectionView(_ tableView: UITableView, text: String?, textAlignment: NSTextAlignment = .left, height: CGFloat = 30) -> UIView{
        let sectionView = UIView()
        if text == nil {
            return sectionView
        }
        let view = UILabel(frame: CGRect(x: kX_GAP, y: 0, width: tableView.sizeWidth - kX_GAP*2, height: height));
        view.isUserInteractionEnabled = true;
        view.lineBreakMode = .byTruncatingTail;
        view.adjustsFontSizeToFitWidth = true;
        view.text = text;
        view.textAlignment = textAlignment
        view.font = UIFont.systemFont(ofSize: 15)

        sectionView.addSubview(view)
        return sectionView
    }
    
     /// 获取密集子视图的总高度
    static func UIGroupViewHeight(_ count: Int = 9, numberOfRow: Int = 4, padding: CGFloat = 12, itemHeight: CGFloat = 40) -> CGFloat {
        let rowCount = count % numberOfRow == 0 ? count/numberOfRow : count/numberOfRow + 1;
        return rowCount.toCGFloat * itemHeight + (rowCount - 1).toCGFloat * padding;
    }
    
    /// [源]GroupView创建
    static func createGroupView(_ rect: CGRect = CGRect.zero, list: [String]!, numberOfRow: Int = 4, padding: CGFloat = kPadding, type: Int = 0, action: ((UITapGestureRecognizer?, UIView, NSInteger)->Void)? = nil) -> UIView {
        
        let rowCount: Int = list.count % numberOfRow == 0 ? list.count/numberOfRow : list.count/numberOfRow + 1;
        let itemWidth = (rect.width - CGFloat(numberOfRow - 1)*padding)/CGFloat(numberOfRow)
        let itemHeight = (rect.height - CGFloat(rowCount - 1)*padding)/CGFloat(rowCount)
        
        let backView = UIView(frame: rect);
        for (i,value) in list.enumerated() {
            let x = CGFloat(i % numberOfRow) * (itemWidth + padding);
            let y = CGFloat(i / numberOfRow) * (itemHeight + padding);
            let rect = CGRect(x: x, y: y, width: itemWidth, height: itemHeight);
            
            var view: UIView;
            switch type {
            case 1:
                let imgView = UIImageView(frame: rect);
                imgView.isUserInteractionEnabled = true;
                imgView.contentMode = .scaleAspectFit;
                imgView.image = UIImage(named: value);
                
                view = imgView;
                
            case 2:
                let label = UILabel(frame: rect);
                label.text = value;
                label.textAlignment = .center;
                
                label.numberOfLines = 0;
                label.lineBreakMode = .byCharWrapping;
                
                view = label;
                
            default:
                let button = UIButton(type: .custom);
                button.frame = rect;
                button.setTitle(value, for: .normal);
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15);
                button.titleLabel?.adjustsFontSizeToFitWidth = true;
                button.titleLabel?.minimumScaleFactor = 1.0;
                button.isExclusiveTouch = true;
                
                button.setTitleColor(UIColor.black, for: .normal);
                button.backgroundColor = UIColor.white;
                view = button;
            }
            view.tag = i;
    
            if action != nil {
                view.addActionClosure(action!)
            }
            
            backView.addSubview(view);
        }
        return backView;
    }
    
    /// 创建 UIButton 集群
    static func createGroupBtnView(_ rect: CGRect = .zero, list: [String]!, numberOfRow: Int = 4, padding: CGFloat = kPadding, type: Int = 0, action: (ControlClosure)? = nil) -> UIView {
        
        let rowCount: Int = list.count % numberOfRow == 0 ? list.count/numberOfRow : list.count/numberOfRow + 1;
        let itemWidth = (rect.width - CGFloat(numberOfRow - 1)*padding)/CGFloat(numberOfRow)
        let itemHeight = (rect.height - CGFloat(rowCount - 1)*padding)/CGFloat(rowCount)
        
        let backView = UIView(frame: rect);
        for (i,value) in list.enumerated() {
            let x = CGFloat(i % numberOfRow) * (itemWidth + padding);
            let y = CGFloat(i / numberOfRow) * (itemHeight + padding);
            let rect = CGRect(x: x, y: y, width: itemWidth, height: itemHeight);
            
            let button: UIButton = {
                let button = UIButton(type: .custom);
                button.frame = rect;
                button.setTitle(value, for: .normal);
                button.titleLabel?.font = UIFont.systemFont(ofSize: 15);
                button.titleLabel?.adjustsFontSizeToFitWidth = true;
                button.titleLabel?.minimumScaleFactor = 1.0;
                button.isExclusiveTouch = true;
                
                button.setTitleColor(UIColor.black, for: .normal);
                button.backgroundColor = UIColor.white;
                button.tag = i;
                
                return button;
            }()
    
            if action != nil {
                button.addActionHandler(action!)
            }
            backView.addSubview(button);
            backView.addSubview(backView.lineTop)
        }
        return backView;
    }
    
//    /// [源]UISegmentControl创建
//    static func createSegment(_ rect: CGRect = .zero, items: Array<Any>!, selectedIdx: Int = 0, type: Int = 0) -> UISegmentedControl {
//        let view = UISegmentedControl(items: items)
//        view.frame = rect
//        view.autoresizingMask = .flexibleWidth
//        view.selectedSegmentIndex = selectedIdx
//
//        switch type {
//        case 1:
//            view.tintColor = UIColor.theme
//            view.backgroundColor = UIColor.white
//            view.layer.borderWidth = 1.0
//            view.layer.borderColor = UIColor.white.cgColor
//            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
//
//                         ]
//            view.setTitleTextAttributes(dic_N, for: .normal)
//            view.setDividerImage(UIImageColor(UIColor.white), forLeftSegmentState: .normal, rightSegmentState: .normal, barMetrics: .default);
//
//        case 2:
//            view.tintColor = UIColor.white
//            view.backgroundColor = UIColor.white
//
//            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
//                         ]
//
//            let dic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//                         ]
//
//            view.setTitleTextAttributes(dic_N, for: .normal)
//            view.setTitleTextAttributes(dic_H, for: .selected)
//
//        case 3:
//            view.tintColor = UIColor.clear
//            view.backgroundColor = UIColor.line
//
//            let dic_N = [NSAttributedString.Key.foregroundColor: UIColor.black,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
//
//                         ]
//
//            let dic_H = [NSAttributedString.Key.foregroundColor: UIColor.theme,
//                         NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//
//                         ]
//
//            view.setTitleTextAttributes(dic_N, for: .normal)
//            view.setTitleTextAttributes(dic_H, for: .selected)
//
//        default:
//            view.tintColor = UIColor.theme
//            view.backgroundColor = UIColor.white
//
//            let dic_N = [
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 15),
//
//                ]
//
//            let dic_H = [
//                NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18),
//
//                ]
//
//            view.setTitleTextAttributes(dic_N, for: .normal)
//            view.setTitleTextAttributes(dic_H, for: .selected)
//        }
//        return view;
//    }
//    /// [源]UISlider创建
//    static func createSlider(_ rect: CGRect = .zero, value: Float, minValue: Float = 0, maxValue: Float = 100) -> UISlider {
//        let view = UISlider(frame: rect)
//        view.autoresizingMask = .flexibleWidth
//        view.minimumValue = minValue
//        view.maximumValue = maxValue
//        view.value = value;
//
//        view.minimumTrackTintColor = UIColor.theme
//        return view;
//    }
//    /// [源]UISwitch创建
//    static func createSwitch(_ rect: CGRect = .zero, isOn: Bool = true) -> UISwitch {
//        let view = UISwitch(frame: rect)
//        view.autoresizingMask = .flexibleWidth
//        view.isOn = isOn
//        view.onTintColor = UIColor.theme
//        return view
//    }
//    /// [源]UIPageControl创建
//    static func createPageControl(_ rect: CGRect = .zero, numberOfPages: Int, currentPage: Int = 0) -> UIPageControl {
//        let pageControl: UIPageControl = {
//            let control: UIPageControl = UIPageControl(frame: rect);
//            control.currentPageIndicatorTintColor = UIColor.theme;
//            control.pageIndicatorTintColor = UIColor.lightGray;
//            control.isUserInteractionEnabled = true;
//            control.hidesForSinglePage = true;
//            control.currentPage = 0;
//            control.numberOfPages = numberOfPages;
//
//            return control;
//        }();
//        return pageControl;
//    }
//    /// [源]UISearchBar创建
//    static func createSearchBarRect(_ rect: CGRect) -> UISearchBar {
//        let searchBar = UISearchBar(frame: rect)
//
//        //设置背景色
////        searchBar.backgroundColor = UIColor.black.withAlphaComponent(0.1);
////        searchBar.layer.cornerRadius = rect.height*0.5;
////        searchBar.layer.masksToBounds = true;
//        //设置背景图是为了去掉上下黑线
//        searchBar.backgroundImage = UIImage();
//        //searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
//        // 设置SearchBar的主题颜色
//        //searchBar.barTintColor = [UIColor colorWithRed:111 green:212 blue:163 alpha:1];
//
//
//        searchBar.barStyle = .default;
//        searchBar.keyboardType = .namePhonePad;
//        //searchBar.searchBarStyle = UISearchBarStyleMinimal;
//        //没有背影，透明样式
//        // 修改cancel
////        searchBar.setValue("取消", forKey: "cancelButtonText")
////        searchBar.showsCancelButton = true;
//        //    searchBar.showsSearchResultsButton = true;
//        //5. 设置搜索Icon
//        //    [searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//        searchBar.setPositionAdjustment(UIOffset(horizontal: -8, vertical: 1), for: .search)
//        // 删除按钮往右移一点
//        searchBar.setPositionAdjustment(UIOffset(horizontal: 8, vertical: 0), for: .clear)
//
////        guard let textField: UITextField = (searchBar.findSubview(type: UITextField.self, resursion: true) as? UITextField) else { return searchBar; }
////        textField.backgroundColor = UIColor.clear
////        textField.tintColor = UIColor.gray;
////        textField.textColor = UIColor.white;
////        textField.font = UIFont.systemFont(ofSize: 13)
//        searchBar.textField?.tintColor = UIColor.gray;
//        searchBar.textField?.font = UIFont.systemFont(ofSize: 13)
//        searchBar.textField?.borderStyle = .none;
//
//        return searchBar;
//    }
}
