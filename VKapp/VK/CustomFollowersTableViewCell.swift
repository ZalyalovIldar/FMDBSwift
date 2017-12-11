//
//  CustomFollowersTableViewCell.swift
//  VK
//
//  Created by Elina on 18/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class CustomFollowersTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    
    @IBOutlet weak var nameLabel: UILabel!

    @IBOutlet weak var statusImageView: UIImageView!
    
    var avatar = UIImage(assetName: .elina)
    
    var space: String = " "
    
    func prepareCell(with user: Users) {
        
        avatarImageView.image = avatar
        nameLabel.text = user.name + space + user.surname
        
        statusImageView.image = UIImage(assetName: .mobileIcon)
        
    }
}
