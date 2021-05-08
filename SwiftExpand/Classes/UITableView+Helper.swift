//
//  UITableView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

@objc public extension UITableView{
    
    func dataSourceChain(_ dataSource: UITableViewDataSource?) -> Self {
        self.dataSource = dataSource
        return self
    }

    func delegateChain(_ delegate: UITableViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    @available(iOS 10.0, *)
    func prefetchDataSourceChain(_ prefetchDataSource: UITableViewDataSourcePrefetching?) -> Self {
        self.prefetchDataSource = prefetchDataSource
        return self
    }

    @available(iOS 11.0, *)
    func dragDelegateChain(_ dragDelegate: UITableViewDragDelegate?) -> Self {
        self.dragDelegate = dragDelegate
        return self
    }

    @available(iOS 11.0, *)
    func dropDelegateChain(_ dropDelegate: UITableViewDropDelegate?) -> Self {
        self.dropDelegate = dropDelegate
        return self
    }

    // default is UITableViewAutomaticDimension
    func rowHeightChain(_ rowHeight: CGFloat) -> Self {
        self.rowHeight = rowHeight
        return self
    }

    // default is UITableViewAutomaticDimension
    func sectionHeaderHeightChain(_ sectionHeaderHeight: CGFloat) -> Self {
        self.sectionHeaderHeight = sectionHeaderHeight
        return self
    }

    // default is UITableViewAutomaticDimension
    func sectionFooterHeightChain(_ sectionFooterHeight: CGFloat) -> Self {
        self.sectionFooterHeight = sectionFooterHeight
        return self
    }

    // default is UITableViewAutomaticDimension, set to 0 to disable
    @available(iOS 7.0, *)
    func estimatedRowHeightChain(_ estimatedRowHeight: CGFloat) -> Self {
        self.estimatedRowHeight = estimatedRowHeight
        return self
    }

    // default is UITableViewAutomaticDimension, set to 0 to disable
    @available(iOS 7.0, *)
    func estimatedSectionHeaderHeightChain(_ estimatedSectionHeaderHeight: CGFloat) -> Self {
        self.estimatedSectionHeaderHeight = estimatedSectionHeaderHeight
        return self
    }

    // default is UITableViewAutomaticDimension, set to 0 to disable
    @available(iOS 7.0, *)
    func estimatedSectionFooterHeightChain(_ estimatedSectionFooterHeight: CGFloat) -> Self {
        self.estimatedSectionFooterHeight = estimatedSectionFooterHeight
        return self
    }

    // allows customization of the frame of cell separators; see also the separatorInsetReference property. Use UITableViewAutomaticDimension for the automatic inset for that edge.
    @available(iOS 7.0, *)
    func separatorInsetChain(_ separatorInset: UIEdgeInsets) -> Self {
        self.separatorInset = separatorInset
        return self
    }

    // Changes how custom separatorInset values are interpreted. The default value is UITableViewSeparatorInsetFromCellEdges
    @available(iOS 11.0, *)
    func separatorInsetReferenceChain(_ separatorInsetReference: UITableView.SeparatorInsetReference) -> Self {
        self.separatorInsetReference = separatorInsetReference
        return self
    }

    // the background view will be automatically resized to track the size of the table view.  this will be placed as a subview of the table view behind all cells and headers/footers.  default may be non-nil for some devices.
    @available(iOS 3.2, *)
    func backgroundViewChain(_ backgroundView: UIView?) -> Self {
        self.backgroundView = backgroundView
        return self
    }

    // default is NO. setting is not animated.
    func isEditingChain(_ isEditing: Bool) -> Self {
        self.isEditing = isEditing
        return self
    }

    // default is YES. Controls whether rows can be selected when not in editing mode
    @available(iOS 3.0, *)
    func allowsSelectionChain(_ allowsSelection: Bool) -> Self {
        self.allowsSelection = allowsSelection
        return self
    }

    // default is NO. Controls whether rows can be selected when in editing mode
    func allowsSelectionDuringEditingChain(_ allowsSelectionDuringEditing: Bool) -> Self {
        self.allowsSelectionDuringEditing = allowsSelectionDuringEditing
        return self
    }

    // default is NO. Controls whether multiple rows can be selected simultaneously
    @available(iOS 5.0, *)
    func allowsMultipleSelectionChain(_ allowsMultipleSelection: Bool) -> Self {
        self.allowsMultipleSelection = allowsMultipleSelection
        return self
    }

    // default is NO. Controls whether multiple rows can be selected simultaneously in editing mode
    @available(iOS 5.0, *)
    func allowsMultipleSelectionDuringEditingChain(_ allowsMultipleSelectionDuringEditing: Bool) -> Self {
        self.allowsMultipleSelectionDuringEditing = allowsMultipleSelectionDuringEditing
        return self
    }

    // show special section index list on right when row count reaches this value. default is 0
    func sectionIndexMinimumDisplayRowCountChain(_ sectionIndexMinimumDisplayRowCount: Int) -> Self {
        self.sectionIndexMinimumDisplayRowCount = sectionIndexMinimumDisplayRowCount
        return self
    }

    // color used for text of the section index
    @available(iOS 6.0, *)
    func sectionIndexColorChain(_ sectionIndexColor: UIColor?) -> Self {
        self.sectionIndexColor = sectionIndexColor
        return self
    }

    // the background color of the section index while not being touched
    @available(iOS 7.0, *)
    func sectionIndexBackgroundColorChain(_ sectionIndexBackgroundColor: UIColor?) -> Self {
        self.sectionIndexBackgroundColor = sectionIndexBackgroundColor
        return self
    }

    // the background color of the section index while it is being touched
    @available(iOS 6.0, *)
    func sectionIndexTrackingBackgroundColorChain(_ sectionIndexTrackingBackgroundColor: UIColor?) -> Self {
        self.sectionIndexTrackingBackgroundColor = sectionIndexTrackingBackgroundColor
        return self
    }

    // default is UITableViewCellSeparatorStyleSingleLine
    func separatorStyleChain(_ separatorStyle: UITableViewCell.SeparatorStyle) -> Self {
        self.separatorStyle = separatorStyle
        return self
    }

    // default is the standard separator gray
    func separatorColorChain(_ separatorColor: UIColor?) -> Self {
        self.separatorColor = separatorColor
        return self
    }

    // effect to apply to table separators
    @available(iOS 8.0, *)
    func separatorEffectChain(_ separatorEffect: UIVisualEffect?) -> Self {
        self.separatorEffect = separatorEffect
        return self
    }

    // if cell layout margins are derived from the width of the readableContentGuide. default is NO.
    @available(iOS 9.0, *)
    func cellLayoutMarginsFollowReadableWidthChain(_ cellLayoutMarginsFollowReadableWidth: Bool) -> Self {
        self.cellLayoutMarginsFollowReadableWidth = cellLayoutMarginsFollowReadableWidth
        return self
    }

    // default value is YES
    @available(iOS 11.0, *)
    func insetsContentViewsToSafeAreaChain(_ insetsContentViewsToSafeArea: Bool) -> Self {
        self.insetsContentViewsToSafeArea = insetsContentViewsToSafeArea
        return self
    }

    // accessory view for above row content. default is nil. not to be confused with section header
    func tableHeaderViewChain(_ tableHeaderView: UIView?) -> Self {
        self.tableHeaderView = tableHeaderView
        return self
    }

    // accessory view below content. default is nil. not to be confused with section footer
    func tableFooterViewChain(_ tableFooterView: UIView?) -> Self {
        self.tableFooterView = tableFooterView
        return self
    }

    // defaults to NO. If YES, when focusing on a table view the last focused index path is focused automatically. If the table view has never been focused, then the preferred focused index path is used.
    @available(iOS 9.0, *)
    func remembersLastFocusedIndexPathChain(_ remembersLastFocusedIndexPath: Bool) -> Self {
        self.remembersLastFocusedIndexPath = remembersLastFocusedIndexPath
        return self
    }

    @available(iOS 14.0, *)
    func selectionFollowsFocusChain(_ selectionFollowsFocus: Bool) -> Self {
        self.selectionFollowsFocus = selectionFollowsFocus
        return self
    }

    @available(iOS 11.0, *)
    func dragInteractionEnabledChain(_ dragInteractionEnabled: Bool) -> Self {
        self.dragInteractionEnabled = dragInteractionEnabled
        return self
    }

    
    /// [源]UITableView创建
    static func create(_ rect: CGRect = .zero, style: UITableView.Style = .plain, rowHeight: CGFloat = 70.0) -> Self{
        let table = self.init(frame: rect, style: style)
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.separatorStyle = .singleLine
        table.separatorInset = .zero
        table.rowHeight = rowHeight
//        table.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        table.keyboardDismissMode = .onDrag
        table.backgroundColor = .groupTableViewBackground
//        table.tableHeaderView = UIView();
//        table.tableFooterView = UIView()

        table.estimatedRowHeight = 0;
        table.estimatedSectionHeaderHeight = 0;
        table.estimatedSectionFooterHeight = 0;
        return table
    }
    
    convenience init(rect: CGRect = .zero, style: UITableView.Style = .plain, rowHeight: CGFloat = 70.0) {
        self.init(frame: rect, style: style)
        self.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        self.separatorStyle = .singleLine
        self.separatorInset = .zero
        self.rowHeight = rowHeight
//        self.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self))
        self.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        self.keyboardDismissMode = .onDrag
        self.backgroundColor = .groupTableViewBackground
//        self.tableHeaderView = UIView();
//        self.tableFooterView = UIView()

        self.estimatedRowHeight = 0;
        self.estimatedSectionHeaderHeight = 0;
        self.estimatedSectionFooterHeight = 0;
    }
    
    func adJustedContentIOS11() {
        if #available(iOS 11.0, *) {
            contentInsetAdjustmentBehavior = .never
            estimatedRowHeight = 0;
            estimatedSectionHeaderHeight = 0;
            estimatedSectionFooterHeight = 0;
        }
    }
    
