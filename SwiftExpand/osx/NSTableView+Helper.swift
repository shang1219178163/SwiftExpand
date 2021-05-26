
//
//  NSTableView+Helper.swift
//  MacTemplet
//
//  Created by Bin Shang on 2019/11/22.
//  Copyright © 2019 Bin Shang. All rights reserved.
//



@objc public extension NSTableView {

    // MARK: -funtions
    static func create(_ rect: CGRect) -> Self {
        let view = self.init(frame: rect);
        view.autoresizingMask = [.width, .height];
//        view.columnAutoresizingStyle = .uniformColumnAutoresizingStyle

        view.gridStyleMask = .solidVerticalGridLineMask
//        view.focusRingType = .none //tableview获得焦点时的风格
        view.selectionHighlightStyle = .regular //行高亮的风格
        view.layer?.backgroundColor = NSColor.background.cgColor
        view.usesAlternatingRowBackgroundColors = false //背景颜色的交替，一行白色，一行灰色。设置后，原来设置的 backgroundColor 就无效了。
//        view.gridColor = NSColor.red
        
        view.appearance = NSAppearance(named: .aqua)
//        view.headerView = nil;

        view.rowHeight = 70;
        return view
    }
    
    /// 添加一组表头
    func addTableColumn(titles: [String]) {
      for e in titles {
          let column = NSTableColumn.create(identifier: e, title: e)
          addTableColumn(column)
      }
    }
    
}


public extension NSTableView {
    /// makeView
    final func makeView<T: NSTableCellView>(for cellType: T.Type, identifier: String = String(describing: T.self), style: NSTableView.RowSizeStyle = .default) -> T {
        let itemIdentifier = NSUserInterfaceItemIdentifier(rawValue: identifier);
        if let view = makeView(withIdentifier: itemIdentifier, owner: T.self) as? T {
            return view;
        }
        let cellView = T.init()
        cellView.identifier = itemIdentifier;
        cellView.wantsLayer = true;
        cellView.rowSizeStyle = style
        return cellView;
    }
}


@objc public extension NSTableCellView {

    /// [OC方法]复用 NSTableCellView
    static func makeView(tableView: NSTableView, identifier: String, owner: Any) -> Self {
        let itemIdentifier = NSUserInterfaceItemIdentifier(rawValue: identifier);
        if let view = tableView.makeView(withIdentifier: itemIdentifier, owner: owner) as? Self {
            return view;
        }
        let cellView = self.init()
        cellView.identifier = itemIdentifier;
        cellView.wantsLayer = true;
        return cellView
    }
    /// [OC简洁方法]复用 UITableViewCell
    static func makeView(tableView: NSTableView, owner: Any) -> Self {
        return makeView(tableView: tableView, identifier: String(describing: self), owner: owner)
    }
}



//设置每行容器视图
@objc public extension NSTableRowView {
    
    func selectionHighlightStyleChain(_ selectionHighlightStyle: NSTableView.SelectionHighlightStyle) -> Self {
        self.selectionHighlightStyle = selectionHighlightStyle
        return self
    }

    func isEmphasizedChain(_ isEmphasized: Bool) -> Self {
        self.isEmphasized = isEmphasized
        return self
    }

    func isGroupRowStyleChain(_ isGroupRowStyle: Bool) -> Self {
        self.isGroupRowStyle = isGroupRowStyle
        return self
    }

    func isSelectedChain(_ isSelected: Bool) -> Self {
        self.isSelected = isSelected
        return self
    }

    @available(macOS 10.10, *)
    func isPreviousRowSelectedChain(_ isPreviousRowSelected: Bool) -> Self {
        self.isPreviousRowSelected = isPreviousRowSelected
        return self
    }

    func isNextRowSelectedChain(_ isNextRowSelected: Bool) -> Self {
        self.isNextRowSelected = isNextRowSelected
        return self
    }

    func isFloatingChain(_ isFloating: Bool) -> Self {
        self.isFloating = isFloating
        return self
    }

    func isTargetForDropOperationChain(_ isTargetForDropOperation: Bool) -> Self {
        self.isTargetForDropOperation = isTargetForDropOperation
        return self
    }

    func draggingDestinationFeedbackStyleChain(_ draggingDestinationFeedbackStyle: NSTableView.DraggingDestinationFeedbackStyle) -> Self {
        self.draggingDestinationFeedbackStyle = draggingDestinationFeedbackStyle
        return self
    }

    func indentationForDropOperationChain(_ indentationForDropOperation: CGFloat) -> Self {
        self.indentationForDropOperation = indentationForDropOperation
        return self
    }

    func backgroundColorChain(_ backgroundColor: NSColor) -> Self {
        self.backgroundColor = backgroundColor
        return self
    }


}

//列
@objc public extension NSTableColumn {

    /// 复用NSTableCellView
    static func create(identifier: String, title: String) -> Self {
        let column = self.init(identifier: NSUserInterfaceItemIdentifier(identifier))
        column.title = title;
        column.minWidth = 40;
        column.maxWidth = CGFloat.greatestFiniteMagnitude;
        column.headerToolTip = column.title;
        column.headerCell.alignment = .center;
        
        column.resizingMask = .userResizingMask;
        
        let sort = NSSortDescriptor(key: column.title, ascending: false, selector: #selector(NSString.localizedCompare(_:)))
        column.sortDescriptorPrototype = sort
        return column;
    }

}
