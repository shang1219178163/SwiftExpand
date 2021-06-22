//
//  NSButton+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/23.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSButton {
    private struct AssociateKeys {
        static var closure   = "NSButton" + "closure"
    }
    
    /// 闭包回调(NSSegmentedControl 专用)
    override func addActionHandler(_ handler: @escaping ((NSButton) -> Void)) {
        target = self
        action = #selector(p_invokeButton(_:))
        objc_setAssociatedObject(self, &AssociateKeys.closure, handler, .OBJC_ASSOCIATION_COPY_NONATOMIC)
    }
    
    private func p_invokeButton(_ sender: NSButton) {
        if let handler = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((NSButton) -> Void) {
            handler(sender)
        }
    }

    // MARK: -funtions
    
    func setTitleColor(_ color: NSColor, font: Font = Font.systemFont(ofSize: 15)) {
        let attDic: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color,
        ]
        self.attributedTitle = NSAttributedString(string: title, attributes: attDic)
    }
    
    /// 验证码倒计时显示
    func timerStart(_ interval: Int = 60) {
        var time = interval
        let codeTimer = DispatchSource.makeTimerSource(flags: .init(rawValue: 0), queue: DispatchQueue.global())
        codeTimer.schedule(deadline: .now(), repeating: .milliseconds(1000))  //此处方法与Swift 3.0 不同
        codeTimer.setEventHandler {

            time -= 1
            DispatchQueue.main.async {
                self.isEnabled = time <= 0
                if time > 0 {
                    self.title = "剩余\(time)s"
                    return
                }
                codeTimer.cancel()
                self.title = "发送验证码"
            }
        }
        codeTimer.resume()
    }
}
