//
//  IndexPath+Helper.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2019/12/2.
//

import UIKit

    
public extension NSIndexPath{
    
    var string: String {
        return String(format: "{%d, %d}", section, row)
    }

}

    
public extension IndexPath{
    
    var string: String {
        return String(format: "{%d, %d}", section, row)
    }

}
