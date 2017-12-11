//
//  ContactsTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ContactsTableViewCell: UITableViewCell {

    @IBOutlet weak var contactsIcon: UIImageView!
    
    @IBOutlet weak var contactLabel: UILabel!
    
    func prepareCell(with information: [Information], cellForRowAt indexPath: IndexPath) {
        contactsIcon.image = information[indexPath.section].rowsImages[indexPath.row]
        
        contactLabel.text = information[indexPath.section].rowsFilling[indexPath.row]
        
        if information[indexPath.section].rowsImages[indexPath.row] == UIImage(assetName: .phoneIcon) {
            contactLabel.textColor = UIColor.blue
        }
    }
}
