//
//	CGGeometry+Ext.Swift
//	MacTemplet
//
//	Created by Bin Shang on 2021/05/26 15:28
//	Copyright © 2021 Bin Shang. All rights reserved.
//


// MARK: - 计算有关的尺寸属性
/// 屏幕宽度
public let kScreenWidth: CGFloat           = NSScreen.main!.frame.size.width;
/// 屏幕高度
public let kScreenHeight: CGFloat          = NSScreen.main!.frame.size.height;

public let isiPhoneX: Bool                 = (kScreenHeight >= 812)
/// IphoneXtab 底部安全区高度
public let kIphoneXtabHeight: CGFloat      = isiPhoneX ? 34 : 0;
/// 键盘视图高度
public let kKeyboardHeight: CGFloat        = 226;
/// 顶部状态栏 20
public let kStatusBarHeight: CGFloat       = isiPhoneX ? 44 : 20;

