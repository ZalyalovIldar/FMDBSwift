//
//  WelcomePageViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class WelcomePageViewController: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var titleText: String!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = titleText
        photoImageView.image = image
    }

}
