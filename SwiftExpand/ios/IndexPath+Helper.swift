//
//  IndexPath+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/2.
//  Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit
    
public extension NSIndexPath{

    var previousRow: NSIndexPath {
        if row == 0 {
            return self
        }
        return NSIndexPath(row: self.row - 1, section: self.section)
    }
    
    var nextRow: NSIndexPath {
        return NSIndexPath(row: self.row + 1, section: self.section)
    }
    /// {section, row}
    func toString() -> String {
        return String(format: "{%d, %d}", section, row)
    }
}

    
public extension IndexPath{

    var previousRow: IndexPath {
        if row == 0 {
            return self
        }
        return IndexPath(row: self.row - 1, section: self.section)
    }
    
    var nextRow: IndexPath {
        return IndexPath(row: self.row + 1, section: self.section)
    }

    /// {section, row}
    func toString() -> String {
        return String(format: "{%d, %d}", section, row)
    }
    
}
