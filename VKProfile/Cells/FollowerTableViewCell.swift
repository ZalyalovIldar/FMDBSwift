//
//  FollowerTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 18.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusImageView: UIImageView!

    override func awakeFromNib() {
        super.awakeFromNib()
        avatarImageView.roundCorners()
    }

    func prepareCell(with user: User) {
        avatarImageView.image = user.profileImage
        nameLabel.text = "\(user.name) \(user.surname)"
        
        switch user.onlineStatus {
        case .offline:
            statusImageView.isHidden = true
            break
        case .mobile:
            statusImageView.image = #imageLiteral(resourceName: "mobile")
            break
        case .computer:
            statusImageView.image = #imageLiteral(resourceName: "dot")
            break
        }
    }
    
}
