//
//  CompassCellViewModel.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

enum CompassDatePickerStatus {
    case empty
    case disable
    case normal
}

struct CompassDatePicerCellViewModel {
    var status: CompassDatePickerStatus
    var selected: Bool = false
    var today: Bool {
        get {
            guard let date = date else { return false }
            return date.isTheSameDay(date: Date.init())            
        }
    }
    var date: Date?
    static let chineseMonth = ["正月", "二月", "三月", "四月", "五月", "六月", "七月", "八月", "九月", "十月", "十一月", "十二月"]
    static let chineseDay = ["初一", "初二", "初三", "初四", "初五","初六", "初七", "初八", "初九", "初十", "十一", "十二", "十三", "十四", "十五", "十六", "十七", "十八", "十九", "二十", "廿一", "廿二", "廿三", "廿四", "廿五", "廿六", "廿七", "廿八", "廿九", "三十"]
    
    var numberDes: String? {
        get {
             let day = date?.getDayOfMonth()
            return day == nil ? "":"\(day!)"
        }
    }
    
    var stringDes: String? {
        get {
            guard let day = date else { return nil }
            let dayOfMonth = day.getChineseCalendarDay()
            if (dayOfMonth == 1) {
                let month = day.getChineseMonthDay()
                return CompassDatePicerCellViewModel.chineseDay[month-1]
            } else {
                return CompassDatePicerCellViewModel.chineseDay[dayOfMonth - 1]
            }
        }
    }
}
