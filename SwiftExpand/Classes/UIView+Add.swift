
//
//  UIView+Add.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/27.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


@objc public extension UIView {
    
    ///视图方向(上左下右)
    enum Direction: Int {
        case top
        case left
        case bottom
        case right
    }

    ///视图角落(左上,左下,右上,右下)
    enum Location: Int {
        case leftTop
        case leftBottom
        case rightTop
        case rightBottom
    }
    
    var lineTop: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: CGRect(x: 0, y: 0, width: frame.width, height: kH_LINE_VIEW));
                obj!.backgroundColor = .line

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var lineBottom: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: CGRect(x: 0, y: frame.maxY - kH_LINE_VIEW, width: frame.width, height: kH_LINE_VIEW));
                obj!.backgroundColor = .line
//                addSubview(obj!)

                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    var lineRight: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIView;
            if obj == nil {
                obj = UIView(frame: CGRect(x: frame.maxX - kH_LINE_VIEW, y: 0, width: kH_LINE_VIEW, height: frame.height));
                obj!.backgroundColor = .line
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }

    
    /// 渐变色层
    var gradientLayer: CAGradientLayer {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? CAGradientLayer;
            if obj == nil {
                let colors = [UIColor.theme.withAlphaComponent(0.5).cgColor, UIColor.theme.withAlphaComponent(0.9).cgColor]
                obj = CAGradientLayer.layerRect(CGRect.zero, colors: colors, start: CGPointMake(0, 0), end: CGPointMake(1.0, 0))
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
    }
    
    /// (与holderView配置方法)配套使用
    var holderView: UIView {
        get {
            var obj = objc_getAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function)) as? UIView;
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
                label.textColor = UIColor.hexValue(0x999999)
                label.tag = kTAG_LABEL
                obj!.addSubview(label)
                
                addSubview(obj!)
                objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
            }
            return obj!;
        }
        set {
            objc_setAssociatedObject(self, RuntimeKeyFromSelector(self, aSelector: #function), newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
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
    
     /// 获取密集子视图的总高度
    static func groupViewHeight(_ count: Int = 9, numberOfRow: Int = 4, padding: CGFloat = 12, itemHeight: CGFloat = 40) -> CGFloat {
        let rowCount = count % numberOfRow == 0 ? count/numberOfRow : count/numberOfRow + 1;
        return rowCount.toCGFloat * itemHeight + (rowCount - 1).toCGFloat * padding;
    }
    
}
