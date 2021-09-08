# SwiftExpand

Swift 的 SDK 功能扩展,提高工作效率, 低耦合(Objective-C && Swift, iOS && macOS)


## Usage：

**NNClassFromString**

    //get class by name
    public func NNClassFromString(_ name: String) -> AnyClass? {
        if let cls = NSClassFromString(name) {
    //        print("✅_Objc类存在: \(name)")
            return cls;
         }
         
         let swiftClassName = "\(UIApplication.appBundleName).\(name)";
         if let cls = NSClassFromString(swiftClassName) {
    //         print("✅_Swift类存在: \(swiftClassName)")
             return cls;
         }
         print("❌_类不存在: \(name)")
        return nil;
    }
    
**UICtrFromString**
    
    /// get UIViewController by name
    public func UICtrFromString(_ vcName: String) -> UIViewController {
        let cls: AnyClass = NNClassFromString(vcName)!;
        // 通过类创建对象， 不能用cls.init(),有的类可能没有init方法
        // 需将cls转换为制定类型
        let vcCls = cls as! UIViewController.Type;
        // 创建对象
        let controller: UIViewController = vcCls.init();
        controller.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return controller;
    }

**UITableViewCell**

    /// custom - UITableViewCell
    class UITableViewCellOne: UITableViewCell {}
    
    /// Reusable
    let cell = UITableViewCellOne.dequeueReusableCell(tableView)

    /// custom - UITableViewHeaderFooterView
    class UITableHeaderFooterViewZero: UITableViewHeaderFooterView {}

    /// Reusable
    let view = UITableHeaderFooterViewZero.dequeueReusableHeaderFooterView(tableView)

**UICollectionViewCell**

    ctView.dictClass = [UICollectionView.elementKindSectionHeader: ["UICTReusableViewOne",],
                        UICollectionView.elementKindSectionFooter: ["UICTReusableViewZero",],
                        UICollectionView.elementKindSectionItem: ["UICTViewCellZero","UICTViewCellOne"],]
                        
    /// custom - UICollectionViewCell
    class UICTViewCellOne: UICollectionViewCell { )   
    /// Reusable
    let cell = collectionView.dequeueReusableCell(for: UICTViewCellZero.self, indexPath: indexPath)
    
    /// custom - UICollectionReusableView
    class UICTViewCellOne: UICollectionReusableView { )  
    /// Reusable
    let view = collectionView.dequeueReusableSupplementaryView(for: UICTReusableViewOne.self, kind: kind, indexPath: indexPath)

**DateFormatter**

    @objc public extension DateFormatter{
    /// 获取DateFormatter(默认格式)
    static func format(_ formatStr: String = kDateFormat) -> DateFormatter {
        let dic = Thread.current.threadDictionary;
        if dic.object(forKey: formatStr) != nil {
            return dic.object(forKey: formatStr) as! DateFormatter;
        }
        
        let fmt = DateFormatter();
        fmt.dateFormat = formatStr;
        fmt.locale = .current;
        fmt.locale = Locale(identifier: "zh_CN");
        fmt.timeZone = formatStr.contains("GMT") ? TimeZone(identifier: "GMT") : TimeZone.current;
        
        dic.setObject(fmt, forKey: formatStr as NSCopying)
        return fmt;
    }
    
    /// Date -> String
    static func stringFromDate(_ date: Date, fmt: String = kDateFormat) -> String {
        let formatter = DateFormatter.format(fmt);
        return formatter.string(from: date);
    }
    
    /// String -> Date
    static func dateFromString(_ dateStr: String, fmt: String = kDateFormat) -> Date {
        let formatter = DateFormatter.format(fmt);
        return formatter.date(from: dateStr)!;
    }
    
    /// 时间戳字符串 -> 日期字符串
    static func stringFromInterval(_ interval: String, fmt: String = kDateFormat) -> String {
        let date = Date(timeIntervalSince1970: interval.doubleValue)
        return DateFormatter.stringFromDate(date, fmt: fmt);
    }

    /// 日期字符串 -> 时间戳字符串
    static func intervalFromDateStr(_ dateStr: String, fmt: String = kDateFormat) -> String {
        let date = DateFormatter.dateFromString(dateStr, fmt: fmt)
        return "\(date.timeIntervalSince1970)";
    }
    
**UIBarButtonItem**

    @objc extension UIBarButtonItem{
        private struct AssociateKeys {
        static var systemType = "UIBarButtonItem" + "systemType"
        static var closure = "UIBarButtonItem" + "closure"
    }
    /// UIBarButtonItem 回调
    public func addAction(_ closure: @escaping ((UIBarButtonItem) -> Void)) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        target = self;
        action = #selector(p_invoke);
    }
    
    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIBarButtonItem) -> Void) {
            closure(self);
        }
    }
}
    
