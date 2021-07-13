//
//  CGGeometry+Ext.swift
//  SwiftExpand
//
//  Created by Bin Shang on 2021/5/26.
//


// MARK: - 计算有关的尺寸属性
public let isiPhoneX: Bool                 = (kScreenHeight >= 812)
/// IphoneXtab 底部安全区高度
public let kIphoneXtabHeight: CGFloat      = isiPhoneX ? 34 : 0
/// 键盘视图高度
public let kKeyboardHeight: CGFloat        = 226
/// 顶部状态栏 20
public let kStatusBarHeight: CGFloat       = isiPhoneX ? 44 : 20
/// 导航栏高 44
public let kNaviBarHeight: CGFloat         = 44

public let kBarHeight: CGFloat             = 64.0
/// 底部tabBar高度 49
public let kTabBarHeight: CGFloat          = isiPhoneX ? (49.0 + 34.0) : 49


/// 自定义GGSizeMake
public func UIOffsetMake(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> UIOffset {
    return UIOffset(horizontal: horizontal, vertical: vertical)
}

public extension UIOffset{
    /// 便利方法
    init(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) {
        self.init(horizontal: horizontal, vertical: vertical)
    }
    
    /// 仿OC方法
    static func make(_ horizontal: CGFloat = 0, _ vertical: CGFloat = 0) -> Self{
        return Self(horizontal: horizontal, vertical: vertical)
    }

    ///Add two UIOffset
    static func + (lhs: UIOffset, rhs: UIOffset) -> UIOffset {
        return UIOffset(horizontal: lhs.horizontal + rhs.vertical, vertical: lhs.horizontal + rhs.vertical)
    }
}
