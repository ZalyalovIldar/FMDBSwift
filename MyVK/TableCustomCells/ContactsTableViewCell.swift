//
//  ContactsTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    
    func prepareCell(with contactModel: Contacts) {
        logoImageView.image = contactModel.image
        nameLabel.text = contactModel.contact
    }
    
}
