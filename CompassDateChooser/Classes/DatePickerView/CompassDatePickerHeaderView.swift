//
//  CompassDatePickerHeaderView.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CompassDatePickerHeaderView: UICollectionReusableView {
    var textLabel:UILabel = {
        let textLabel = UILabel.init()
        textLabel.textColor = DatePicerColorConstant.enableColor
        textLabel.font = UIFont.systemFont(ofSize: 16)
        return textLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = DatePicerColorConstant.backgroundColor
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(textLabel)
        textLabel.snp.makeConstraints { (make) in
            make.center.equalTo(self.snp.center)
        }
    }
}