**UIGestureRecognizer**

    @objc extension UIGestureRecognizer{
        private struct AssociateKeys {
        static var funcName   = "UIGestureRecognizer" + "funcName"
        static var closure    = "UIGestureRecognizer" + "closure"
    }
    /// 闭包回调
    public func addAction(_ closure: @escaping (UIGestureRecognizer) -> Void) {
        objc_setAssociatedObject(self, &AssociateKeys.closure, closure, .OBJC_ASSOCIATION_COPY_NONATOMIC);
        addTarget(self, action: #selector(p_invoke))
    }
    
    private func p_invoke() {
        if let closure = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ((UIGestureRecognizer) -> Void) {
            closure(self);
        }
    }
}

**UIViewController**
       
    @objc public extension UIViewController {
    
        /// 呈现    
        func present(_ animated: Bool = true, completion: (() -> Void)? = nil) {
            guard let keyWindow = UIApplication.shared.keyWindow,
                  let rootVC = keyWindow.rootViewController
                  else { return }
            if let presentedViewController = rootVC.presentedViewController {
                presentedViewController.dismiss(animated: false, completion: nil)
            }
            
            self.modalPresentationStyle = .fullScreen
            DispatchQueue.main.async {
                switch self {
                case let alertVC as UIAlertController:
                    if alertVC.preferredStyle == .alert {
                        if alertVC.actions.count == 0 {
                            rootVC.present(alertVC, animated: animated, completion: {
                                DispatchQueue.main.after(TimeInterval(kDurationToast), execute: {
                                    alertVC.dismiss(animated: animated, completion: completion)
                                })
                            })
                            return
                        }
                        rootVC.present(alertVC, animated: animated, completion: completion)
                    } else {
                        //防止 ipad 下 sheet 会崩溃的问题
                        if UIDevice.current.userInterfaceIdiom == .pad {
                            if let controller = alertVC.popoverPresentationController {
                                controller.permittedArrowDirections = UIPopoverArrowDirection(rawValue: 0)
                                controller.sourceView = keyWindow;
                                
                                let isEmpty = controller.sourceRect.equalTo(.null) || controller.sourceRect.equalTo(.zero)
                                if isEmpty {
                                    controller.sourceRect = CGRect(x: keyWindow.bounds.midX, y: 64, width: 1, height: 1);
                                }
                            }
                        }
                        rootVC.present(alertVC, animated: animated, completion: completion)
                    }
                    
                default:
                    rootVC.present(self, animated: animated, completion: completion)
                }
            }
        } 
        ///判断上一页是哪个页面
        public func pushFromVC(_ type: UIViewController.Type) -> Bool {
            
            guard let viewControllers = navigationController?.viewControllers else {
                return false }
            if viewControllers.count <= 1 {
                return false }
            guard let index = viewControllers.firstIndex(of: self) else {
                return false }
            let result = viewControllers[index - 1].isKind(of: type)
            return result
        }
    } 
    
**UIStackView**
    
    @objc public extension UIStackView {
        /// 设置子视图显示比例(此方法前请设置 .axis/.orientation)
        func setSubViewMultiplier(_ multiplier: CGFloat, at index: Int) {
            if index < subviews.count {
                let element = subviews[index];
                if self.axis == .horizontal {
                    element.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: multiplier).isActive = true
    
                } else {
                    element.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: multiplier).isActive = true
                }
            }
        }
    }
    
