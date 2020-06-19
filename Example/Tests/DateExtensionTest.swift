//
//  DateExtensionTest.swift
//  CompassDateChooser_Tests
//
//  Created by compass on 2020/6/18.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import Quick
import Nimble

@testable import CompassDateChooser

class DateExtensionTest: QuickSpec {
    let calendar = Calendar.init(identifier: .gregorian)
    var time:Date?
    private func createDate(year: Int = 2019, month: Int = 1, day: Int = 1) -> Date {
        let string = "\(year)-\(month)-\(day)"
        let format = DateFormatter.init()
        format.dateFormat = "yyyy-MM-dd"
        return format.date(from: string)!
    }
    
    override func spec() {
        beforeEach {
            //2020-6-18
            self.time = Date.init(timeIntervalSince1970: 1592462475)
        }
        it("获取月份中的第一天") { 
            let firstMonthDate = self.time!.getStartDayOfTargetMonth(offset: 0)
            let beforeMonthDate = self.time!.getStartDayOfTargetMonth(offset: -1)
            let day = self.calendar.component(.day, from: firstMonthDate)
            let month = self.calendar.component(.month, from: firstMonthDate)
            let dayBefore = self.calendar.component(.day, from: beforeMonthDate)
            let monthBefore = self.calendar.component(.month, from: beforeMonthDate)
            
            expect(day).to(equal(1))
            expect(month).to(equal(6))
            expect(dayBefore).to(equal(1))
            expect(monthBefore).to(equal(5))
            
            let date = self.createDate(year: 2019, month: 6, day: 12).getStartDayOfTargetMonth(offset: 0)
            let day1 = self.calendar.component(.day, from: date)
            let month1 = self.calendar.component(.month, from: date)
            expect(day1).to(equal(1))
            expect(month1).to(equal(6))
        }
        it("获取月份中的最后一天") { 
            let lastDay = self.time!.getEndDayOfCurrentMonth()
            let day = self.calendar.component(.day, from: lastDay)
            let month = self.calendar.component(.month, from: lastDay)
            expect(day).to(equal(30))
            expect(month).to(equal(6))
        }
        it("获取月份的天数") { 
            let days = self.time!.getDayCountOfMonth()
            expect(days).to(equal(30))
        }
        it("获取当前星期几") { 
            let day = self.time!.getWeekDays()
            expect(day).to(equal(4))
        }
        it("获取当前的日") { 
            let day = self.time!.getDayOfMonth()
            expect(day).to(equal(18))
        }
        it("获取指定的2天后") { 
            let day2 = self.time!.nextDays(day: 2)
            let day2Day = self.calendar.component(.day, from: day2)
             let month = self.calendar.component(.month, from: day2)
            expect(day2Day).to(equal(20))
            expect(month).to(equal(6))
        }
        it("获取指定的两天前") {
            let dayBefore2 = self.time!.nextDays(day: -2)
            let day2Before = self.calendar.component(.day, from: dayBefore2)
             let month = self.calendar.component(.month, from: dayBefore2)
            expect(day2Before).to(equal(16))
            expect(month).to(equal(6))
        }
        it("获取农历的月份") {
            let chineseMonth = self.time!.getChineseMonthDay()
            expect(chineseMonth).to(equal(4))
        }
        it("获取农历的日期") {
            let chineseDay = self.time!.getChineseCalendarDay()
            expect(chineseDay).to(equal(27))
        }
    }
}
