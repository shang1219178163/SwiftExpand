//
//  Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2021/1/26.
//  Copyright © 2021 BN. All rights reserved.
//

import UIKit

import AVFoundation
@objc public extension AVAudioSession {

    ///音量开关
    func volume(_ soundoff: Bool) throws {
        if #available(iOS 10.0, *) {
            let category: AVAudioSession.Category = soundoff == true ? .record : .ambient;
            try setCategory(category, mode: .default)
            try setActive(true)
        }
    }
}
