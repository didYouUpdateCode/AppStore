//
//  CategoryCollectionViewCell.swift
//  AppleStore
//
//  Created by didYouUpdateCode on 2017/3/28.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class CategoryTableViewCell: UITableViewCell {

    static var identifier: String {
        return "CategoryTableViewCell"
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var titleLabel: UILabel!
    
    var name: String? {
        didSet {
            titleLabel.text = name
        }
    }
    
    var apps: [App]? {
        didSet {
            collectionView.reloadData()
        }
    }
    
    var type: String?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupView()
    }
    
    func setupView() {
        collectionView.register(UINib(nibName: "AppCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: AppCollectionViewCell.identifier)
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}

extension CategoryTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return apps?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AppCollectionViewCell.identifier, for: indexPath) as! AppCollectionViewCell
        let app = apps?[indexPath.row]
        
        cell.name = app?.name
        cell.category = app?.category
        cell.price = app?.price
        cell.imageName = app?.imageName
        
        return cell
    }
}

extension CategoryTableViewCell: UICollectionViewDelegate {
    
}

extension CategoryTableViewCell: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: collectionView.frame.height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
    }
}
