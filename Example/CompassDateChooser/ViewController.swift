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

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .blue
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        DatePickerViewController.showDatePicker(viewModel: DatePickerViewModel(
            endDate: Date.init().getStartDayOfTargetMonth(offset: 12), selectedComplete: ({dateList in 
                for date in dateList {
                    print(date)
                }
            })))
    }
}

