//
//  FollowerTableViewCell.swift
//  MyVK
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var avatarUIImage: UIImageView!
    @IBOutlet weak var statusUIImage: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var surnameLable: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        avatarUIImage.layer.cornerRadius = avatarUIImage.frame.size.width/2
        avatarUIImage.clipsToBounds = true
    }

    func prepareCell(with user: User) {
        avatarUIImage.image = user.avatar
        statusUIImage.image = user.status
        nameLable.text = user.name
        surnameLable.text = user.surname
        surnameLable.font = UIFont.boldSystemFont(ofSize: surnameLable.font.pointSize)
    }
    
}
