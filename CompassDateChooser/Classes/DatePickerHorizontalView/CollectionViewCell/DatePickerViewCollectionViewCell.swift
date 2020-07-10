//
//  DatePickerViewCollectionViewCell.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/7/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class DatePickerViewCollectionViewCell: UICollectionViewCell {
    lazy var mainView: UIView = {
        let mainView = UIView.init()
        return mainView
    }()
    
    lazy var topLabel: UILabel = {
        let topLabel = UILabel.init()
        topLabel.font = UIFont.systemFont(ofSize: 12)
        return topLabel
    }()
    
    lazy var bottomLabel: UILabel = {
        let bottomLabel = UILabel.init()
        bottomLabel.font = UIFont.systemFont(ofSize: 12)
        return bottomLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    var viewModel: DatePickerCollectionCellViewModel? {
        didSet {
            bindViewModel()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI() {
        contentView.addSubview(mainView)
        mainView.snp.makeConstraints { (make) in
            make.centerY.equalTo(contentView.snp.centerY)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        
        mainView.addSubview(topLabel)
        mainView.addSubview(bottomLabel)
        
        topLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(mainView.snp.centerX)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        bottomLabel.snp.makeConstraints { (make) in
            make.top.equalTo(topLabel.snp.bottom).offset(10)
            make.centerX.equalTo(mainView.snp.centerX)
            make.bottom.equalTo(0)
        }
    }
    
    private func bindViewModel() {
        guard let viewModel = viewModel else { return }
        viewModel.date.bind { [weak self] _ in
            self?.topLabel.text = self?.viewModel?.weekDay
            self?.bottomLabel.text = self?.viewModel?.numberOfMonth
        }
        viewModel.selected.bind { [weak self] selected in
            if (selected) {
                self?.contentView.backgroundColor = UIColor.init(red: 113/255.0, green: 104/255.0, blue: 245/255.0, alpha: 1)
                self?.topLabel.textColor = .white
                self?.bottomLabel.textColor = .white
            } else {
                self?.contentView.backgroundColor = UIColor.white
                self?.topLabel.textColor = .black
                self?.bottomLabel.textColor = .black
            }
        }
    }
}
