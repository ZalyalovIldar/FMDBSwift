//
//  PhotosCollectionViewCell.swift
//  VK
//
//  Created by Elina on 22/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class PhotosCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photo: UIImageView!

    func prepareCell(with image: UIImage) {
        
        photo.image = image
        
    }
}
