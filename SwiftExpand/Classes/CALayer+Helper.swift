//
//  CALayer+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/1/15.
//  Copyright © 2019 BN. All rights reserved.
//


@objc public extension CALayer{
    
    convenience init(contents: Any?) {
        self.init()
        self.contents = contents
//        self.contentsScale = UIScreen.main.scale
//        self.rasterizationScale = UIScreen.main.scale
        self.shouldRasterize = true
    }
    
    ///添加边框线
    func addOutline(_ width: CGFloat = 1, color: Color, cornerRadius: CGFloat = 3) {
        self.borderColor = color.cgColor;
        self.borderWidth = width;
        self.cornerRadius = cornerRadius
        self.masksToBounds = true
    }
    
    /// 线条位置
    func rectWithLine(type: Int = 0, width: CGFloat = 0.8, paddingScale: CGFloat = 0) -> CGRect {
        var rect = CGRect.zero;
        switch type {
        case 1://左边框
            let paddingY = bounds.height*paddingScale;
            rect = CGRectMake(0, paddingY, bounds.width, bounds.height - paddingY*2)
            
        case 2://下边框
            let paddingX = bounds.width*paddingScale;
            rect = CGRectMake(paddingX, bounds.height - width, bounds.width - paddingX*2, width)
            
        case 3://右边框
            let paddingY = bounds.height*paddingScale;
            rect = CGRectMake(bounds.width - width, paddingY, bounds.width, bounds.height - paddingY*2)
            
        default: //上边框
            let paddingX = bounds.width*paddingScale;
            rect = CGRectMake(paddingX, 0, bounds.width - paddingX*2, width)
        }
        return rect;
    }
    /// 创建CALayer 线条
    func createLayer(type: Int = 0, color: Color = Color.line, width: CGFloat = 0.8, paddingScale: CGFloat = 0) -> CALayer {
        let linView = CALayer()
        linView.backgroundColor = color.cgColor;
        linView.frame = self.rectWithLine(type: type, width: width, paddingScale: paddingScale);
        return linView;
    }
    /// 控制器切换渐变动画
    func addAnimationFade(_ duration: CFTimeInterval = 0.15, functionName: CAMediaTimingFunctionName = .easeIn) {
        let anim = CATransition()
        anim.duration = duration;
        anim.timingFunction = CAMediaTimingFunction(name: functionName);
        anim.type = .fade
        anim.isRemovedOnCompletion = true;
        self.add(anim, forKey: "transitionView")
    }
    
    /// 来回移动动画
    func shakeAnimation() {
        let anim = CAKeyframeAnimation(keyPath: "position.x")
        //获取当前View的position坐标
        let positionX = self.position.x
        //设置抖动的范围
        anim.values = [(positionX-10),(positionX),(positionX+10)]
        //动画重复的次数
        anim.repeatCount = 3
        //动画时间
        anim.duration = 0.07
        //设置自动反转
        anim.autoreverses = true
        //将动画添加到layer
        self.add(anim, forKey: nil)
    }
    
    ///添加阴影
    func showShadow(_ color: Color = .gray, radius: CGFloat = 3.5, opacity: CGFloat = 1, offset: CGSize = .zero) {
        masksToBounds = false
        shadowColor = color.cgColor
        shadowRadius = radius
        shadowOpacity = Float(opacity)
        shadowOffset = offset
        
//        let path = BezierPath(rect: bounds.offsetBy(dx: 1, dy: 1))
//        layer.shadowPath = path.cgPath
    }
}


@objc public extension CAGradientLayer{

    convenience init(colors: [Any], start: CGPoint, end: CGPoint) {
        self.init()
        self.colors = colors
        self.startPoint = start
        self.endPoint = end
    }

}
