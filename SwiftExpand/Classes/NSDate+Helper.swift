//
//  Date+Helper.swift
//  SwiftTemplet
//
//  Created by dev on 2018/12/11.
//  Copyright © 2018年 BN. All rights reserved.
//
/*
 G: 公元时代，例如AD公元
 yy: 年的后2位
 yyyy: 完整年
 MM: 月，显示为1-12
 MMM: 月，显示为英文月份简写,如 Jan
 MMMM: 月，显示为英文月份全称，如 Janualy
 dd: 日，2位数表示，如02
 d: 日，1-2位显示，如 2
 EEE: 简写星期几，如Sun
 EEEE: 全写星期几，如Sunday
 aa: 上下午，AM/PM
 H: 时，24小时制，0-23
 K：时，12小时制，0-11
 m: 分，1-2位
 mm: 分，2位
 s: 秒，1-2位
 ss: 秒，2位
 S: 毫秒
 */

import UIKit

/// 60s
public let kDateMinute: Double = 60 ;
/// 3600s
public let kDateHour: Double   = 3600 ;
/// 86400
public let kDateDay: Double    = 86400 ;
/// 604800
public let kDateWeek: Double   = 604800 ;
/// 31556926
public let kDateYear: Double   = 31556926 ;


/// yyyy-MM-dd HH:mm:ss(默认)
public let kDateFormat            = "yyyy-MM-dd HH:mm:ss";
/// yyyy-MM
public let kDateFormatMonth       = "yyyy-MM";
/// yyyy-MM-dd
public let kDateFormatDay         = "yyyy-MM-dd";
/// yyyy-MM-dd HH
public let kDateFormatHour        = "yyyy-MM-dd HH";
/// yyyy-MM-dd HH:mm
public let kDateFormatMinute      = "yyyy-MM-dd HH:mm";
/// yyyy-MM-dd HH:mm:ss eee
public let kDateFormatMillisecond = "yyyy-MM-dd HH:mm:ss eee";
/// yyyy-MM-dd 00:00:00
public let kDateFormatBegin       = "yyyy-MM-dd 00:00:00";
/// yyyy-MM-dd 23:59:59
public let kDateFormatEnd         = "yyyy-MM-dd 23:59:59";

/// yyyy-MM-dd HH:mm:00
public let kTimeFormatBegin       = "yyyy-MM-dd HH:mm:00";
/// yyyy-MM-dd HH:mm:59
public let kTimeFormatEnd         = "yyyy-MM-dd HH:mm:59";

/// yyyy年M月
public let kDateFormatMonth_CH    = "yyyy年MM月";
/// yyyy年MM月dd日
public let kDateFormatDay_CH      = "yyyy年MM月dd日";
/// yyyyMMdd
public let kDateFormatTwo         = "yyyyMMdd";


@objc public extension DateFormatter{
    /// 获取DateFormatter(默认格式)
    static func format(_ formatStr: String = kDateFormat) -> DateFormatter {
        let dic = Thread.current.threadDictionary;
        if let formatter = dic.object(forKey: formatStr) as? DateFormatter {
            return formatter
        }
        
        let fmt = DateFormatter();
        fmt.dateFormat = formatStr;
        fmt.locale = .current;
        fmt.locale = Locale(identifier: "zh_CN");
        fmt.timeZone = formatStr.contains("GMT") ? TimeZone(identifier: "GMT") : TimeZone.current;
        dic.setObject(fmt, forKey: formatStr as NSCopying)
        return fmt;
    }
    
    /// Date -> String
    static func stringFromDate(_ date: Date, fmt: String = kDateFormat) -> String {
        let formatter = DateFormatter.format(fmt);
        return formatter.string(from: date);
    }
    
    /// String -> Date
    static func dateFromString(_ dateStr: String, fmt: String = kDateFormat) -> Date? {
        let formatter = DateFormatter.format(fmt);
        let tmp = dateStr.count <= fmt.count ? dateStr : (dateStr as NSString).substring(to: fmt.count)
        let result = formatter.date(from: tmp);
        return result
    }
    
    /// 时间戳字符串 -> 日期字符串
    static func stringFromInterval(_ interval: String, fmt: String = kDateFormat) -> String {
        let date = Date(timeIntervalSince1970: interval.doubleValue)
        return DateFormatter.stringFromDate(date, fmt: fmt);
    }

    /// 日期字符串 -> 时间戳字符串
    static func intervalFromDateStr(_ dateStr: String, fmt: String = kDateFormat) -> String {
        guard let date = DateFormatter.dateFromString(dateStr, fmt: fmt) else {
            return "0" }
        return "\(date.timeIntervalSince1970)";
    }
    
