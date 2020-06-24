
//
//  DateExtension.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public extension Date {
    
    /// Get the start date of the target month
    /// offset Parameter offset: month offset
    func getStartDayOfTargetMonth(offset: Int) -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        let nextMonthDate = calendar.date(byAdding: .month, value: offset, to: self)
        let day = nextMonthDate!.getDayOfMonth() - 1
        let nextMonthFirstDate = calendar.date(byAdding: .day, value: -day, to: nextMonthDate!)
        return nextMonthFirstDate!
    }
    
    /// Get current Month.
    func getMonth() -> Int {
        let calendar = Calendar.init(identifier: .gregorian)
        return calendar.component(.month, from: self)
    }
    
    func getEndDayOfCurrentMonth() -> Date {
        let startOfNextMonth = getStartDayOfTargetMonth(offset: 1)
        let calendar = Calendar.init(identifier: .gregorian)
        return calendar.date(byAdding: .day, value: -1, to: startOfNextMonth)!
    }
    
    /// Get the number of day in current month
    func getDayCountOfMonth() -> Int {
        let calendar = Calendar.init(identifier: .gregorian)
        let range = calendar.range(of: .day, in: .month, for: self)
        return range?.count ?? 0
    }
    
    /// Get the week days
    /// Sunday 0, Monday 1 ....
    func getWeekDays() -> Int {
        // WeekDays start from 1, Sunday 1, Monday 2
        let calendar = Calendar.init(identifier: .gregorian)
        return calendar.component(.weekday, from: self) - 1
    }
    
    /// Get day of month
    func getDayOfMonth() -> Int {
        let calendar = Calendar.init(identifier: .gregorian)
        return calendar.component(.day, from: self)
    }
    
    func nextDays(day:Int) -> Date {
        let calendar = Calendar.init(identifier: .gregorian)
        return calendar.date(byAdding: .day, value: day, to: self)!
    }
    
    /// Get Chinese Calendar day
    func getChineseCalendarDay() -> Int {
        let calendar = Calendar.init(identifier: .chinese)
        return calendar.component(.day, from: self)
    }
    
    /// Get Chinese Calendar month
    func getChineseMonthDay() -> Int {
        let calendar = Calendar.init(identifier: .chinese)
        return calendar.component(.month, from: self)
    }
    
    /// IS the same day
    func isTheSameDay(date: Date) -> Bool {
        let calendar = Calendar.init(identifier: .gregorian)
        // Year
        if (calendar.component(.year, from: self) != calendar.component(.year, from: date)) { return false }
        // Month
        if (calendar.component(.month, from: self) != calendar.component(.month, from: date)) { return false }
        // Day
        if (calendar.component(.day, from: self) != calendar.component(.day, from: date)) { return false }
        return true
    }
}
