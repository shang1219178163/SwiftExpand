//
//	Color+Ext.Swift
//	MacTemplet
//
//	Created by Bin Shang on 2021/05/26 14:30
//	Copyright © 2021 Bin Shang. All rights reserved.
//

import UIKit
import Foundation

@objc public extension UIColor{

    convenience init(light: UIColor, dark: UIColor) {
        if #available(iOS 13.0, tvOS 13.0, *) {
            self.init(dynamicProvider: { $0.userInterfaceStyle == .dark ? dark : light })
        } else {
            self.init(cgColor: light.cgColor)
        }
    }
}
