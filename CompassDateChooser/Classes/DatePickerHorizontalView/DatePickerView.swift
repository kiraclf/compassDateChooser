//
//  DatePickerView.swift
//  CompassDateChooser_Example
//
//  Created by compass on 2020/7/9.
//  Copyright © 2020 CocoaPods. All rights reserved.
//

import UIKit

//TODO: Add time scroll animation.
public class DatePickerHorizontalView: UIView {
    //MARK:- Property UI
    lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize.init(width: 40, height: 50)
        layout.minimumInteritemSpacing = 10
        let collectionView = UICollectionView.init(frame: CGRect.zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.register(DatePickerViewCollectionViewCell.self, forCellWithReuseIdentifier: DatePickerViewViewModel.cellIDentifier)
        collectionView.contentInset = UIEdgeInsets.init(top: 16, left: 0, bottom: 16, right: 0)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.bounces = false
        return collectionView
    }()
    // MARK:- Property
    public var viewModel: DatePickerViewViewModel?
    
    
    // MARK:- LifeCircle
    public convenience init(viewModel: DatePickerViewViewModel?, frame: CGRect) {
        self.init(frame: frame)
        self.viewModel = viewModel
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK:- UI
    private func setupUI() {
        self.addSubview(collectionView)
        collectionView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.top.equalTo(0)
            make.bottom.equalTo(0)
        }
    }
    
    //MARK:- Public
    private func moveToSelected() {
        collectionView.scrollToItem(at: viewModel?.getSelectdIndex() ?? IndexPath.init(row: 0, section: 0), at: .centeredHorizontally, animated: true)
    }
}

extension DatePickerHorizontalView: UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.cellViewModelList.count ?? 0
    }
    
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: DatePickerViewViewModel.cellIDentifier, for: indexPath)
        guard let dateCell = cell as? DatePickerViewCollectionViewCell else { return cell }
        dateCell.viewModel = viewModel?.cellViewModelList[indexPath.row]
        return dateCell
    }
    
    
}

extension DatePickerHorizontalView: UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard var viewModel = viewModel else { return }
        let date = viewModel.cellViewModelList[indexPath.row]
        viewModel.selectedDate = date.date.value
        self.viewModel = viewModel
        collectionView.reloadData()
        moveToSelected()
    }
}