    /// 刷新行数组
    func reloadRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .automatic) {
        assert(section <= numberOfSections)
        let rowMax = rowList.value(forKeyPath: kArrMaxInter) as! Int
        assert(rowMax < numberOfRows(inSection: section))
        
        var marr: [IndexPath] = []
        for e in rowList.enumerated() {
            if let row = e.element as? NSNumber {
                marr.append(IndexPath(row: row.intValue , section: section))

            }
        }
        beginUpdates()
        reloadRows(at: marr, with: rowAnimation)
        endUpdates()
    }
    /// 插入行数组
    func insertRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .automatic) {
        var marr: [IndexPath] = []
        for e in rowList.enumerated() {
            if let row = e.element as? NSNumber {
                marr.append(IndexPath(row: row.intValue , section: section))
                
            }
        }
        beginUpdates()
        insertRows(at: marr, with: rowAnimation)
        endUpdates()
    }
    /// 删除行数组
    func deleteRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .automatic) {
        assert(section <= numberOfSections)
        let rowMax = rowList.value(forKeyPath: kArrMaxInter) as! Int
        assert(rowMax < numberOfRows(inSection: section))
        
        if rowList.count == numberOfRows(inSection: section) && numberOfSections != 1 {
            beginUpdates()
            deleteSections(NSIndexSet(index: section) as IndexSet, with: rowAnimation)
            endUpdates()
        } else {
            var marr: [IndexPath] = []
            for e in rowList.enumerated() {
                if let row = e.element as? NSNumber {
                    marr.append(IndexPath(row: row.intValue , section: section))
                    
                }
            }
            beginUpdates()
            deleteRows(at: marr, with: rowAnimation)
            endUpdates()
        }
    }

    ///获取子视图对应 cell 的 IndexPath
    func indexPath(subview view: UIView) -> IndexPath?{
        guard let cell = view.findSupView(UITableViewCell.self) as? UITableViewCell else { return nil}
        return self.indexPath(for: cell)
    }

    /// [源]HeaderView,footerView(兼容 OC)
    func createSectionViewLabel(_ height: CGFloat = 30, labelInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), block: @escaping ((UILabel)->Void)) -> UIView{
        let sectionView = UIView()
        sectionView.backgroundColor = .background
                
        let view = UILabel(frame: CGRect(x: labelInset.left,
                                         y: labelInset.top,
                                         width: bounds.width - labelInset.left - labelInset.right,
                                         height: height - labelInset.top - labelInset.bottom));
        view.isUserInteractionEnabled = true;
        view.adjustsFontSizeToFitWidth = true;
        view.lineBreakMode = .byTruncatingTail;

        view.textColor = .gray;
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 15)
        sectionView.addSubview(view)
        return sectionView
    }
    ///section cell添加圆角
    func addSectionRoundCorner(_ radius: CGFloat = 10, padding: CGFloat = 10, cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.selectionStyle = .none;
        cell.separatorInset = UIEdgeInsets(top: 0, left: padding*2, bottom: 0, right: padding*2)
        // 设置cell 背景色为透明
        cell.backgroundColor = UIColor.clear
        
//        // 圆角角度
//        let radius: CGFloat = 10
        // 获取显示区域大小
        let bounds: CGRect = cell.bounds.insetBy(dx: padding, dy: 0)
        // 获取每组行数
        let rowNum: Int = self.numberOfRows(inSection: indexPath.section)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath?
        if rowNum == 1 {
            // 一组只有一行（四个角全部为圆角）
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: .allCorners, cornerRadii: CGSize(width: radius, height: radius))
            
        } else {
            if indexPath.row == 0 {
                // 每组第一行（添加左上和右上的圆角）
                bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
            } else if indexPath.row == rowNum-1 {
                // 每组最后一行（添加左下和右下的圆角）
                bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
            } else {
                // 每组不是首位的行不设置圆角
                bezierPath = UIBezierPath(rect: bounds)
            }
        }

        // 创建两个layer
        let normalLayer = CAShapeLayer()
        let selectLayer = CAShapeLayer()
        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath?.cgPath
        selectLayer.path = bezierPath?.cgPath
        
        // 设置填充颜色
        normalLayer.fillColor = UIColor.white.cgColor
        normalLayer.strokeColor = UIColor.white.cgColor
        // 设置填充颜色
        selectLayer.fillColor = UIColor.white.cgColor
        selectLayer.strokeColor = UIColor.white.cgColor
        cell.layer.insertSublayer(normalLayer, at: 0)
