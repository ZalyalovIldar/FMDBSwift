//
//  DescriptionCollectionViewCell.swift
//  VK
//
//  Created by Elina on 22/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class DescriptionCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var button: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func prepareButton(title: String) {
        
        button.setTitle(title, for: .normal)
        
        setupButtonsTitle()
        
    }
    
    func setupButtonsTitle(){
        button.titleLabel?.lineBreakMode = NSLineBreakMode.byWordWrapping
        button.titleLabel?.textAlignment = NSTextAlignment.center
    }
}
