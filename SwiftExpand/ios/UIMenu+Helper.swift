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

    /// map: data to UIMenu
    static func map(_ title: String = "", data: [(String, [(String, UIImage?)])], handler: @escaping UIActionHandler) -> UIMenu {
        return UIMenu(title: title, children: data.map { (title, tuples) in
            UIMenu(title: title, options: .displayInline, children:
                    tuples.map({ (title: String, image: UIImage?) in
                        return UIAction(title: title, image: image, handler: handler)
                    })
            )
        })
    }
}


@available(iOS 14.0, *)
public extension UIButton {
    
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
