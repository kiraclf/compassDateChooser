//
//  CompassDatePickerCell.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/17.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

class CompassDatePickerCell: UICollectionViewCell {
    //MARK:- Property
    var viewModel: CompassDatePicerCellViewModel? {
        didSet {
            syncWithViewModel()
        }
    }
    
    lazy var containerView: UIView = {
        let containerView = UIView.init()
        return containerView
    }()
    
    lazy var selectedView: UIView = {
        let selectedView = UIView.init()
        selectedView.layer.cornerRadius = 4
        return selectedView
    }()
    
    lazy var numberLabel: UILabel = {
        let numberLabel = UILabel.init()
        numberLabel.font = UIFont.systemFont(ofSize: 14)
        return numberLabel
    }()
    
    lazy var stringLabel: UILabel = {
        let stringLabel = UILabel.init()
        stringLabel.font = UIFont.systemFont(ofSize: 10)
        return stringLabel
    }()
    
    lazy var todayLabel: UILabel = {
        let todayLabel = UILabel.init()
        todayLabel.text = "今天"
        todayLabel.font = UIFont.systemFont(ofSize: 14)
        return todayLabel
    }()
    
    lazy var emptyView: UIView = {
        let emptyView = UIView()
        emptyView.backgroundColor = .white
        return emptyView
    }()
    
    //MARK:- init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- UI
    private func setupUI() {
        contentView.addSubview(selectedView)
        selectedView.snp.makeConstraints { (make) in
                   make.left.equalTo(8)
                   make.right.equalTo(-8)
                   make.top.equalTo(8)
                   make.bottom.equalTo(-8)
               }
        
        contentView.addSubview(containerView)
        containerView.snp.makeConstraints { (make) in
            make.centerX.equalTo(contentView.snp.centerX)
            make.centerY.equalTo(contentView.snp.centerY)
            make.left.equalTo(0)
            make.right.equalTo(0)
        }
        
        containerView.addSubview(numberLabel)
        containerView.addSubview(stringLabel)
        numberLabel.snp.makeConstraints { (make) in
            make.top.equalTo(0)
            make.centerX.equalTo(contentView.snp.centerX)
        }
        stringLabel.snp.makeConstraints { (make) in
            make.top.equalTo(numberLabel.snp.bottom).offset(2)
            make.centerX.equalTo(contentView.snp.centerX)
            make.bottom.equalTo(0)
        }
        
        contentView.addSubview(todayLabel)
        todayLabel.snp.makeConstraints { (make) in
            make.center.equalTo(contentView.snp.center)
        }
        
        contentView.addSubview(emptyView)
        emptyView.snp.makeConstraints { (make) in
            make.edges.equalTo(UIEdgeInsets.zero)
        }
    }
    
    
    private func componentHiddenSetter(containerViewHidden: Bool?, todayLabelHidden: Bool?, emtyViewHidden: Bool?) {
        containerView.isHidden = containerViewHidden ?? containerView.isHidden
        todayLabel.isHidden = todayLabelHidden ?? todayLabel.isHidden
        emptyView.isHidden = emtyViewHidden ?? emptyView.isHidden
    }
    
    //MARK:- Sync
    private func syncWithViewModel() {
        guard let viewModel = viewModel else { return }
        contentView.backgroundColor = .white
        selectedView.backgroundColor = .clear
        numberLabel.text = viewModel.numberDes
        stringLabel.text = viewModel.stringDes
        switch viewModel.status {
            case .empty:
                emptySync()
                break
            case .disable:
                disableSync()
                break
            case .normal:
                normalSync()
                break
        }
        if (viewModel.today) {
            todaySync()
        }
        if (viewModel.selected) {
            selectedSync()
        }
    }
    
    private func emptySync() {
        componentHiddenSetter(containerViewHidden: true, todayLabelHidden: true, emtyViewHidden: false)
    }
    
    private func disableSync() {
        componentHiddenSetter(containerViewHidden: false, todayLabelHidden: true, emtyViewHidden: true)
        numberLabel.textColor = DatePicerColorConstant.disableNumberColor
        stringLabel.textColor = DatePicerColorConstant.disableColor
        todayLabel.textColor = DatePicerColorConstant.disableColor
    }
    
    private func normalSync() {
        componentHiddenSetter(containerViewHidden: false, todayLabelHidden: true, emtyViewHidden: true)
        numberLabel.textColor = DatePicerColorConstant.enableColor
        stringLabel.textColor = DatePicerColorConstant.enableColor
        todayLabel.textColor = DatePicerColorConstant.enableColor
    }
    
    private func selectedSync() {
        numberLabel.textColor = DatePicerColorConstant.selectedColor
        stringLabel.textColor = DatePicerColorConstant.selectedColor
        todayLabel.textColor = DatePicerColorConstant.selectedColor
        selectedView.backgroundColor = DatePicerColorConstant.selectedBackgroundColor
    }
    
    private func todaySync() {
        componentHiddenSetter(containerViewHidden: true, todayLabelHidden: false, emtyViewHidden: true)
    }
}