**UIView 手势**

    @objc public extension UIView {
        ///手势 - 轻点 UITapGestureRecognizer
        @discardableResult
        func addGestureTap(_ target: Any?, action: Selector?) -> UITapGestureRecognizer {
            let obj = UITapGestureRecognizer(target: target, action: action)
            obj.numberOfTapsRequired = 1  //轻点次数
            obj.numberOfTouchesRequired = 1  //手指个数
    
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
            return obj
        }
        
        ///手势 - 轻点 UITapGestureRecognizer
        @discardableResult
        func addGestureTap(_ action: @escaping ((UITapGestureRecognizer) ->Void)) -> UITapGestureRecognizer {
            let obj = UITapGestureRecognizer(target: nil, action: nil)
            obj.numberOfTapsRequired = 1  //轻点次数
            obj.numberOfTouchesRequired = 1  //手指个数
    
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
    
            obj.addAction(action)
            return obj
        }
        
        ///手势 - 长按 UILongPressGestureRecognizer
        @discardableResult
        func addGestureLongPress(_ target: Any?, action: Selector?, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
            let obj = UILongPressGestureRecognizer(target: target, action: action)
            obj.minimumPressDuration = minimumPressDuration;
          
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
            return obj
        }
        
        ///手势 - 长按 UILongPressGestureRecognizer
        @discardableResult
        func addGestureLongPress(_ action: @escaping ((UILongPressGestureRecognizer) ->Void), for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
            let obj = UILongPressGestureRecognizer(target: nil, action: nil)
            obj.minimumPressDuration = minimumPressDuration;
          
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
          
            obj.addAction { (recognizer) in
                action(recognizer as! UILongPressGestureRecognizer)
            }
            return obj
        }
          
        ///手势 - 拖拽 UIPanGestureRecognizer
        @discardableResult
        func addGesturePan(_ action: @escaping ((UIPanGestureRecognizer) ->Void)) -> UIPanGestureRecognizer {
            let obj = UIPanGestureRecognizer(target: nil, action: nil)
              //最大最小的手势触摸次数
            obj.minimumNumberOfTouches = 1
            obj.maximumNumberOfTouches = 3
              
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
              
            obj.addAction { (recognizer) in
                if let gesture = recognizer as? UIPanGestureRecognizer {
                    let translate: CGPoint = gesture.translation(in: gesture.view?.superview)
                    gesture.view!.center = CGPoint(x: gesture.view!.center.x + translate.x, y: gesture.view!.center.y + translate.y)
                    gesture.setTranslation( .zero, in: gesture.view!.superview)
                                 
                    action(gesture)
                }
            }
            return obj
        }
          
        ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
        @discardableResult
        func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
            let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
            obj.edges = edgs
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
            return obj
        }
        
        ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
        @discardableResult
        func addGestureEdgPan(_ action: @escaping ((UIScreenEdgePanGestureRecognizer) ->Void), for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
            let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
            obj.edges = edgs
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
           
            obj.addAction { (recognizer) in
                action(recognizer as! UIScreenEdgePanGestureRecognizer)
            }
            return obj
        }
          
        ///手势 - 清扫 UISwipeGestureRecognizer
        @discardableResult
        func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
            let obj = UISwipeGestureRecognizer(target: target, action: action)
            obj.direction = direction
          
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
            return obj
        }
        
        ///手势 - 清扫 UISwipeGestureRecognizer
        @discardableResult
        func addGestureSwip(_ action: @escaping ((UISwipeGestureRecognizer) ->Void), for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
            let obj = UISwipeGestureRecognizer(target: nil, action: nil)
            obj.direction = direction
          
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
          
            obj.addAction { (recognizer) in
                action(recognizer as! UISwipeGestureRecognizer)
            }
            return obj
        }
          
        ///手势 - 捏合 UIPinchGestureRecognizer
        @discardableResult
        func addGesturePinch(_ action: @escaping ((UIPinchGestureRecognizer) ->Void)) -> UIPinchGestureRecognizer {
            let obj = UIPinchGestureRecognizer(target: nil, action: nil)
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
          
            obj.addAction { (recognizer) in
                if let gesture = recognizer as? UIPinchGestureRecognizer {
                    let location = recognizer.location(in: gesture.view!.superview)
                    gesture.view!.center = location;
                    gesture.view!.transform = gesture.view!.transform.scaledBy(x: gesture.scale, y: gesture.scale)
                    gesture.scale = 1.0
                    action(gesture)
                }
            }
            return obj
        }
        
        ///手势 - 旋转 UIRotationGestureRecognizer
        @discardableResult
        func addGestureRotation(_ action: @escaping ((UIRotationGestureRecognizer) ->Void)) -> UIRotationGestureRecognizer {
            let obj = UIRotationGestureRecognizer(target: nil, action: nil)
            isUserInteractionEnabled = true
            isMultipleTouchEnabled = true
            addGestureRecognizer(obj)
          
            obj.addAction { (recognizer) in
                if let gesture = recognizer as? UIRotationGestureRecognizer {
                    gesture.view!.transform = gesture.view!.transform.rotated(by: gesture.rotation)
                    gesture.rotation = 0.0;
                              
                    action(gesture)
                }
            }
            return obj
        }
    }
    
    extension Array where Element : UIView {
        ///手势 - 轻点 UITapGestureRecognizer
        @discardableResult
        public func addGestureTap(_ action: @escaping RecognizerClosure) -> [UITapGestureRecognizer] {
            
            var list = [UITapGestureRecognizer]()
            forEach {
                let obj = $0.addGestureTap(action)
                list.append(obj)
            }
            return list
        }
    }
    
