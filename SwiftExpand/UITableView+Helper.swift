//
//  UITableView+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/1/9.
//

import UIKit

@objc public extension UITableView{
    /// 刷新行数组
    func reloadRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .fade) {
        assert(section <= numberOfSections)
        let rowMax = rowList.value(forKeyPath: kArr_max_inter) as! Int
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
    func insertRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .fade) {
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
    func deleteRowList(_ rowList: NSArray, section: Int = 0, rowAnimation: UITableView.RowAnimation = .fade) {
        assert(section <= numberOfSections)
        let rowMax = rowList.value(forKeyPath: kArr_max_inter) as! Int
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
    /// 自定义标题显示
    func sectionView(viewForSection section: Int, title: String?, isHeader: Bool) -> UIView?{
       let sectionView = UIView()
       if title == nil {
           return sectionView
       }
       let label = UILabel(frame: CGRect(x: kX_GAP, y: 0, width: frame.width - kX_GAP*2, height: rowHeight));
       label.backgroundColor = isHeader ? .green : .yellow;
       
       label.text = title
       label.numberOfLines = isHeader ? 1 : 0
       label.textColor = isHeader ? UIColor.black : UIColor.red
       sectionView.addSubview(label)
       return sectionView
    }
}

public extension UITableView{
    
    /// 泛型复用cell - cellType: "类名.self" (备用默认值 T.self)
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
    
    /// 泛型复用cell - aClass: "类名()"
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
    
    /// 泛型复用HeaderFooterView - aClass: "类名()"
    final func dequeueReusableHeaderFooterView<T: UITableViewHeaderFooterView>(for aClass: T, identifier: String = String(describing: T.self)) -> T{
        return dequeueReusableHeaderFooterView(for: T.self, identifier: identifier)
    }
    
}