    ///根据 UIDatePicker.Mode 获取时间字符串简
    static func dateFromPickerMode(_ mode: UIDatePicker.Mode = .dateAndTime, date: Date) -> String {
        var result = DateFormatter.stringFromDate(date)
        switch mode {
        case .time, .countDownTimer:
            result = (result as NSString).substring(with: NSMakeRange(11, 5))

            break;
        case .date:
            result = (result as NSString).substring(with: NSMakeRange(0, 10))
            break;

        default:
            result = (result as NSString).substring(with: NSMakeRange(0, 16))
            break
        }
        return result
    }
        
    /// 获取起止时间区间数组,默认往前31天
    static func queryDate(_ day: Int = -30, fmtStart: String = kDateFormatBegin, fmtEnd: String = kDateFormatEnd) -> [String] {
        let endTime = DateFormatter.stringFromDate(Date(), fmt: fmtEnd)
        let date = Date().adding(day)
        let startTime = DateFormatter.stringFromDate(date, fmt: fmtStart)
        return [startTime, endTime];
    }
    
    ///获取指定时间内的所有天数日期
    static func betweenDateDays(_ startTime: String, endTime: String, fmt: String = kDateFormatDay, block: ((DateComponents, Date) -> Void)? = nil) -> [String] {
        let calendar = Calendar(identifier: .gregorian)
        guard var startDate = DateFormatter.dateFromString(startTime, fmt: fmt),
              let endDate = DateFormatter.dateFromString(endTime, fmt: fmt)
              else {
            return []}

        var days: [String] = []
        var comps: DateComponents?
        
        var result = startDate.compare(endDate)
        while result != .orderedDescending {
            comps = calendar.dateComponents([.year, .month, .day, .weekday], from: startDate)
            
            let time = DateFormatter.stringFromDate(startDate, fmt: fmt)
            days.append(time)

            if var comps = comps {
                block?(comps, startDate)
                comps.day! += 1
                startDate = calendar.date(from: comps)!
                result = startDate.compare(endDate)
            }
        }
        return days
    }
    ///获取指定时间内的星期值集合
    static func betweenWeekDays(_ startTime: String, endTime: String) -> [Int] {
        var weekdays = Set<Int>()
        let list = DateFormatter.betweenDateDays(startTime, endTime: endTime, fmt: kDateFormatDay) { (components, date) in
//            DDLog(date, components.weekday!)
            weekdays.insert(components.weekday!)
        }
        if list.count < 7 {
            let array = Array(weekdays).sorted()
//            DDLog("weekdays:", weekdays, array)
            return array
        }
        return [1, 2, 3, 4, 5, 6, 7]
    }
    
    ///获取指定时间内的索引值集合(["星期一", "星期二", "星期三", "星期四", "星期五", "星期六", "星期日"])
    static func betweenWeekDayIdxs(_ startTime: String, endTime: String) -> [Int] {
        let list = DateFormatter.betweenWeekDays(startTime, endTime: endTime)
        var idxList = [Int]()
        if list.contains(1) {
            idxList = list.filter({ $0 >= 2 }).map({ $0 - 2 })
            idxList.append(6)
        } else {
            idxList = list.map({ $0 - 2 })
        }
        return idxList
    }

    
    ///时间区间
    static func durationFrom(_ btime: String?, etime: String?) -> TimeInterval {
        guard let btime = btime,
              let etime = etime
              else { return 0 }
        
        let isEmpty = btime.isEmpty == false || etime.isEmpty == false || btime.count < 10 || etime.count < 10
        let isInitTime = btime.hasPrefix("1970") || etime.hasPrefix("1970")
        if isEmpty || isInitTime {
            return 0
        }
        
        guard let bDate = DateFormatter.dateFromString(btime, fmt: kDateFormat),
              let eDate = DateFormatter.dateFromString(etime, fmt: kDateFormat)
              else { return 0 }
        return bDate.timeIntervalSince1970 - eDate.timeIntervalSince1970
    }
}

@objc public extension NSDate{
    
    /// 本地时间(东八区时间)
    static var dateLocale: NSDate {
//        return NSDate().addingTimeInterval(8 * 60 * 60)
        let interval = NSTimeZone.system.secondsFromGMT(for: Date())
        return NSDate().addingTimeInterval(TimeInterval(interval))
    }
    
