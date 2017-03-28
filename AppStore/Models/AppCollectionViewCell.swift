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
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var categoryLabel: UILabel!
    @IBOutlet weak var priceLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
