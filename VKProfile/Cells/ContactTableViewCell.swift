//
//  ContactTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class ContactTableViewCell: UITableViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var contactLabel: UILabel!

    func prepareCell(with contact: Contact) {
        iconImageView.image = contact.icon
        contactLabel.text = contact.info
    }
    
}
