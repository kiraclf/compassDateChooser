//
//  DatePickerViewController.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/6/16.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit
import SnapKit

public class DatePickerViewController: UIViewController {
    // MARK: - Property
    public var viewModel: DatePickerViewModel? {
        didSet {
            syncWithViewModel()
        }
    }
    
    lazy var headerStackView: UIStackView = {
        let headerStackView = UIStackView.init()
        headerStackView.axis = .horizontal
        headerStackView.alignment = .fill
        headerStackView.distribution = .fillEqually
        return headerStackView
    }() 
    
    lazy var mainCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let itemWidth = UIScreen.main.bounds.width / 7
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = CGSize.init(width:itemWidth, height:itemWidth)
        layout.headerReferenceSize = CGSize.init(width: UIScreen.main.bounds.width, height: 40)
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    // MARK:- Life Circle
    override public func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        jumpToSelected()
    }
    
    // MARK:- Public
    public static func showDatePicker(viewModel: DatePickerViewModel) {
        let datePicerVC = DatePickerViewController()
        let navigationVC = UINavigationController.init(rootViewController: datePicerVC)
        navigationVC.navigationBar.shadowImage = UIImage()
        navigationVC.navigationBar.setBackgroundImage(DatePicerColorConstant.mainColor.getPureColorImage(size: CGSize(width: 100, height: 100)), for: .default)
        datePicerVC.viewModel = viewModel
        
        UIApplication.shared.keyWindow?.rootViewController?.present(navigationVC, animated: true, completion: nil)
    }
    
    // MARK:- UI
    
    private func setupUI() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor: UIColor.white,
            .font: UIFont.systemFont(ofSize: 16)
        ]
        
        setupNavigation()
        setupHeaderStackView()
        setupCollectionView()
    }
    
    private func setupNavigation() {
        self.navigationItem.title = DatePickerViewModel.title
        self.navigationController?.navigationBar.titleTextAttributes = [
            NSAttributedStringKey.foregroundColor : UIColor.white,
            NSAttributedStringKey.font : UIFont.systemFont(ofSize: 18)
        ]
    }
    
    private func setupHeaderStackView() {
        let leftAndRightPadding = 0
        let stackHeight = 28.5
        
        // Stack View can't set backgroundColor, so this is a soltuion.
        // Use anonther backgroundView.
        let stackBackgroundView = UIView.init()
        stackBackgroundView.backgroundColor = DatePicerColorConstant.mainColor
        view.addSubview(stackBackgroundView)
        stackBackgroundView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.height.equalTo(stackHeight)
        }
        
        view.addSubview(headerStackView)
        
        headerStackView.snp.makeConstraints { (make) in
            make.left.equalTo(leftAndRightPadding)
            make.right.equalTo(-leftAndRightPadding)
            make.top.equalTo(0)
            make.height.equalTo(stackHeight)
        }
        
        for title in DatePickerViewModel.weekDays {
            let dayLabel = UILabel.init()
            dayLabel.textColor = .white
            dayLabel.font = UIFont.systemFont(ofSize: 16)
            dayLabel.textAlignment = .center
            dayLabel.text = title
            headerStackView.addArrangedSubview(dayLabel)
        }
    }
    
    private func setupCollectionView() {
        view.addSubview(mainCollectionView)
        mainCollectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(headerStackView.snp.bottom)
            make.bottom.equalTo(0)
        }
        
        mainCollectionView.dataSource = self
        mainCollectionView.delegate = self
        registerHeaderAndCell()
    }
    
    private func registerHeaderAndCell() {
        mainCollectionView.register(CompassDatePickerCell.self, forCellWithReuseIdentifier: DatePickerViewModel.dayCellID)
        mainCollectionView.register(CompassDatePickerHeaderView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: DatePickerViewModel.headerCellID)
    }
    
    private func jumpToSelected() {
        guard let viewModel = self.viewModel else { return }
        let selectedIndex = viewModel.firstSelectedIndex()
        guard let index = selectedIndex else { return }
        mainCollectionView.scrollToItem(at: index, at: .centeredVertically, animated: true)
    }
    // MARK:- Sync
    private func syncWithViewModel() {
        dismissVC()
        mainCollectionView.reloadData()
    }
    
    private func dismissVC() {
        guard let model = self.viewModel else { return }
        if (model.dismiss) {
            self.dismiss(animated: true, completion: nil)
        }
    }
    
}

extension DatePickerViewController: UICollectionViewDataSource {
    public func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel?.numberOfMonths ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.getCellCount(section: section) ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DatePickerViewModel.dayCellID, for: indexPath)
        if let dateCell = cell as? CompassDatePickerCell {
            let date = viewModel!.getCellData(indexPath: indexPath)
            if let date = date {
                let selected = viewModel!.selected(date: date)
                let vaildate = viewModel!.dateIsVaildate(date: date)
                let status = vaildate ? CompassDatePickerStatus.normal : .disable
                dateCell.viewModel = CompassDatePicerCellViewModel(status: status, selected: selected, date: date)
            } else {
                dateCell.viewModel = CompassDatePicerCellViewModel(status: .empty, date: date)
            }
        }
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind:UICollectionElementKindSectionHeader, withReuseIdentifier: DatePickerViewModel.headerCellID, for: indexPath)
        if let header = header as? CompassDatePickerHeaderView {
            let date = viewModel!.getSectionHeaderData(index: indexPath.section)
            let formatter = DateFormatter.init()
            formatter.dateFormat = "yyyy年MM月"
            let titleText = formatter.string(from: date)
            header.textLabel.text = titleText
        }
        return header
    }
}

extension DatePickerViewController: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let dateCell = cell as? CompassDatePickerCell else { return }
        let cellModel = dateCell.viewModel!
        if (cellModel.status == .disable || cellModel.status == .empty) { return }
        guard let cellDate = cellModel.date else { 
            return 
        }
        viewModel!.selecteDate(cellDate)
        collectionView.reloadData()
    }
}
