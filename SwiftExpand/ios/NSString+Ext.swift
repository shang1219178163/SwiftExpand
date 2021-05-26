//
//  String+Ext.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//

import UIKit


public extension String{
    /// 复制到剪切板
    func copyToPasteboard(_ showTips: Bool) {
        UIPasteboard.general.string = self
        if showTips == true {
            UIAlertController(title: nil, message: "已复制'\(self)'到剪切板!", preferredStyle: .alert)
                .present(true, completion: nil)
        }
    }
}