    /// 年
    var year: Int {
        return (self as Date).year
    }
    /// 月
    var month: Int {
        return (self as Date).month
    }
    /// 日
    var day: Int {
       return (self as Date).day
    }
    /// 时
    var hour: Int {
       return (self as Date).hour
    }
    /// 分
    var minute: Int {
       return (self as Date).minute
    }
    /// 秒
    var second: Int {
       return (self as Date).second;
    }
    
    /// 时间戳
    var timeStamp: Int {
        return (self as Date).timeStamp;
    }
    
    var timeStamp13: Int {
        return (self as Date).timeStamp13
    }
    /// 当月天数
    var countOfDaysInMonth: Int {
        return (self as Date).countOfDaysInMonth
    }
    /// 当月第一天是星期几
    var firstWeekDay: Int {
        return (self as Date).firstWeekDay
    }
    
    ///是否是今年
    var isThisYear: Bool {
        return (self as Date).isThisYear
    }
    
    ///是否是这个月
    var isThisMonth: Bool {
        return (self as Date).isThisMonth

    }
    ///是否是今天
    var isToday: Bool {
        return (self as Date).isToday
    }
    
    ///****-**-** 00:00:00
    var dayBegin: String {
        return (self as Date).dayBegin
    }
    
    ///****-**-** 23:59:59
    var dayEnd: String{
        return (self as Date).dayEnd
    }
    
    /// 现在时间上添加天:小时:分:秒(负数:之前时间, 正数: 将来时间)
    func adding(_ days: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> NSDate{
        return (self as Date).adding(days, hour: hour, minute: minute, second: second) as NSDate
    }
    ///*天*小时*分*秒
    func betweenInfo(_ aDate: Date) -> String {
        return (self as Date).betweenInfo(aDate)
    }
    
    //MARK: - 获取日期各种值
    /// 获取默认DateComponents[年月日]
    static func dateComponents(_ aDate: Date) -> DateComponents {
        return Calendar.dateComponents(aDate);
    }

    /// 两个时间差的NSDateComponents
    static func dateFrom(from start: Date, to end: Date) -> DateComponents {
        return Calendar.dateComponents(from: start, to: end)
    }

    /// 一周的第几天
    static func weekDay(_ comp: DateComponents) ->Int{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        return Date.weekDay(comp);
    }
}

public extension NSDate{
    /// DateComponents(年月日时分秒)
    static func components(_ year: Int?, month: Int?, day: Int?, hour: Int?, minute: Int?, second: Int?) ->DateComponents{
        return DateComponents(calendar: Calendar.shared, timeZone: nil, era: nil, year: year, month: month, day: day, hour: hour, minute: minute, second: second, nanosecond: nil, weekday: nil, weekdayOrdinal: nil, quarter: nil, weekOfMonth: nil, weekOfYear: nil, yearForWeekOfYear: nil)
    }
}

public extension Date{
    /// 本地时间(东八区时间)
    static var dateLocale: Date {
//        return Date().addingTimeInterval(8 * 60 * 60)
        let interval = NSTimeZone.system.secondsFromGMT(for: Date())
        return Date().addingTimeInterval(TimeInterval(interval))
    }
    /// 年
    var year: Int {
        return Calendar.dateComponents(self).year!
    }
    /// 月
    var month: Int {
        return Calendar.dateComponents(self).month!
    }

    /// 日
    var day: Int {
        return Calendar.dateComponents(self).day!;
    }
    /// 时
    var hour: Int {
        return Calendar.dateComponents(self).hour!;
    }
    /// 分
    var minute: Int {
        return Calendar.dateComponents(self).minute!;
    }
    /// 秒
    var second: Int {
        return Calendar.dateComponents(self).second!;
    }
    
    /// 时间戳
    var timeStamp: Int {
        return Int(self.timeIntervalSince1970)
    }
    
    /// 时间戳
    var timeStamp13: Int {
        return Int(self.timeIntervalSince1970 * 1000)
    }
    
    /// 当月天数
    var countOfDaysInMonth: Int {
        let calendar = Calendar.shared
        let range = (calendar as NSCalendar).range(of: .day, in: .month, for: self)
        return range.length
    }
    /// 当月第一天是星期几
    var firstWeekDay: Int {
        return Calendar.shared.firstWeekday

//        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
//        var comp: DateComponents = Calendar.dateComponents(self)
//        comp.day = 1
//
//        let firstWeekDay = NSDate.weekDay(comp)
//        return firstWeekDay
    }
    
    var minimumDaysInFirstWeek: Int {
        return Calendar.shared.minimumDaysInFirstWeek
    }
    
