//
//  DatePickerCollectionCellViewModel.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/7/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

struct DatePickerCollectionCellViewModel {
    var selected: Box<Bool>
    var date: Box<Date>
    
    static let weekDays = ["日", "一", "二", "三", "四", "五", "六"]
    
    var numberOfMonth: String {
        get {
            return "\(date.value.getDayOfMonth())"
        }
    }
    
    var weekDay: String {
        get {
            return DatePickerCollectionCellViewModel.weekDays[date.value.getWeekDays()]
        }
    }
    
    init(date: Date, selected: Bool = false) {
        self.date = Box.init(date)
        self.selected = Box.init(selected)
    }
}