//        cell.layer.insertSublayer(selectLayer, at: 1)
    }
    
    ///section headerFooterView添加圆角
    func addSectionHeaderFooterRoundCorner(_ radius: CGFloat = 10, padding: CGFloat = 10, headerFooterView: UIView, isHeader: Bool) {
        // 获取显示区域大小
        let bounds: CGRect = headerFooterView.bounds.insetBy(dx: padding, dy: 0)
        // 贝塞尔曲线
        var bezierPath: UIBezierPath?
        if isHeader == true {
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: radius, height: radius))
        } else  {
            bezierPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.bottomLeft, .bottomRight], cornerRadii: CGSize(width: radius, height: radius))
        }

        // 创建两个layer
        let normalLayer = CAShapeLayer()
        // 把已经绘制好的贝塞尔曲线路径赋值给图层，然后图层根据path进行图像渲染render
        normalLayer.path = bezierPath?.cgPath
        normalLayer.fillColor = UIColor.white.cgColor
        normalLayer.strokeColor = UIColor.white.cgColor
        headerFooterView.layer.insertSublayer(normalLayer, at: 0)
    }
    
}

public extension UITableView{
    /// 泛型复用register cell - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UITableViewCell>(cellType: T.Type, forCellReuseIdentifier identifier: String = String(describing: T.self)){
        register(cellType.self, forCellReuseIdentifier: identifier)
    }
    /// 泛型复用register UITableViewHeaderFooterView - Type: "类名.self" (备用默认值 T.self)
    final func register<T: UITableViewHeaderFooterView>(cellType: T.Type, forHeaderFooterViewReuseIdentifier identifier: String = String(describing: T.self)){
        register(cellType.self, forHeaderFooterViewReuseIdentifier: identifier)
    }
    
    /// 泛型复用cell - cellType: "类名.self" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: UITableViewCell>(for cellType: T.Type, identifier: String = String(describing: T.self), style: UITableViewCell.CellStyle = .default) -> T{
        //        let identifier = String(describing: T.self)
        var cell = self.dequeueReusableCell(withIdentifier: identifier);
        if cell == nil {
            cell = T.init(style: style, reuseIdentifier: identifier);
        }
        
        cell!.selectionStyle = .none;
        cell!.separatorInset = .zero;
        cell!.layoutMargins = .zero;
        cell!.backgroundColor = .white
        return cell! as! T;
    }
    
    /// 泛型复用cell - aClass: "类名()" (默认identifier: 类名字符串)
    final func dequeueReusableCell<T: UITableViewCell>(for aClass: T, identifier: String = String(describing: T.self), style: UITableViewCell.CellStyle = .default) -> T{
        return dequeueReusableCell(for: T.self, identifier: identifier, style: style)
    }
    
    /// 泛型复用HeaderFooterView - cellType: "类名.self" (备用默认值 T.self)
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for cellType: T.Type, identifier: String = String(describing: T.self)) -> T{
        var cell = self.dequeueReusableHeaderFooterView(withIdentifier: identifier);
        if cell == nil {
            cell = T.init(reuseIdentifier: identifier);
        }
        cell!.layoutMargins = .zero;
        return cell! as! T;
    }
    
    /// 泛型复用HeaderFooterView - aClass: "类名()" (默认identifier: 类名字符串)
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for aClass: T, identifier: String = String(describing: T.self)) -> T{
        return dequeueReusableHeaderFooterView(for: T.self, identifier: identifier)
    }
        
    /// 按照时间值划分section(例如 var mdic:[String: [NSObject]] = [:] //全局变量)
    @discardableResult
    static func sectionByDatetime<T: NSObject>(_ timeKey: String, length: Int = 9, mdic: inout [String: [T]], list: [T])  -> [String: [T]] {
        for e in list.enumerated() {
            if let time = e.element.value(forKey: timeKey) as? String {
                let key = time.count >= length ? (time as NSString).substring(to: length) : time;
                if mdic[key] == nil {
                    mdic[key] = [];
                }
                mdic[key]?.append(e.element as T)
            }
        }
        return mdic
    }
    
    /// 获取section模型数组(例如 var mdic:[String: [NSObject]] = [:] //全局变量)
    static func sectionModelList<T: NSObject>(_ section: Int, mdic: inout [String: [T]]) -> [T]? {
        let keys = mdic.keys.sorted(by: > )
        if keys.count <= 0 {
            return nil;
        }
        let key = keys[section]
        let modelList = mdic[key]
        return modelList;
    }
    /// 获取cellList
    static func sectionCellList(_ titles: [[String]], indexPath: IndexPath) -> [String] {
        let sectionList = titles[indexPath.section];
        let obj = sectionList.count > indexPath.row ? sectionList[indexPath.row] : sectionList.last!
        let cellList: [String] = obj.components(separatedBy: ",")
//        DDLog(cellList);
        return cellList;
    }
}


