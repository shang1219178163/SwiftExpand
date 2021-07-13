//
//  Optional+Helper.swift
//  TMP_Example
//
//  Created by Bin Shang on 2021/7/1.
//  Copyright © 2021 CocoaPods. All rights reserved.
//

import UIKit

/// do {} catch {}
public func should(_ do: () throws -> Void) -> Error? {
    do {
        try `do`()
        return nil
    } catch let error {
        return error
    }
}


public extension Optional {
    /// 可选值为空的时候返回 true
    var isNone: Bool {
        switch self {
        case .some( _ ):
            return false
        case .none:
            return true
        }
    }

    /// 返回可选值或 `else` 表达式返回的值
    /// 例如. optional.or(else: Selector)
    func or(else: @autoclosure () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }

    /// 返回可选值或者 `else` 闭包返回的值
    // 例如. optional.or(else: {
    /// ... do a lot of stuff
    /// })
    func or(else: () -> Wrapped) -> Wrapped {
        return self ?? `else`()
    }
        
    /// 可选值不为空且可选值满足 `predicate` 条件才返回，否则返回 `nil`
    func filter(_ predicate: (Wrapped) -> Bool) -> Wrapped? {
        guard let unwrapped = self,
            predicate(unwrapped) else { return nil }
        return unwrapped
    }
}


//public extension Array where Element == Optional<Any> {
//    
//    func filterNil() -> Array<Any> {
//        return self.compactMap { $0 as? Element.Type }
//    }
//}