**UIView 密集子视图**

    public extension UIView{
        
        ///更新各种子视图
        @discardableResult
        final func updateItems<T: UIView>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
            if count == 0 {
                subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }
                return []
            }
            
            if let list = self.subviews.filter({ $0.isMember(of: type) }) as? [T] {
                if list.count == count {
                    list.forEach { hanler($0) }
                    return list
                }
            }
            
            subviews.filter { $0.isMember(of: type) }.forEach { $0.removeFromSuperview() }
        
            var arr: [T] = [];
            for i in 0..<count {
                let subview = type.init(frame: .zero)
                subview.tag = i
                self.addSubview(subview)
                arr.append(subview)
                
                hanler(subview)
            }
            return arr;
        }
        
        ///更新各种子类按钮
        @discardableResult
        final func updateButtonItems<T: UIButton>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
            return updateItems(count, type: type) {
                if $0.title(for: .normal) == nil {
                    $0.titleLabel?.font = UIFont.systemFont(ofSize: 15)
                    $0.setTitle("\(type)\($0.tag)", for: .normal)
                    $0.setTitleColor(.black, for: .normal)
                    $0.setBackgroundColor(.lightGray, for: .disabled)
                }
                hanler($0)
            }
        }
        
        ///更新各种子类UILabel
        @discardableResult
        final func updateLabelItems<T: UILabel>(_ count: Int, type: T.Type, hanler: ((T) -> Void)) -> [T] {
            return updateItems(count, type: type) {
                if $0.text == nil {
                    $0.text = "\(type)\($0.tag)"
                    $0.font = UIFont.systemFont(ofSize: 15)
                }
                hanler($0)
            }
        }
        
        /// [源]创建子类型的 view(例如 cell headerView)
        @discardableResult
        final func createSubTypeView<T: UIView>(_ type: T.Type, height: CGFloat = 30, inset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), block: @escaping ((T)->Void)) -> UIView{
            if let subView = viewWithTag(tag) as? T {
                block(subView)
                return subView
            }
            let sectionView = UIView(frame: CGRect(x: 0, y: 0, width: bounds.width, height: height))
            sectionView.backgroundColor = .background
        
            let view = type.init(frame: CGRect(x: inset.left,
                                               y: inset.top,
                                               width: bounds.width - inset.left - inset.right,
                                               height: height - inset.top - inset.bottom));
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight, ]
            view.tag = tag
            sectionView.addSubview(view)
            block(view)
            return sectionView
        }
        
        /// [源]创建子类型的 view(cell 添加视图)
        @discardableResult
        final func createSubTypeView<T: UIView>(_ type: T.Type, tag: Int, inset: UIEdgeInsets = .zero, block: @escaping ((T)->Void)) -> UIView{
            if let subView = viewWithTag(tag) as? T {
                block(subView)
                return subView
            }
            
            let view = type.init(frame: CGRect(x: inset.left,
                                               y: inset.top,
                                               width: bounds.width - inset.left - inset.right,
                                               height: bounds.height - inset.top - inset.bottom));
            view.autoresizingMask = [.flexibleWidth, .flexibleHeight, ]
            view.tag = tag
            addSubview(view)
            block(view)
            return view
        }
    }

