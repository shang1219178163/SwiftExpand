//
//  UserDefaults+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/10/28.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation

public extension UserDefaults{
    
    ///UserDefaults 保存模型
    static func setArcObject(_ value: Any?, forkey defaultName: String) {
        guard let value = value else { return }
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        self.standard.setValue(data, forKey: defaultName)
    }
    ///UserDefaults 解包模型
    static func arcObject(forkey defaultName: String) -> Any? {
        guard let value = self.standard.object(forKey: defaultName) as? Data else { return nil}
        return NSKeyedUnarchiver.unarchiveObject(with: value);
    }
    
}
