//
//  DatePicerViewModel.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//
import UIKit

public struct DatePickerViewModel {
    // MARK:- Property
    static let title = "选择日期"
    
    static let weekDays = ["日", "一", "二", "三", "四", "五", "六"]
    
    static let dayCellID = "dayCellID"
    
    static let headerCellID = "dayCellHeaderID"
    
    var startDate: Date = Date.init()
    
    let endDate: Date
    
    var chooseCount: Int = 1
    
    var selectedDate: [Date] = []
    
    var dismiss: Bool = false
    
    var numberOfMonths:Int {
        get {
            return 12
        }
    }
    
    var selectedComplete: (([Date])->Void)?
    
    //MARK:- Function
    public init(startDate: Date = Date.init(), endDate: Date, selectedDate: [Date] = [], chooseCount: Int = 1, selectedComplete:(([Date])->Void)? = nil){
        self.startDate = startDate
        self.endDate = endDate
        self.selectedDate = selectedDate
        self.chooseCount = chooseCount
    }
    
    /// Section header title data.
    public func getSectionHeaderData(index:Int) -> Date {
        let startDay = startDate.getStartDayOfTargetMonth(offset: index)
        return startDay
    }
    
    /// Cell count for section
    public func getCellCount(section:Int) -> Int {
        let startDay = getSectionHeaderData(index: section)
        let endDay = startDay.getEndDayOfCurrentMonth()
        
        let totalDay = startDay.getDayCountOfMonth()
        let startWeek = startDay.getWeekDays()
        let endWeek = endDay.getWeekDays()
        
        let leadingEmptyCount = startWeek
        let trailingEmptyCount = 6 - endWeek
        
        return totalDay + leadingEmptyCount + trailingEmptyCount
    }
    
    /// Cell data
    public func getCellData(indexPath:IndexPath) -> Date? {
        let totalCount = getCellCount(section: indexPath.section)
        let startDateOfMonth = getSectionHeaderData(index: indexPath.section)
        let endDateOfMonth = startDateOfMonth.getEndDayOfCurrentMonth()
        let startDayOfWeekend = startDateOfMonth.getWeekDays()
        let endDateOfWeekend = endDateOfMonth.getWeekDays()
        let row = indexPath.row
        if (row < startDayOfWeekend) { // Leading empty cell
            return nil
        } else if (row >= totalCount - (6 - endDateOfWeekend)) {
            return nil
        } else {
            let dayOfMonth = row - startDayOfWeekend
            return startDateOfMonth.nextDays(day: dayOfMonth)
        }
    }
    
    public func dateIsVaildate(date: Date) -> Bool {
        if (date.compare(startDate) == .orderedAscending) {
            return false
        }
        if (date.compare(endDate) == .orderedAscending) {
            return true
        }
        return false
    }
    
    public func selected(date: Date) -> Bool {
        for selDate in selectedDate {
            if (selDate == date) {
                return true
            }
        }
        return false
    }
    
    private mutating func removeSelected(date: Date) {
        var deleteItem:Date?
        for selDate in selectedDate {
            if (selDate == date) {
                deleteItem = selDate
            }
        }
        if let deleteItem = deleteItem {
            selectedDate.remove(at: selectedDate.index(of: deleteItem)!)
        }
    }
    
    private mutating func addSelected(date: Date) {
        if (selectedDate.count < chooseCount) { // add date , sort
            selectedDate.append(date)
            selectedDate.sort()
        } else { // clear and add
            selectedDate.removeAll()
            selectedDate.append(date)
        }
    }
    
    public mutating func selecteDate(_ date: Date) {
        // invaildate return
        if (!dateIsVaildate(date: date)) { return }
        if (selected(date: date)) { // alreay selected, remove
            removeSelected(date: date)
        } else {
            addSelected(date: date)
        } 
        completeChoosen()
    }
    
    /// date selected complete, dismiss.
    private mutating func completeChoosen() {
        if (self.selectedDate.count == chooseCount) {
            guard let complete = self.selectedComplete else { return }
            complete(self.selectedDate)
            dismiss = true
        }
    }
}
