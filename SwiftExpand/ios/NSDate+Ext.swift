//
//	Date+Ext.Swift
//	MacTemplet
//
//	Created by Bin Shang on 2021/05/26 14:39
//	Copyright © 2021 Bin Shang. All rights reserved.
//


@objc public extension DateFormatter{

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

}
