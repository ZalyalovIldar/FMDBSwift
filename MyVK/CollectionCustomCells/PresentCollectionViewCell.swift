//
//  PresentCollectionViewCell.swift
//  MyVK
//
//  Created by BLVCK on 26/10/2017.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class PresentCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var presentImageView: UIImageView!
    
    func prepareCell(with present: UIImage) {
        presentImageView.image = present
    }

}
