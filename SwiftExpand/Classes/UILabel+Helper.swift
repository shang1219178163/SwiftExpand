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
    
    convenience init(textColor: UIColor = .black, textAlignment: NSTextAlignment = .left) {
        self.init();
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.isUserInteractionEnabled = true;
        self.textAlignment = textAlignment;
        self.textColor = textColor
    }
    
    ///自定义按钮类型
    @objc enum LabelShowType: Int {
            ///多行
        case numLines = 0
            ///主题色底白字
        case oneLine
            ///带边框
        case titleAndOutline
            ///白底(带边框)
        case titleAndOutlineRadius
    }
    
    func setLabelType(_ type: UILabel.LabelShowType) {
        switch type {
        case .oneLine:
            numberOfLines = 1;
            lineBreakMode = .byTruncatingTail;
            adjustsFontSizeToFitWidth = true;

        case .titleAndOutline:
            numberOfLines = 1;
            lineBreakMode = .byTruncatingTail;
            textAlignment = .center;
            
            layer.borderColor = textColor.cgColor;
            layer.borderWidth = 1.0;
            layer.masksToBounds = true;
            layer.cornerRadius = 0;
            
        default:
            numberOfLines = 0;
            lineBreakMode = .byCharWrapping;
            break
        }
    }
    
    /// [源]UILabel创建
    static func create(_ rect: CGRect = .zero, textColor: UIColor = .black, type: UILabel.LabelShowType = .numLines) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        view.isUserInteractionEnabled = true;
        view.textAlignment = .left;
        view.textColor = textColor
        view.font = UIFont.systemFont(ofSize: 15);

        view.setLabelType(type)
        return view;
    }
    

    /// UILabel富文本设置
    func setContent(_ content: String, attDic: [NSAttributedString.Key: Any]) -> NSMutableAttributedString?{
        guard let text = self.text as String? else { return nil}

        let attString = NSMutableAttributedString(string: text)
        let range: NSRange = (text as NSString).range(of: content)
        attString.addAttributes(attDic, range: range)
        attributedText = attString
        return attString
    }
    
    /// 验证码倒计时显示
    func timerStart(_ interval: Int = 60) {
        var time = interval
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))
        codeTimer.setEventHandler {
            
            time -= 1
            DispatchQueue.main.async {
                self.isEnabled = time <= 0;
                if time > 0 {
                    self.text = "剩余\(time)s";
                    return;
                }
                codeTimer.cancel()
                self.text = "发送验证码";
            }
        }
        codeTimer.resume()
    }
}

@objc public extension UILabel{
        
//    func setupMenuItem(_ items: [UIMenuItem]) {
//        UIMenuController.shared.menuItems = items
//    }
    
    func addLongPressMenuItems() {
        isUserInteractionEnabled = true

        let recognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleMenuItems(_:)));
        addGestureRecognizer(recognizer)
    }
    
    // MARK: -funtions
    @objc func handleMenuItems(_ recognizer: UIGestureRecognizer) {
        guard let recognizerView = recognizer.view,
              let recognizerSuperView = recognizerView.superview
          else { return }
   
        if #available(iOS 13.0, *) {
            UIMenuController.shared.showMenu(from: recognizerSuperView, rect: recognizerView.frame)

        } else {
            UIMenuController.shared.setTargetRect(recognizerView.frame, in: recognizerSuperView)
            UIMenuController.shared.setMenuVisible(true, animated: true)
        }
        recognizerView.becomeFirstResponder()
    }
    
    // MARK: -edit menu
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override func canPerformAction(_ action: Selector, withSender sender: Any?) -> Bool {
        guard let menuItems = UIMenuController.shared.menuItems else { return [#selector(copy(_:))].contains(action)}
        let actions: [Selector] = menuItems.map { $0.action }
        return actions.contains(action)
    }
    
    // MARK: - UIResponderStandardEditActions
    override func copy(_ sender: Any?) {
        UIPasteboard.general.string = text
    }
    
    override func paste(_ sender: Any?) {
        text = UIPasteboard.general.string
    }
    
    override func delete(_ sender: Any?) {
        text = ""
    }
}