    ///是否是今年
    var isThisYear: Bool {
        let comp = Calendar.dateComponents(self)
        let comp1 = Calendar.dateComponents(Date())
        
        let isSame = (comp1.year == comp.year)
        return isSame
    }
    
    ///是否是这个月
    var isThisMonth: Bool {
        let comp = Calendar.dateComponents(self)
        let comp1 = Calendar.dateComponents(Date())
        
        let isSame = (comp1.year == comp.year && comp1.month == comp.month);
        return isSame
    }
    ///是否是今天
    var isToday: Bool {
        return Calendar.shared.isDateInToday(self)
//        let comp = Calendar.dateComponents(self)
//        let comp1 = Calendar.dateComponents(Date())
//
//        let isSame = (comp1.year == comp.year && comp1.month == comp.month && comp1.day == comp.day);
//        return isSame
    }

    ///****-**-** 00:00:00
    var dayBegin: String{
        let result = DateFormatter.stringFromDate(self, fmt: kDateFormatBegin)
        return result;
    }
    
    ///****-**-** 23:59:59
    var dayEnd: String{
        let result = DateFormatter.stringFromDate(self, fmt: kDateFormatEnd)
        return result;
    }
    
    /// 现在时间上添加天:小时:分:秒(负数:之前时间, 正数: 将来时间) -> NSDate
    func adding(_ days: Int, hour: Int = 0, minute: Int = 0, second: Int = 0) -> Date{
        let date = addingTimeInterval(TimeInterval(days*24*3600 + hour*3600 + minute*60 + second))
        return date;
    }
    
    /// 现在时间上添加天:小时:分:秒(负数:之前时间, 正数: 将来时间) -> String
    func addingDaysDes(_ days: Int, fmt: String = kDateFormat) -> String{
        let newDate = adding(days);
        return DateFormatter.stringFromDate(newDate as Date, fmt: fmt);
    }
    
    ///*天*小时*分*秒
    func betweenInfo(_ aDate: Date) -> String {
        var value = Int(abs(aDate.timeIntervalSince1970 - self.timeIntervalSince1970))

        var year = 0
        var day = 0
        var hour = 0
        var minute = 0
        var second = 0

        var result = ""
        if value >= 365*24*3600 {
            year = value/(365*24*3600)
            result += "\(year)年"
            value -= year*(365*24*3600)
        }
        
        if value >= 24*3600 {
            day = value/(24*3600)
            result += "\(day)天"
            value -= day*(24*3600)
        }
        
        if value > 3600 {
            hour = value/3600
            result += "\(hour)小时"
            value -= hour*3600
        }
        
        if value > 60 {
            minute = value/60
            result += "\(minute)分"
            value -= minute*60
        }
        
        if value > 0 {
            second = value
            result += "\(second)秒"
        }
        
//        DDLog(day, hour, minute, second)
        return result
    }
    
    //MARK: - 获取日期各种值
            
    /// 一周的第几天
    static func weekDay(_ comp: DateComponents) ->Int{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let newDate = Calendar.shared.date(from: comp)
        let weekDay = Calendar.shared.component(.weekday, from: newDate!)
        return weekDay
    }
    
    //MARK: 一周的第几天
    func weekDay(_ addDays: Int = 0) ->Int{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        var comp: DateComponents = Calendar.dateComponents(self)
        comp.day! += addDays

        let newDate = Calendar.shared.date(from: comp)
        let weekDay = Calendar.shared.component(.weekday, from: newDate!)
        return weekDay
    }
    
    //MARK: 周几
    func weekDayDes(_ addDays: Int = 0) ->String{
        //1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
        let dic: [String: String] = ["1": "周日",
                                     "2": "星期一",
                                     "3": "星期二",
                                     "4": "星期三",
                                     "5": "星期四",
                                     "6": "星期五",
                                     "7": "星期六"]
        
        let weekDay = "\(self.weekDay(addDays))"
        let result = dic.keys.contains(weekDay) ? dic[weekDay] : "-"
        return result!
    }
}


public extension Calendar{
    
    static let shared = Calendar(identifier: .gregorian)
    
    /// 获取默认DateComponents[年月日时分秒]
    static func dateComponents(_ aDate: Date) -> DateComponents {
        let com = Calendar.shared.dateComponents([.year, .month, .day, .hour, .minute, .second], from: aDate)
        return com
    }
    
    /// 两个时间差的NSDateComponents
    static func dateComponents(from start: Date, to end: Date) -> DateComponents {
        let com = Calendar.shared.dateComponents([.year, .month, .day, .hour, .minute, .second], from: start, to: end)
        return com
    }
}
