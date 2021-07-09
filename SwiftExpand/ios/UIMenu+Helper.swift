//
//  UIMenu+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2021/7/7.
//  Copyright © 2021 BN. All rights reserved.
//


/// UIAction: "_state"
public let kActionState = "_state"

@available(iOS 14.0, *)
public extension UIMenu{

    /// Data mapping UIMenu structure
    static func map(_ title: String = "", data: [(String, [(String, UIImage?)])], handler: @escaping UIActionHandler) -> UIMenu {
        return UIMenu(title: title, children: data.map {
            UIMenu(title: $0.0, options: .displayInline, children: $0.1.map({
                    return UIAction(title: $0.0, image: $0.1, handler: handler)
                })
            )
        })
    }
}

@available(iOS 14.0, *)
public extension UIAction{
    
    /// state change(.on/.off), Support single selection/multiple selection.
    func handleStateChange(_ sender: UIButton, section: Int, isSingleChoose: Bool, handler: (()->Void)?) {
        guard let menu = sender.menu?.children[section] as? UIMenu else { return }
        if isSingleChoose == false {
            if self.state == .off {
                self.setValue(1, forKey: kActionState)
            } else if self.state == .on {
                self.setValue(0, forKey: kActionState)
            }
        } else {
            menu.children.forEach {
                $0.setValue($0 == self ? 1 : 0, forKey: kActionState)
            }
        }
        handler?()
//        DDLog(sender.checkRow(by: section))
////        DDLog(sender.checkActions(by: section))
//        let tmp = sender.checkActions(by: section)
//        DDLog(tmp?.map({ $0.title }))
    }
}


@available(iOS 14.0, *)
public extension UIButton {
        
    /// Actions (Support single selection/multiple selection)
    /// - Returns: row(state is on)
    func checkActions(by section: Int) -> [UIAction]?{
        guard let sectionMenu = menu?.children[section] as? UIMenu
              else { return nil }
        
        let firters = sectionMenu.children.filter {
            guard let action = $0 as? UIAction,
                  let value = action.value(forKey: kActionState) as? Int else { return false }
            return value == 1
        }
        return firters as? [UIAction]
    }
    
    /// row(Support single selection)
    /// - Returns: row(state is on)
    func checkRow(by section: Int) -> Int?{
        guard let sectionMenu = menu?.children[section] as? UIMenu
              else { return nil }
        
        let firters = sectionMenu.children.filter {
            guard let value = $0.value(forKey: kActionState) as? Int else { return false }
            return value == 1
        }

        guard let checkAction = firters.first as? UIAction else { return nil }
        return sectionMenu.children.firstIndex(of: checkAction)
    }
    
}
