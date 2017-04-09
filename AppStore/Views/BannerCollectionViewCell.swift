//
//  BannerCollectionViewCell.swift
//  AppStore
//
//  Created by Hank Chiang on 2017/4/7.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class BannerCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    
    static var identifier: String {
        return "BannerCollectionViewCell"
    }
    
    var imageName: String? {
        didSet {
            imageView.image = (imageName != nil) ? UIImage(named: imageName!) : nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
