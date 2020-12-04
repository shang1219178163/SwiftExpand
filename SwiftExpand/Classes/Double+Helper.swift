//
//  Double+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit

public extension Int {

    var double: Double {
        return Double(self)
    }

    var float: Float {
        return Float(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Double {
    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Float.
    var float: Float {
        return Float(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}

public extension Float {

    var int: Int {
        return Int(self)
    }

    /// SwifterSwift: Double.
    var double: Double {
        return Double(self)
    }

    var cgFloat: CGFloat {
        return CGFloat(self)
    }
}
