//
//  AppCollectionViewCell.swift
//  AppleStore
//
//  Created by didYouUpdateCode on 2017/3/28.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class AppCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return "AppCollectionViewCell"
    }
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    var name: String? {
        didSet {
            nameLabel.text = name
        }
    }
    
    var category: String? {
        didSet {
            categoryLabel.text = category
        }
    }
    
    var price: NSNumber? {
        didSet {
            if let stringValue = price?.stringValue {
                priceLabel.text = "$\(stringValue)"
            } else {
                priceLabel.text = ""
            }
        }
    }
    
    var imageName: String? {
        didSet {
            imageView.image = UIImage(named: imageName ?? "")
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageView.layer.cornerRadius = 16
        imageView.layer.masksToBounds = true
    }

}
