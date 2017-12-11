//
//  GiftsCollectionViewCell.swift
//  VK
//
//  Created by Elina on 23/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class GiftsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var giftImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareCell(with image: UIImage) {
        giftImage.image = image    
    
    }

}
