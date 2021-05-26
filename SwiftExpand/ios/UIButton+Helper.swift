
//
//  UIButton+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/17.
//  Copyright © 2018年 BN. All rights reserved.
//
 
import UIKit



@objc public extension UIButton{
    
    private struct AssociateKeys {
        static var closure   = "UIButton" + "closure"

    }
    /// UIControl 添加回调方式
    override func addActionHandler(_ action: @escaping ((UIButton) ->Void), for controlEvents: UIControl.Event = .touchUpInside) {
        addTarget(self, action:#selector(p_handleActionBtn(_:)), for:controlEvents);
        objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
    }
    
    /// 点击回调
    private func p_handleActionBtn(_ sender: UIButton) {
        if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIButton) ->Void) {
            block(sender);
        }
    }


    ///自定义按钮类型
    @objc enum CustomType: Int {
             ///主题色底白字
        case titleWhiteAndBackgroudTheme
             ///红底白字
        case titleWhiteAndBackgroudRed
            ///白底(带边框)
        case titleAndOutline
    }
    
    func setCustomType(_ type: UIButton.CustomType, for state: UIControl.State = .normal) {
        switch type {
        case .titleWhiteAndBackgroudTheme:
            setTitleColor(.white, for: state)
            setBackgroundColor(.theme, for: state)
            
        case .titleWhiteAndBackgroudRed:
            setTitleColor(.white, for: state)
            setBackgroundColor(.red, for: state)

        case .titleAndOutline:
            var titleColor = self.titleColor(for: .normal) ?? UIColor.black
            if titleColor == UIColor.white {
                titleColor = UIColor.black
            }
            setTitleColor(titleColor, for: state)
            layer.borderColor = titleColor.cgColor
            layer.borderWidth = 1
            layer.cornerRadius = 5
                    
        default:
            break
        }
    }

//    /// 快速创建
//    convenience init(action:@escaping ControlClosure){
//        self.init()
//        self.addTarget(self, action:#selector(tapped(btn:)), for:.touchUpInside)
//        self.actionBlock = action
//        self.sizeToFit()
//    }
//
//    /// 快速创建按钮 setImage: 图片名 frame:frame action:点击事件的回调
//    convenience init(setImage: String, frame:CGRect, action: @escaping ControlClosure){
////        self.init()
//        self.init(action: action);
//
//        self.frame = frame
//        self.setImage(UIImage(named:setImage), for: .normal)
//        self.addTarget(self, action:#selector(tapped(btn:)), for:.touchUpInside)
//        self.actionBlock = action
//        self.sizeToFit()
//
//        self.frame = frame
//    }
    ///创建 UIBarButtonItem(customView
    convenience init(barItem obj: String){
        var size = CGSize(width: 32, height: 32)
        if UIImage(named: obj) != nil {
            size = CGSize(width: 40, height: 40)
        }
                
        self.init(type: .custom);
        self.frame = CGRect(x: 0, y: 0, width: size.width, height: size.height);
        self.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        
        if let image = UIImage(named: obj) {
            self.setImage(image, for: .normal);
        } else {
            self.setTitle(obj, for: .normal);
            if obj.count >= 4{
                self.titleLabel?.adjustsFontSizeToFitWidth = true;
                self.titleLabel?.minimumScaleFactor = 1;
            }
        }
    }
    
    /// [源]UIButton创建(标题)
    static func create(_ rect: CGRect = .zero, title: String, textColor: UIColor, backgroundColor: UIColor) -> Self {
        let view = self.init(type: .custom);
        view.titleLabel?.font = UIFont.systemFont(ofSize:16);
        view.titleLabel?.adjustsFontSizeToFitWidth = true;
        view.titleLabel?.minimumScaleFactor = 1.0;
        view.imageView?.contentMode = .scaleAspectFit
        view.isExclusiveTouch = true;
        view.adjustsImageWhenHighlighted = false;

        view.setTitle(title, for: .normal)
        view.setTitleColor(textColor, for: .normal)
        view.setBackgroundImage(UIImage(color: backgroundColor), for: .normal)
        view.setBackgroundImage(UIImage(color: .lightGray), for: .disabled)
        
        CGRect.zero != rect ? view.frame = rect : view.sizeToFit()
        return view
    }
        
    /// 创建 UIButton 集群
    static func createGroupView(_ rect: CGRect = .zero, list: [String], numberOfRow: Int = 4, padding: CGFloat = kPadding, action: ((UIButton)->Void)? = nil) -> UIView {
        
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
    
            if let action = action {
                button.addActionHandler(action)
            }
            backView.addSubview(button);
        }
        return backView;
    }
    
    /// 图片上左下右配置
    func layoutButton(direction: Int, imageTitleSpace: CGFloat = 5) {
        guard let titleLabel = titleLabel,
              let imageView = imageView else { return }
            
//        sizeToFit()
        //得到imageView和titleLabel的宽高
        let labelWidth: CGFloat = titleLabel.bounds.width
        let labelHeight: CGFloat = titleLabel.bounds.height
        
        let imageWidth: CGFloat = imageView.bounds.width
        let imageHeight: CGFloat = imageView.bounds.height
                
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets: UIEdgeInsets = .zero
        var labelEdgeInsets: UIEdgeInsets = .zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        //上 左 下 右
        switch direction {
        case 0:
            imageEdgeInsets = UIEdgeInsets(top: -labelHeight - imageTitleSpace/2,
                                           left: 0,
                                           bottom: 0,
                                           right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageWidth,
                                           bottom: -imageHeight - imageTitleSpace/2,
                                           right: 0)
            break;
        case 1:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageTitleSpace/2,
                                           bottom: 0,
                                           right: imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: imageTitleSpace/2,
                                           bottom: 0,
                                           right: -imageTitleSpace/2)
            break;
        case 2:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: 0,
                                           bottom: -labelHeight - imageTitleSpace/2,
                                           right: -labelWidth)
            labelEdgeInsets = UIEdgeInsets(top: -imageHeight - imageTitleSpace/2,
                                           left: -imageWidth,
                                           bottom: 0,
                                           right: 0)

            break;
        case 3:
            imageEdgeInsets = UIEdgeInsets(top: 0,
                                           left: labelWidth + imageTitleSpace/2,
                                           bottom: 0,
                                           right: -labelWidth - imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsets(top: 0,
                                           left: -imageWidth - imageTitleSpace/2,
                                           bottom: 0,
                                           right: imageWidth + imageTitleSpace/2)

            break;
        default:
            break
        }
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
    
    func setBackgroundColor(_ color: UIColor?, for state: UIControl.State){
        guard let color = color else { return }
        setBackgroundImage(UIImage(color: color), for: state)
    }
        
    /// UIButton不同状态下设置富文本标题
    func setContent(_ content: String, attDic: [NSAttributedString.Key: Any], for state: UIControl.State) -> NSMutableAttributedString?{
        guard let titleLabel = titleLabel,
              let text = titleLabel.text,
              text.contains(content)
              else { return nil }
        let attString = titleLabel.setContent(content, attDic: attDic)
        setAttributedTitle(attString, for: state)
        return attString
    }
    
    /// 验证码倒计时显示
    func timerStart(_ interval: Int = 60) {
        var time = interval
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
        codeTimer.setEventHandler {

            time -= 1
            DispatchQueue.main.async {
                self.isEnabled = time <= 0;
                if time > 0 {
                    self.setTitle("剩余\(time)s", for: .normal)
                    return;
                }
                codeTimer.cancel()
                self.setTitle("发送验证码", for: .normal)
            }
        }
        codeTimer.resume()
    }
}
