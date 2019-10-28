//
//  UserDefaults+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2019/10/28.
//  Copyright © 2019 BN. All rights reserved.
//

import Foundation

public extension UserDefaults{
    
    static func object(forKey defaultName: String) -> Any? {
        return self.standard.object(forKey: defaultName)
    }

    static func set(_ value: Any?, forKey defaultName: String) {
       self.standard.setValue(value, forKey: defaultName)
    }
    
    static func removeObject(forKey defaultName: String) {
        self.standard.removeObject(forKey: defaultName)
    }
    
    static func synchronize() {
        self.standard.synchronize();
    }
    /// 保存模型
    static func setArcObject(_ value: Any?, forkey defaultName: String) {
        guard let value = value else { return }
        let data = NSKeyedArchiver.archivedData(withRootObject: value)
        self.standard.setValue(data, forKey: defaultName)
    }
    /// 解包模型
    static func unarcObject(forkey defaultName: String) -> Any? {
        guard let value = self.standard.object(forKey: defaultName) as? Data else { return nil}
        return NSKeyedUnarchiver.unarchiveObject(with: value);
    }
    
}