public extension UIScrollView {

    // default CGPointZero
    func contentOffsetChain(_ contentOffset: CGPoint) -> Self {
        self.contentOffset = contentOffset
        return self
    }

    // default CGSizeZero
    func contentSizeChain(_ contentSize: CGSize) -> Self {
        self.contentSize = contentSize
        return self
    }

    // default UIEdgeInsetsZero. add additional scroll area around content
    func contentInsetChain(_ contentInset: UIEdgeInsets) -> Self {
        self.contentInset = contentInset
        return self
    }

    @available(iOS 11.0, *)
    func contentInsetAdjustmentBehaviorChain(_ contentInsetAdjustmentBehavior: UIScrollView.ContentInsetAdjustmentBehavior) -> Self {
        self.contentInsetAdjustmentBehavior = contentInsetAdjustmentBehavior
        return self
    }

    @available(iOS 13.0, *)
    func automaticallyAdjustsScrollIndicatorInsetsChain(_ automaticallyAdjustsScrollIndicatorInsets: Bool) -> Self {
        self.automaticallyAdjustsScrollIndicatorInsets = automaticallyAdjustsScrollIndicatorInsets
        return self
    }

    // default nil. weak reference
    func delegateChain(_ delegate: UIScrollViewDelegate?) -> Self {
        self.delegate = delegate
        return self
    }

