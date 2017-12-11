//
//  PhotoCollectionViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 19.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    func prepareCell(with photo: UIImage) {
        photoImageView.image = photo
    }
    
}
