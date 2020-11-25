# SwiftExpand
Swift SDK功能拓展 , Objective-C && Swift

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

**Get any pod bundle image**

    /// 获取 pod bundle 图片资源
    static func image(named name: String, podClassName: String, bundleName: String? = nil) -> UIImage?{
        let bundleNameNew = bundleName ?? podClassName
        if let image = UIImage(named: "\(bundleNameNew).bundle/\(name)") {
            return image;
        }

        let framework = Bundle.main
        let filePath = framework.resourcePath! + "/Frameworks/\(podClassName).framework/\(bundleNameNew).bundle"
        
        guard let bundle = Bundle(path: filePath) else { return nil}
        let image = UIImage(named: name, in: bundle, compatibleWith: nil)
        return image;
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

        ///手势 - 轻点 UITapGestureRecognizer
    @discardableResult
    public func addGestureTap(_ target: Any?, action: Selector?) -> UITapGestureRecognizer {
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
    public func addGestureTap(_ action: @escaping RecognizerClosure) -> UITapGestureRecognizer {
        let obj = UITapGestureRecognizer(target: nil, action: nil)
        obj.numberOfTapsRequired = 1  //轻点次数
        obj.numberOfTouchesRequired = 1  //手指个数

        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)

        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    public func addGestureLongPress(_ target: Any?, action: Selector?, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: target, action: action)
        obj.minimumPressDuration = minimumPressDuration;
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 长按 UILongPressGestureRecognizer
    @discardableResult
    public func addGestureLongPress(_ action: @escaping RecognizerClosure, for minimumPressDuration: TimeInterval) -> UILongPressGestureRecognizer {
        let obj = UILongPressGestureRecognizer(target: nil, action: nil)
        obj.minimumPressDuration = minimumPressDuration;
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 拖拽 UIPanGestureRecognizer
    @discardableResult
    public func addGesturePan(_ action: @escaping RecognizerClosure) -> UIPanGestureRecognizer {
        let obj = UIPanGestureRecognizer(target: nil, action: nil)
          //最大最小的手势触摸次数
        obj.minimumNumberOfTouches = 1
        obj.maximumNumberOfTouches = 3
          
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
          
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPanGestureRecognizer {
                let translate:CGPoint = sender.translation(in: sender.view?.superview)
                sender.view!.center = CGPoint(x: sender.view!.center.x + translate.x, y: sender.view!.center.y + translate.y)
                sender.setTranslation( .zero, in: sender.view!.superview)
                             
                action(recognizer)
            }
        }
        return obj
    }
      
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    public func addGestureEdgPan(_ target: Any?, action: Selector?, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: target, action: action)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 屏幕边缘 UIScreenEdgePanGestureRecognizer
    @discardableResult
    public func addGestureEdgPan(_ action: @escaping RecognizerClosure, for edgs: UIRectEdge) -> UIScreenEdgePanGestureRecognizer {
        let obj = UIScreenEdgePanGestureRecognizer(target: nil, action: nil)
        obj.edges = edgs
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
       
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    public func addGestureSwip(_ target: Any?, action: Selector?, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: target, action: action)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
        return obj
    }
    
    ///手势 - 清扫 UISwipeGestureRecognizer
    @discardableResult
    public func addGestureSwip(_ action: @escaping RecognizerClosure, for direction: UISwipeGestureRecognizer.Direction) -> UISwipeGestureRecognizer {
        let obj = UISwipeGestureRecognizer(target: nil, action: nil)
        obj.direction = direction
      
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            action(recognizer)
        }
        return obj
    }
      
    ///手势 - 捏合 UIPinchGestureRecognizer
    @discardableResult
    public func addGesturePinch(_ action: @escaping RecognizerClosure) -> UIPinchGestureRecognizer {
        let obj = UIPinchGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIPinchGestureRecognizer {
                let location = recognizer.location(in: sender.view!.superview)
                sender.view!.center = location;
                sender.view!.transform = sender.view!.transform.scaledBy(x: sender.scale, y: sender.scale)
                sender.scale = 1.0
                action(recognizer)
            }
        }
        return obj
    }
    
    ///手势 - 旋转 UIRotationGestureRecognizer
    @discardableResult
    public func addGestureRotation(_ action: @escaping RecognizerClosure) -> UIRotationGestureRecognizer {
        let obj = UIRotationGestureRecognizer(target: nil, action: nil)
        isUserInteractionEnabled = true
        isMultipleTouchEnabled = true
        addGestureRecognizer(obj)
      
        obj.addAction { (recognizer) in
            if let sender = recognizer as? UIRotationGestureRecognizer {
                sender.view!.transform = sender.view!.transform.rotated(by: sender.rotation)
                sender.rotation = 0.0;
                          
                action(recognizer)
            }
        }
        return obj
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
    
##  Requirements
    s.ios.deployment_target = '8.0'
    s.swift_version = "5.0"
    
##  Author

shang1219178163, shang1219178163@gmail.com

## License

CocoaExpand is available under the MIT license. See the LICENSE file for more info.