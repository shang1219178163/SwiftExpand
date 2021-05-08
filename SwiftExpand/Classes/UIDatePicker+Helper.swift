//
//  UIDatePicker+Helper.swift
//  SwiftTemplet
//
//  Created by Bin Shang on 2020/12/4.
//  Copyright © 2020 BN. All rights reserved.
//

import UIKit


public extension UIDatePicker {

    var textColor: UIColor? {
        get {
            value(forKeyPath: "textColor") as? UIColor
        }
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
    }
    
    convenience init(rect: CGRect = .zero, isOn: Bool = true) {
        self.init(frame: rect)
        self.datePickerMode = .date;
        self.locale = Locale(identifier: "zh_CN");
        self.backgroundColor = UIColor.white;
        if #available(iOS 13.4, *) {
            self.preferredDatePickerStyle = .wheels
        }
    }
    
    // default is UIDatePickerModeDateAndTime
    func datePickerModeChain(_ datePickerMode: UIDatePicker.Mode) -> Self {
        self.datePickerMode = datePickerMode
        return self
    }

    // default is [NSLocale currentLocale]. setting nil returns to default
    func localeChain(_ locale: Locale) -> Self {
        self.locale = locale
        return self
    }

    // default is [NSCalendar currentCalendar]. setting nil returns to default
    func calendarChain(_ calendar: Calendar) -> Self {
        self.calendar = calendar
        return self
    }

    // default is nil. use current time zone or time zone from calendar
    func timeZoneChain(_ timeZone: TimeZone?) -> Self {
        self.timeZone = timeZone
        return self
    }

    // default is current date when picker created. Ignored in countdown timer mode. for that mode, picker starts at 0:00
    func dateChain(_ date: Date) -> Self {
        self.date = date
        return self
    }

    // specify min/max date range. default is nil. When min > max, the values are ignored. Ignored in countdown timer mode
    func minimumDateChain(_ minimumDate: Date?) -> Self {
        self.minimumDate = minimumDate
        return self
    }

    // default is nil
    func maximumDateChain(_ maximumDate: Date?) -> Self {
        self.maximumDate = maximumDate
        return self
    }

    // for UIDatePickerModeCountDownTimer, ignored otherwise. default is 0.0. limit is 23:59 (86,399 seconds). value being set is div 60 (drops remaining seconds).
    func countDownDurationChain(_ countDownDuration: TimeInterval) -> Self {
        self.countDownDuration = countDownDuration
        return self
    }

    // display minutes wheel with interval. interval must be evenly divided into 60. default is 1. min is 1, max is 30
    func minuteIntervalChain(_ minuteInterval: Int) -> Self {
        self.minuteInterval = minuteInterval
        return self
    }

    @available(iOS 13.4, *)
    func preferredDatePickerStyleChain(_ preferredDatePickerStyle: UIDatePickerStyle) -> Self {
        self.preferredDatePickerStyle = preferredDatePickerStyle
        return self
    }
}