    // default NO. if YES, try to lock vertical or horizontal scrolling while dragging
    func isDirectionalLockEnabledChain(_ isDirectionalLockEnabled: Bool) -> Self {
        self.isDirectionalLockEnabled = isDirectionalLockEnabled
        return self
    }

    // default YES. if YES, bounces past edge of content and back again
    func bouncesChain(_ bounces: Bool) -> Self {
        self.bounces = bounces
        return self
    }

    // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag vertically
    func alwaysBounceVerticalChain(_ alwaysBounceVertical: Bool) -> Self {
        self.alwaysBounceVertical = alwaysBounceVertical
        return self
    }

    // default NO. if YES and bounces is YES, even if content is smaller than bounds, allow drag horizontally
    func alwaysBounceHorizontalChain(_ alwaysBounceHorizontal: Bool) -> Self {
        self.alwaysBounceHorizontal = alwaysBounceHorizontal
        return self
    }

    // default NO. if YES, stop on multiples of view bounds
    func isPagingEnabledChain(_ isPagingEnabled: Bool) -> Self {
        self.isPagingEnabled = isPagingEnabled
        return self
    }

    // default YES. turn off any dragging temporarily
    func isScrollEnabledChain(_ isScrollEnabled: Bool) -> Self {
        self.isScrollEnabled = isScrollEnabled
        return self
    }

