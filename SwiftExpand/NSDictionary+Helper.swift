//
//  NSDictionary+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/9/4.
//  Copyright © 2018年 BN. All rights reserved.
//

import UIKit


public extension Dictionary{
    
    func jsonValue() -> String! {
        return (self as NSDictionary).jsonValue()
    }
}

public extension NSDictionary{
    
//    @objc func toJsonString() -> String! {
//        return jsonValue();
//    }
    
    
    
}
