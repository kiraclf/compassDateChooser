//
//  DatePickerViewModelTest.swift
//  CompassDateChooser_Tests
//
//  Created by compass on 2020/6/19.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import Quick
import Nimble

@testable import CompassDateChooser

class DatePickerViewModelTest: QuickSpec {
    var viewModel: DatePickerViewModel!
    
    private func createDate(year: Int = 2019, month: Int = 1, day: Int = 1) -> Date {
        let string = "\(year)-\(month)-\(day)-08:00"
        let format = DateFormatter.init()
        format.dateFormat = "yyyy-MM-ddZZZZZ"
        return format.date(from: string)!
    }
    
    override func spec() {
        beforeEach {
            self.viewModel = DatePickerViewModel(
                startDate: self.createDate(year: 2019, month: 1, day: 1), endDate: self.createDate(year: 2019, month: 12, day: 1)
            )
        }
        afterEach {
            self.viewModel = nil
        }
        
        describe("测试collectionView相关") { 
            it("获取section头数据") { 
                let section = 5
                let targetDate = self.createDate(year: 2019, month: 6, day: 1)
                let returnDate = self.viewModel.getSectionHeaderData(index: section)
                expect(returnDate).to(equal(targetDate))
            }
            it("获取cellCount") {
                let section = 5
                let sectionDate = self.viewModel.getSectionHeaderData(index: 5)
                let calendar = Calendar.init(identifier: .gregorian)
                let weeks = calendar.range(of: .weekOfMonth, in: .month, for: sectionDate)
                let returnValue = self.viewModel.getCellCount(section: section)
                expect(returnValue).to(equal(weeks!.count * 7))
            }
            describe("获取cell对应的日期") { 
                it("空") {
                    // 前空
                    let indexpath1 = IndexPath(row: 0, section: 0)
                    // 后空
                    let indexpath2 = IndexPath(row: 34, section: 0)
                    let date1 = self.viewModel.getCellData(indexPath: indexpath1)
                    let date2 = self.viewModel.getCellData(indexPath: indexpath2)
                    expect(date1 == nil).to(equal(true))
                    expect(date2 == nil).to(equal(true))
                }
                it("无效日期-前") {
                    let before = self.createDate(year: 2008, month: 8, day: 8)
                    let vaildate = self.viewModel.dateIsVaildate(date: before)
                    expect(vaildate).to(equal(false))
                }
                it("无效日期-后") {
                    let after = self.createDate(year: 2023, month: 8, day: 8)
                    let vaildate = self.viewModel.dateIsVaildate(date: after)
                    expect(vaildate).to(equal(false))
                }
                it("有效日期") {
                    let middel = self.createDate(year: 2019, month: 8, day: 8)
                    let vaildate = self.viewModel.dateIsVaildate(date: middel)
                    expect(vaildate).to(equal(true))
                }
            }
        }
        it("日期是否有效") { 
            let before = self.createDate(year: 2005, month: 5, day: 5)
            let middle = self.createDate(year: 2019, month: 5, day: 5)
            let after = self.createDate(year: 2025, month: 5, day: 5)
            expect(self.viewModel.dateIsVaildate(date: before)).to(equal(false))
            expect(self.viewModel.dateIsVaildate(date: middle)).to(equal(true))
            expect(self.viewModel.dateIsVaildate(date: after)).to(equal(false))
        }
        it("日期是否被选择") { 
            let selectedArr = [self.createDate(year: 2019, month: 2, day: 2), self.createDate(year: 2019, month: 3, day: 3)]
            self.viewModel = DatePickerViewModel(
                startDate: self.createDate(year: 2019, month: 1, day: 1), endDate: self.createDate(year: 2019, month: 12, day: 1), selectedDate: selectedArr, selectedComplete: nil)
            let unSelected = self.createDate(year: 2012, month: 1, day: 1)
            let unSelected2 = self.createDate(year: 2019, month: 3, day: 2)
            let selected = self.createDate(year: 2019, month: 3, day: 3)
            expect(self.viewModel.selected(date: unSelected)).to(equal(false))
            expect(self.viewModel.selected(date: unSelected2)).to(equal(false))
            expect(self.viewModel.selected(date: selected)).to(equal(true))
        }
        describe("selected date") {
            beforeEach {
                self.viewModel = DatePickerViewModel(
                    startDate: self.createDate(year: 2019, month: 1, day: 1), endDate: self.createDate(year: 2019, month: 12, day: 1), selectedDate: [], chooseCount: 2)
            }
            it("无效->添加") {
                let selected = self.createDate(year: 2018, month: 2, day: 2)
                self.viewModel.selecteDate(selected)
                expect(self.viewModel.selectedDate.count).to(equal(0))
            }
            it("空->添加") { 
                let selected = self.createDate(year: 2019, month: 1, day: 1)
                assert(self.viewModel.selectedDate.count == 0)
                self.viewModel.selecteDate(selected)
                expect(self.viewModel.selectedDate.count).to(equal(1))
                expect(self.viewModel.selected(date: selected)).to(equal(true))
            }
            it("有一个->添加") { 
                let selected = self.createDate(year: 2019, month: 1, day: 1)
                let selected2 = self.createDate(year: 2019, month: 2, day: 2)
                assert(self.viewModel.selectedDate.count == 0)
                self.viewModel.selecteDate(selected)
                self.viewModel.selecteDate(selected2)
                expect(self.viewModel.selectedDate.count).to(equal(2))
                expect(self.viewModel.selected(date: selected2)).to(equal(true))
            }
            it("满->添加") {
                let selected = self.createDate(year: 2019, month: 1, day: 1)
                let selected2 = self.createDate(year: 2019, month: 2, day: 2)
                let selected3 = self.createDate(year: 2019, month: 3, day: 3)
                assert(self.viewModel.selectedDate.count == 0)
                self.viewModel.selecteDate(selected)
                self.viewModel.selecteDate(selected2)
                self.viewModel.selecteDate(selected3)
                expect(self.viewModel.selectedDate.count).to(equal(1))
                expect(self.viewModel.selected(date: selected2)).to(equal(false))
                expect(self.viewModel.selected(date: selected)).to(equal(false))
                expect(self.viewModel.selected(date: selected3)).to(equal(true))
            }
            it("重复添加") {
                let selected = self.createDate(year: 2019, month: 1, day: 1)
                let selected2 = self.createDate(year: 2019, month: 1, day: 1)
                assert(self.viewModel.selectedDate.count == 0)
                self.viewModel.selecteDate(selected)
                self.viewModel.selecteDate(selected2)
                expect(self.viewModel.selectedDate.count).to(equal(0))
                expect(self.viewModel.selected(date: selected2)).to(equal(false))
                expect(self.viewModel.selected(date: selected)).to(equal(false))
            }
        }
    }
}