**UIControl 事件**

    @objc extension UIControl {
        private struct AssociateKeys {
            static var closure   = "UIControl" + "closure"
        }
        /// UIControl 添加回调方式
        public func addActionHandler(_ action: @escaping ControlClosure, for controlEvents: UIControl.Event = .touchUpInside) {
            addTarget(self, action:#selector(p_handleAction(_:)), for:controlEvents);
            objc_setAssociatedObject(self, &AssociateKeys.closure, action, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
        }
        
        /// 点击回调
        private func p_handleAction(_ sender: UIControl) {
            if let block = objc_getAssociatedObject(self, &AssociateKeys.closure) as? ControlClosure {
                block(sender);
            }
        }
    }
    
    
**NSAttributedString 属性链式编程实现**

    ///属性链式编程实现
    @objc public extension NSAttributedString {
            
        func addAttributes(_ attributes: [NSAttributedString.Key: Any]) -> NSAttributedString {
            let mattr = NSMutableAttributedString(attributedString: self)
            mattr.addAttributes(attributes, range: NSMakeRange(0, self.length))
            return mattr
        }
        
        func font(_ font: UIFont) -> NSAttributedString {
            return addAttributes([NSAttributedString.Key.font: font])
        }
        
        func color(_ color: UIColor) -> NSAttributedString {
            return addAttributes([NSAttributedString.Key.foregroundColor: color])
        }
        
        func bgColor(_ color: UIColor) -> NSAttributedString {
            return addAttributes([NSAttributedString.Key.backgroundColor: color])
        }
        
        func link(_ value: String) -> NSAttributedString {
            return linkURL(URL(string: value)!)
        }
        
        func linkURL(_ value: URL) -> NSAttributedString {
            return addAttributes([NSAttributedString.Key.link: value])
        }
        //设置字体倾斜度，取值为float，正值右倾，负值左倾
        func oblique(_ value: CGFloat = 0.1) -> NSAttributedString {
            return addAttributes([NSAttributedString.Key.obliqueness: value])
        }
           
        //字符间距
        func kern(_ value: CGFloat) -> NSAttributedString {
            return addAttributes([.kern: value])
        }
        
        //设置字体的横向拉伸，取值为float，正值拉伸 ，负值压缩
        func expansion(_ value: CGFloat) -> NSAttributedString {
            return addAttributes([.expansion: value])
        }
        
        //设置下划线
        func underline(_ color: UIColor, _ style: NSUnderlineStyle = .single) -> NSAttributedString {
            return addAttributes([
                .underlineColor: color,
                .underlineStyle: style.rawValue
            ])
        }
        
        //设置删除线
        func strikethrough(_ color: UIColor, _ style: NSUnderlineStyle = .single) -> NSAttributedString {
            return addAttributes([
                .strikethroughColor: color,
                .strikethroughStyle: style.rawValue,
            ])
        }
        
        ///设置基准位置 (正上负下)
        func baseline(_ value: CGFloat) -> NSAttributedString {
            return addAttributes([.baselineOffset: value])
        }
        
        ///设置段落
        func paraStyle(_ alignment: NSTextAlignment,
                              lineSpacing: CGFloat = 0,
                              paragraphSpacingBefore: CGFloat = 0,
                              lineBreakMode: NSLineBreakMode = .byTruncatingTail) -> NSAttributedString {
            let style = NSMutableParagraphStyle()
            style.alignment = alignment
            style.lineBreakMode = lineBreakMode
            style.lineSpacing = lineSpacing
            style.paragraphSpacingBefore = paragraphSpacingBefore
            return addAttributes([.paragraphStyle: style])
        }
            
        ///设置段落
        func paragraphStyle(_ style: NSMutableParagraphStyle) -> NSAttributedString {
            return addAttributes([.paragraphStyle: style])
        }
    }
    
    public extension String {
    
        /// -> NSAttributedString
        var attributed: NSAttributedString{
            return NSAttributedString(string: self)
        }
    }

    @objc public extension NSMutableParagraphStyle{
        
        func lineSpacingChain(_ value: CGFloat) -> Self {
            self.lineSpacing = value
            return self
        }
        
        func paragraphSpacing(_ value: CGFloat) -> Self {
            self.paragraphSpacing = value
            return self
        }
        
        func alignment(_ value: NSTextAlignment) -> Self {
            self.alignment = value
            return self
        }
        
        func firstLineHeadIndent(_ value: CGFloat) -> Self {
            self.firstLineHeadIndent = value
            return self
        }
        
        func headIndent(_ value: CGFloat) -> Self {
            self.headIndent = value
            return self
        }
        
        func tailIndent(_ value: CGFloat) -> Self {
            self.tailIndent = value
            return self
        }
        
        func lineBreakMode(_ value: NSLineBreakMode) -> Self {
            self.lineBreakMode = value
            return self
        }
        
        func minimumLineHeight(_ value: CGFloat) -> Self {
            self.minimumLineHeight = value
            return self
        }
        
        func maximumLineHeight(_ value: CGFloat) -> Self {
            self.maximumLineHeight = value
            return self
        }
        
        func baseWritingDirection(_ value: NSWritingDirection) -> Self {
            self.baseWritingDirection = value
            return self
        }
        
        func lineHeightMultiple(_ value: CGFloat) -> Self {
            self.lineHeightMultiple = value
            return self
        }
        
        func paragraphSpacingBefore(_ value: CGFloat) -> Self {
            self.paragraphSpacingBefore = value
            return self
        }
        
        func hyphenationFactor(_ value: Float) -> Self {
            self.hyphenationFactor = value
            return self
        }
        
        func tabStops(_ value: [NSTextTab]) -> Self {
            self.tabStops = value
            return self
        }
        
        func defaultTabInterval(_ value: CGFloat) -> Self {
            self.defaultTabInterval = value
            return self
        }
        
        func allowsDefaultTighteningForTruncation(_ value: Bool) -> Self {
            self.allowsDefaultTighteningForTruncation = value
            return self
        }
        
        func lineBreakStrategy(_ value: NSParagraphStyle.LineBreakStrategy) -> Self {
            self.lineBreakStrategy = value
            return self
        }
            
        func addTabStopChain(_ value: NSTextTab) -> Self {
            self.addTabStop(value)
            return self
        }
        
        func removeTabStopChain(_ value: NSTextTab) -> Self {
            self.removeTabStop(value)
            return self
        }
        
        func setParagraphStyleChain(_ value: NSParagraphStyle) -> Self {
            self.setParagraphStyle(value)
            return self
        }
    }


    
##  Requirements

    s.ios.deployment_target = '10.0'
    s.osx.deployment_target = '10.13'
    
    s.swift_version = "5"
    
##  Author

shang1219178163, shang1219178163@gmail.com

## License

SwiftExpand is available under the MIT license. See the LICENSE file for more info.
