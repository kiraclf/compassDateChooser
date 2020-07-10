//
//  DatePickerViewModel.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/7/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Foundation

public struct DatePickerViewViewModel {
    // MARK: - Property
    var selectedDate: Date {
        didSet {
            if let selected = dateSelected {
                selected(selectedDate)
            }
            refreshViewModel()
        }
    }
    public var dateSelected:((Date)->Void)?
    /// Default to 14 days
    var totalDays = 14
    static let cellIDentifier = "PickerViewCellID"
    
    // MARK:- Init
    public init(date: Date, totalDays: Int = 14, dateSelected:((Date)->Void)? = nil) {
        selectedDate = date
        self.dateSelected = dateSelected
        self.totalDays = totalDays
    }
    
    // MARK:- Function
    private lazy var dateList:[Date] = {
        return createDateList()
    }()
    
    lazy var cellViewModelList: [DatePickerCollectionCellViewModel] = {
        return createCellViewModel()
    }()
    
    
    /// Based on current currentDate and totalDays, return a list of total Days.
    private func createDateList() -> [Date] {
        let beforeDay: Int = totalDays / 2
        let afterDay = totalDays - beforeDay - 1
        
        var beforeArr: [Date] = []
        for index in 1...beforeDay {
            let beforeDay = selectedDate.nextDays(day: -index)
            beforeArr.append(beforeDay)
        }
        beforeArr.reverse()
        
        var afterArr: [Date] = []
        for index in 1...afterDay {
            let afterDay = selectedDate.nextDays(day: index)
            afterArr.append(afterDay)
        }
        
        return beforeArr + [selectedDate] + afterArr
    }
    
    /// Based on dateList, return a list of collection ViewModel
    private  mutating func createCellViewModel() -> [DatePickerCollectionCellViewModel] {
        var tempArr: [DatePickerCollectionCellViewModel] = []
        refreshDateList()
        for date in dateList {
            let viewModel = DatePickerCollectionCellViewModel.init(date: date, selected: date == selectedDate)
            tempArr.append(viewModel)
        }
        return tempArr
    }
    
    public  mutating func refreshDateList() {
        let list: [Date] = createDateList()
        dateList = list
    }
    
    public  mutating func refreshViewModel() {
        let list = createCellViewModel()
        cellViewModelList = list
    }
    
    
    /// If failed return -1
    public  mutating func getSelectdIndex() -> IndexPath {
        for (index, value) in dateList.enumerated() {
            if (value == selectedDate) {
                return IndexPath.init(row: index, section: 0)
            }
        }
        return IndexPath.init(row: -1, section: 0)
    }
}
