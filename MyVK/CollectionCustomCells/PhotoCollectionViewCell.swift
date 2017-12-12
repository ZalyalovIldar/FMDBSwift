//
//  PhotoCollectionViewCell.swift
//  MyVK
//
//  Created by BLVCK on 27/10/2017.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var photoImageView: UIImageView!
    
    func prepareCell(with photo: UIImage) {
        photoImageView.image = photo
    }

}
