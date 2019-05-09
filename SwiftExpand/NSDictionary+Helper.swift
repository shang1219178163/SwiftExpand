//
//  NSDictionary+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/4.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


extension Dictionary{
    
    public func jsonValue() -> String! {
        return (self as NSDictionary).jsonValue()
    }
}

extension NSDictionary{
    
//    @objc public func toJsonString() -> String! {
//        return jsonValue();
//    }
    
    
    
}
