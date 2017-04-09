//
//  WideAppIconCollectionViewCell.swift
//  AppStore
//
//  Created by didYouUpdateCode on 2017/4/9.
//  Copyright © 2017年 didYouUpdateCode. All rights reserved.
//

import UIKit

class WideAppIconCollectionViewCell: UICollectionViewCell {

    static var identifier: String {
        return "WideAppIconCollectionViewCell"
    }
    
    @IBOutlet weak var imageView: UIImageView!
    
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
