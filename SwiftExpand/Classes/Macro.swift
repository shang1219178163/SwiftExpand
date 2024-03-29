
//
//  Macro.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2018/8/15.
//  Copyright © 2018年 BN. All rights reserved.
//

#if os(macOS)
import AppKit
#else
import UIKit
#endif
import Foundation


// MARK: - 系统私有类
public let kUIButtonBarButton          = "UIButtonBarButton"
public let kUIModernBarButton          = "_UIModernBarButton"
public let kUITabBarButton             = "UITabBarButton"
public let kUITabBarSwappableImageView = "UITabBarSwappableImageView"

// MARK: - kSet
/// 0123456789
public let kSetNumber      = "0123456789"
/// 0123456789.
public let kSetFloat       = "0123456789."
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz
public let kSetAlpha       = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789
public let kSetAlphaNum    = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789"
/// ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789.
public let kSetAlphaFloat  = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789."

// MARK: - kArr
/// avg.floatValue
public let kArrAvgFloat       = "@avg.floatValue"
/// sum.intValue
public let kArrSumInter       = "@sum.intValue"
/// max.intValue
public let kArrMaxInter       = "@max.intValue"
/// min.intValue
public let kArrMinInter       = "@min.intValue"
/// sum.floatValue
public let kArrSumFloat       = "@sum.floatValue"
/// max.floatValue
public let kArrMaxFloat       = "@max.floatValue"
/// min.floatValue
public let kArrMinFloat       = "@min.floatValue"
/// uppercaseString
public let kArrUpperList      = "uppercaseString"
/// lowercaseString
public let kArrLowerList      = "lowercaseString"
/// distinctUnionOfArrays.self(数组内部去重)
public let kArrsUnionDistList = "@distinctUnionOfArrays.self"
/// unionOfArrays.self
public let kArrsUnionList     = "@unionOfArrays.self"

// MARK: -Tag

public let kTAG_LABEL: Int        = 100
public let kTAG_BTN: Int          = 200
public let kTAG_RightItem: Int    = 260
public let kTAG_BackItem: Int     = 261

public let kTAG_IMGVIEW: Int      = 300
public let kTAG_TEXTFIELD: Int    = 400
public let kTAG_TEXTVIEW: Int     = 500
public let kTAG_ALERT_VIEW: Int   = 600
public let kTAG_ACTION_SHEET: Int = 700
public let kTAG_PICKER_VIEW: Int  = 800
public let kTAG_PICKER_DATE: Int  = 900

public let kTAG_VIEW: Int         = 1000
public let kTAG_VIEW_Segment: Int = 1100
public let kTAG_VIEW_radio: Int   = 1200
public let kTAG_VIEW_Picture: Int = 1300


// MARK: - 计算有关的尺寸属性
/// 选择器默认高度 180
public let kPickerViewHeight: CGFloat      = 216

public let kX_GAP: CGFloat                 = 15.0
public let kY_GAP: CGFloat                 = 10.0
/// 视图布局最小间隙
public let kPadding: CGFloat               = 8.0
/// 右指箭头尺寸
public let kSizeArrow: CGSize              = CGSize(width: 25.0, height: 35.0)
///
public let kSizeSelected: CGSize           = CGSize(width: 35.0, height: 35.0)

/// 身份证宽高比
public let kRatioIDCard: CGFloat           = 0.63
/// 视图展示动画时间 0.3
public let kDurationShow: TimeInterval     = 0.3
/// 视图展示动画时间 0.5
public let kDurationDrop: TimeInterval     = 0.5
/// 视图展示动画时间 1.5
public let kDurationToast: TimeInterval    = 1.5
/// 视图展示动画时间 5.0
public let kDurationRotation: TimeInterval = 5.0
/// Cell默认高度
public let kH_CellHeight: CGFloat          = 60.0

public let kW_item: CGFloat                = 80.0
public let kW_progressView: CGFloat        = 130.0
/// UILabel 高度25
public let kH_LABEL: CGFloat               = 25
/// UILabel 高度30
public let kH_LABEL_TITLE: CGFloat         = 30.0
/// UILabel 高度20
public let kH_LABEL_SMALL: CGFloat         = 20.0
/// UITextField 高度30
public let kH_TEXTFIELD: CGFloat           = 30.0
/// UITableViewSeparatorView高0.33
public let kH_LINE_VIEW: CGFloat           = 0.33
public let kW_LINE_Vert: CGFloat           = 3.0
/// 视图layer线宽 0.5
public let kW_LayerBorder: CGFloat         = 0.5


