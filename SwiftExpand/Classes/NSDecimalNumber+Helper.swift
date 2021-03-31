//
//  NSDecimalNumber+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/6/28.
//  Copyright © 2020 BN. All rights reserved.
//

/*
 let result = NSDecimalNumber.calculate { () -> NSDecimalNumber in
     let a = NSDecimalNumber(decimal: 0.1562)
     let b = NSDecimalNumber(decimal: 0.1354554)
     let num = a.adding(b)
     return num
 }
 **/

import UIKit

@objc public extension NSDecimalNumber {
    
    override var stringValue: String {
        return "\(self.doubleValue)"
    }

    ///block 中加减乘除
    static func calculate(_ initial: NSDecimalNumber = NSDecimalNumber(decimal: 0.00),
                          scale: Int16 = 2,
                          block: @escaping ((NSDecimalNumber)->NSDecimalNumber)) -> NSDecimalNumber {
        /**
         该方法需要我们设置六个参数，
         第一个参数为舍入模式(roundingMode)，
         第二个参数为保留位数(scale，以小数点为中心，正数为小数位，负数为整数位)，
         第三个参数为数值精度异常捕获(raiseOnExactness)，
         第四个参数为数值上溢异常捕获(raiseOnOverflow)，
         第五个参数为数值下溢异常捕获(raiseOnUnderflow)，
         最后一个参数为数值除数为零异常捕获(raiseOnDivideByZero)：
         */
        let handler = NSDecimalNumberHandler(roundingMode: .bankers,
                                         scale: scale,
                                         raiseOnExactness: false,
                                         raiseOnOverflow: false,
                                         raiseOnUnderflow: false,
                                         raiseOnDivideByZero: true)
        let result: NSDecimalNumber = block(initial).rounding(accordingToBehavior: handler)
        return result
    }
}
