//
//  UISearchBar+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/10/9.
//

import UIKit

@objc public extension UISearchBar{
    private struct AssociateKeys {
        static var textField   = "UISearchBar" + "textField"
    }
    
//    var textField: UITextField? {
//        get {
//            if let obj = objc_getAssociatedObject(self, &AssociateKeys.textField) as? UITextField {
//                return obj
//            }
//            let obj = self.findSubview(type: UITextField.self, resursion: true) as? UITextField
//            if #available(iOS 11.0, *) {
//                obj?.textContentType = .name;
//            }
//            objc_setAssociatedObject(self, &AssociateKeys.textField, obj, .OBJC_ASSOCIATION_RETAIN_NONATOMIC);
//            return obj;
//        }
//    }
    
    var textField: UITextField? {
        if #available(iOS 13.0, *) {
            return searchTextField
        }
        let subViews = subviews.flatMap(\.subviews)
        guard let textField = (subViews.filter { $0 is UITextField }).first as? UITextField else {
            return nil
        }
        return textField
    }
    
    var cancellBtn: UIButton? {
        if showsCancelButton == false {
            return nil
        }
        if let btn = self.findSubview(type: (NSClassFromString("UINavigationButton") as! UIResponder.Type).self, resursion: true) as? UIButton {
            return btn;
        }
        return nil;
    }
    
    /// [源]UISearchBar创建
    static func create(_ rect: CGRect) -> UISearchBar {
        let searchBar = UISearchBar(frame: rect)
        
        //设置背景色
//        searchBar.backgroundColor = UIColor.black.withAlphaComponent(0.1);
//        searchBar.layer.cornerRadius = rect.height*0.5;
//        searchBar.layer.masksToBounds = true;
        //设置背景图是为了去掉上下黑线
        searchBar.backgroundImage = UIImage();
        //searchBar.backgroundImage = [UIImage imageNamed:@"sexBankgroundImage"];
        // 设置SearchBar的主题颜色
        //searchBar.barTintColor = [UIColor colorWithRed:111 green:212 blue:163 alpha:1];
        
        searchBar.barStyle = .default;
//        searchBar.keyboardType = .namePhonePad;
        //searchBar.searchBarStyle = UISearchBarStyleMinimal;
        //没有背影，透明样式
        // 修改cancel
//        searchBar.setValue("取消", forKey: "cancelButtonText")
//        searchBar.showsCancelButton = true;
        //    searchBar.showsSearchResultsButton = true;
        //5. 设置搜索Icon
        //    [searchBar setImage:[UIImage imageNamed:@"Search_Icon"] forSearchBarIcon:UISearchBarIconSearch state:UIControlStateNormal];
//        searchBar.setPositionAdjustment(UIOffset(horizontal: -8, vertical: 1), for: .search)
        // 删除按钮往右移一点
//        searchBar.setPositionAdjustment(UIOffset(horizontal: 8, vertical: 0), for: .clear)
        ///调整输入框位置
//        searchBar.searchTextPositionAdjustment = UIOffset(horizontal: 5, vertical: 0)
        searchBar.placeholder = "请输入";
        
        searchBar.textField?.tintColor = UIColor.gray;
        searchBar.textField?.font = UIFont.systemFont(ofSize: 13)
        searchBar.textField?.borderStyle = .none;

        return searchBar;
    }
    /// 创建默认搜索框
    static func createDefault() -> UISearchBar {
        let view = UISearchBar.create(CGRectMake(0, 0, kScreenWidth, 50))
        view.layer.cornerRadius = 0;
        view.showsCancelButton = false;
        view.backgroundColor = .white
        view.textField?.placeholder = "请输入名称搜索";
        view.textField?.backgroundColor = UIColor.background
        view.textField?.layer.cornerRadius = 5;
        view.textField?.layer.masksToBounds = true;
        return view;
    }
    
    func hiddenSearchBarBackground() {
        backgroundImage = UIImage()
        subviews[0].subviews.forEach { (subview) in
            if subview.isKind(of: NSClassFromString("UISearchBarBackground")!) {
                if #available(iOS 13.0, *) {
                    subview.isHidden = true
                } else {
                    subview.removeFromSuperview()
                }
                return
            }
        }
    }
    
    func clear() {
        text = ""
    }
}