// MARK: -font

public let kFontSize18: CGFloat = 18
public let kFontSize16: CGFloat = 16
public let kFontSize14: CGFloat = 14
public let kFontSize12: CGFloat = 12
public let kFontSize10: CGFloat = 10

// MARK: -文字

/// 网络请求中...
public let kNetWorkRequesting    = "网络请求中..."
/// 网络请求失败,请稍后再试
public let kNetWorkNodata        = "暂无数据"
/// 没有更多数据了
public let kNetWorkNoMoredata    = "没有更多数据了"
/// 网络请求失败,请稍后再试
public let kNetWorkFailed        = "网络请求失败,请稍后再试"
/// 参数错误,请稍后再试
public let kNetWorkFailedParams  = "参数错误,请稍后再试"
/// 定位中...
public let kLocationing          = "定位中..."
/// 位置信息更新成功!
public let kLocationSuccess      = "位置信息更新成功!"
/// 定位失败,请稍后再试
public let kLocationFailed       = "定位失败,请稍后再试"
/// 身份证识别失败,请稍后再试
public let kIDCardFailed         = "身份证识别失败,请稍后再试"
/// 身份证识别成功
public let kIDCardSuccess        = "身份证识别成功"

/// ···
public let kTitleMoreSymbol = "···"
/// 重置
public let kTitleDefault = "重置"
/// 知道了
public let kTitleKnow    = "知道了"
/// 确定
public let kTitleSure    = "确定"
/// 取消
public let kTitleCancell = "取消"
/// 是
public let kTitleYes     = "是"
/// 否
public let kTitleNo      = "否"
/// 删除
public let kTitleDelete  = "删除"
/// 彻底删除
public let kTitleDrop    = "彻底删除"
/// 呼叫
public let kTitleCall    = "呼叫"
/// 立即升级
public let kTitleUpdate  = "立即升级"
/// 收藏
public let kTitleCollect = "收藏"
/// 恢复
public let kTitleRecover = "恢复"
/// 查看
public let kTitleLook    = "点击查看"
/// 上传
public let kTitleUpload  = "上传"


/// --
public let kNilText      = "--"
/// ,
public let kSeparateStr  = ","
/// *
public let kAsterisk     = "*"
/// 空格(四分之一个字体)
public let kBlankQtr     = " "
/// 空格(半个字体)
public let kBlankHalf    = "  "
/// 空格(1个字体)
public let kBlankOne     = "    "
/// 空格(2个字体)
public let kBlankTwo     = "        "
/// 空格(3个字体)
public let kBlankThree   = "            "
/// 空格(4个字体)
public let kBlankFour    = "                "
/// 空格(5个字体)
public let kBlankFive    = "                    "


/// 一周七天
public let kWeekDes: String = "星期一,星期二,星期三,星期四,星期五,星期六,星期天"
/// 一年十二月
public let kMonthDes: String = "正月,二月,三月,四月,五月,六月,七月,八月,九月,十月,冬月,腊月"
/// 一月31天
public let kMontDayDes: String = "初一,初二,初三,初四,初五,初六,初七,初八,初九,初十,十一,十二,十三,十四,十五,十六,十七,十八,十九,二十,廿一,廿二,廿三,廿四,廿五,廿六,廿七,廿八,廿九,三十,三十一"

//MARK: - 其他

/// Debug模式日志打印
/// - Parameters:
///   - message: 内容
///   - file: 文件名
///   - function: 方法名
///   - line: 行号
public func DDLog(_ message: Any?..., file: String = #file, function: String = #function, line: Int = #line){
    #if DEBUG
    let params = message.compactMap{ "\($0 ?? "nil")" }.joined(separator: ", ")

    let fmt = DateFormatter.format("yyyy-MM-dd HH:mm:ss.SSSSSSZ")
    fmt.locale = Locale(identifier: "zh_CN")
    
    let dateStr = fmt.string(from: Date())
    print(dateStr, "\((file as NSString).lastPathComponent).\(function)[line \(line)]: \(params)")
    #endif
}
