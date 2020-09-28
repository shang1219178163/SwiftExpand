//
//  UITableView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

@objc public extension UITableView{
    /// [源]UITableView创建
    static func create(_ rect: CGRect = .zero, style: UITableView.Style = .plain, rowHeight: CGFloat = 70.0) -> Self{
        let table = self.init(frame: rect, style: style);
        table.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        table.separatorStyle = .singleLine;
        table.separatorInset = .zero;
        table.rowHeight = rowHeight;
//        table.register(UITableViewCell.self, forCellReuseIdentifier: NSStringFromClass(UITableViewCell.self));
        table.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier);
        table.keyboardDismissMode = .onDrag
        table.backgroundColor = .groupTableViewBackground;
//        table.tableHeaderView = UIView();
//        table.tableFooterView = UIView();

        table.estimatedRowHeight = 0;
        table.estimatedSectionHeaderHeight = 0;
        table.estimatedSectionFooterHeight = 0;
        return table
    }
    
    func adJustedContentIOS11() {
        if #available(iOS 11.0, *) {
            self.contentInsetAdjustmentBehavior = .never
            self.estimatedRowHeight = 0;
            self.estimatedSectionHeaderHeight = 0;
            self.estimatedSectionFooterHeight = 0;
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
    
    /// [源]HeaderView,footerView
    final func createSectionView<T: UIView>(_ type: T.Type, height: CGFloat = 30, labelInset: UIEdgeInsets = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10), block: @escaping ((T)->Void)) -> UIView{
        let sectionView = UIView()
        sectionView.backgroundColor = .background

        let view = type.init(frame: CGRect(x: labelInset.left,
                                           y: labelInset.top,
                                           width: bounds.width - labelInset.left - labelInset.right,
                                           height: height - labelInset.top - labelInset.bottom));
        
        sectionView.addSubview(view)
        block(view)
        return sectionView
    }
    
    /// 按照时间值划分section(例如 var mdic:[String: [NSObject]] = [:] //全局变量)
    static func sectionByDatetime<T: NSObject>(_ timeKey: String, length: Int = 9, mdic: inout [String: [T]], list: [T]) {
        for e in list.enumerated() {
            if let time = e.element.value(forKey: timeKey) as? String {
                let key = time.count >= length ? (time as NSString).substring(to: length) : time;
                if mdic[key] == nil {
                    mdic[key] = [];
                }
                mdic[key]?.append(e.element as T)
            }
        }
//        DDLog(mdic.keys);
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
