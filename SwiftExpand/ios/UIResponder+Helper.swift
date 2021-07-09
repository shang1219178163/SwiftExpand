//
//  UIResponder+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/5/20.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

@objc public extension UIResponder {

    func responderChain() -> String {
        guard let next = next else {
            return String(describing: self)
        }
        return String(describing: self) + " -> " + next.responderChain()
    }

}

public extension UIResponder {
//    func findNextResponder<T: UIResponder>(_ type: T.Type) -> T? {
//        for responder in sequence(first: self.next, next: { $0?.next }) {
//            DDLog(String(describing: responder))
//            if let value = responder as? T {
//                return value
//            }
//        }
//        return nil
//    }
    
    ///获取当前视图所在导航控制器
    func findNextResponder<T: UIResponder>(_ type: T.Type) -> T? {
        var n = next
        while n != nil {
            if let value = n as? T {
                return value
            }
            n = n?.next
        }
        return nil
    }
}