    // default YES. show indicator while we are tracking. fades out after tracking
    func showsVerticalScrollIndicatorChain(_ showsVerticalScrollIndicator: Bool) -> Self {
        self.showsVerticalScrollIndicator = showsVerticalScrollIndicator
        return self
    }

    // default YES. show indicator while we are tracking. fades out after tracking
    func showsHorizontalScrollIndicatorChain(_ showsHorizontalScrollIndicator: Bool) -> Self {
        self.showsHorizontalScrollIndicator = showsHorizontalScrollIndicator
        return self
    }

    // default is UIScrollViewIndicatorStyleDefault
    func indicatorStyleChain(_ indicatorStyle: UIScrollView.IndicatorStyle) -> Self {
        self.indicatorStyle = indicatorStyle
        return self
    }

    // default is UIEdgeInsetsZero.
    @available(iOS 11.1, *)
    func verticalScrollIndicatorInsetsChain(_ verticalScrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.verticalScrollIndicatorInsets = verticalScrollIndicatorInsets
        return self
    }

    // default is UIEdgeInsetsZero.
    @available(iOS 11.1, *)
    func horizontalScrollIndicatorInsetsChain(_ horizontalScrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.horizontalScrollIndicatorInsets = horizontalScrollIndicatorInsets
        return self
    }

    // use the setter only, as a convenience for setting both verticalScrollIndicatorInsets and horizontalScrollIndicatorInsets to the same value. if those properties have been set to different values, the return value of this getter (deprecated) is undefined.
    func scrollIndicatorInsetsChain(_ scrollIndicatorInsets: UIEdgeInsets) -> Self {
        self.scrollIndicatorInsets = scrollIndicatorInsets
        return self
    }

    @available(iOS 3.0, *)
    func decelerationRateChain(_ decelerationRate: UIScrollView.DecelerationRate) -> Self {
        self.decelerationRate = decelerationRate
        return self
    }

    func indexDisplayModeChain(_ indexDisplayMode: UIScrollView.IndexDisplayMode) -> Self {
        self.indexDisplayMode = indexDisplayMode
        return self
    }

    // default is YES. if NO, we immediately call -touchesShouldBegin:withEvent:inContentView:. this has no effect on presses
    func delaysContentTouchesChain(_ delaysContentTouches: Bool) -> Self {
        self.delaysContentTouches = delaysContentTouches
        return self
    }

    // default is YES. if NO, then once we start tracking, we don't try to drag if the touch moves. this has no effect on presses
    func canCancelContentTouchesChain(_ canCancelContentTouches: Bool) -> Self {
        self.canCancelContentTouches = canCancelContentTouches
        return self
    }

    // default is 1.0
    func minimumZoomScaleChain(_ minimumZoomScale: CGFloat) -> Self {
        self.minimumZoomScale = minimumZoomScale
        return self
    }

    // default is 1.0. must be > minimum zoom scale to enable zooming
    func maximumZoomScaleChain(_ maximumZoomScale: CGFloat) -> Self {
        self.maximumZoomScale = maximumZoomScale
        return self
    }

    // default is 1.0
    @available(iOS 3.0, *)
    func zoomScaleChain(_ zoomScale: CGFloat) -> Self {
        self.zoomScale = zoomScale
        return self
    }

    // default is YES. if set, user can go past min/max zoom while gesturing and the zoom will animate to the min/max value at gesture end
    func bouncesZoomChain(_ bouncesZoom: Bool) -> Self {
        self.bouncesZoom = bouncesZoom
        return self
    }

    // default is YES.
    func scrollsToTopChain(_ scrollsToTop: Bool) -> Self {
        self.scrollsToTop = scrollsToTop
        return self
    }

    // default is UIScrollViewKeyboardDismissModeNone
    @available(iOS 7.0, *)
    func keyboardDismissModeChain(_ keyboardDismissMode: UIScrollView.KeyboardDismissMode) -> Self {
        self.keyboardDismissMode = keyboardDismissMode
        return self
    }

    @available(iOS 10.0, *)
    func refreshControlChain(_ refreshControl: UIRefreshControl?) -> Self {
        self.refreshControl = refreshControl
        return self
    }


}
