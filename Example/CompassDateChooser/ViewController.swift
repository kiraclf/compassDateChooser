//
//  ViewController.swift
//  CompassDateChooser
//
//  Created by kiraclf on 06/15/2020.
//  Copyright (c) 2020 kiraclf. All rights reserved.
//

import UIKit
import CompassDateChooser

class ViewController: UIViewController {
    weak var selectorView: DatePickerHorizontalView?
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
        
        let selectorView = DatePickerHorizontalView.init(viewModel: DatePickerViewViewModel.init(date: Date.init(), totalDays: 14, dateSelected: nil), frame: CGRect.zero)
        view.addSubview(selectorView)
        selectorView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(view.snp.topMargin)
            make.height.equalTo(100)
        }
        self.selectorView = selectorView
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DatePickerViewController.showDatePicker(viewModel: DatePickerViewModel(
            endDate: Date.init().getStartDayOfTargetMonth(offset: 12), 
            selectedDate: [Date.init(timeIntervalSince1970: 1601485261)],
            selectedComplete: ({dateList in 
                for date in dateList {
                    print(date)
                }
            })
        ))
    }
}

