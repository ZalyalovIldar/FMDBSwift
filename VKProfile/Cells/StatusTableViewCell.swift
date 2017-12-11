//
//  StatusTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 21.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class StatusTableViewCell: UITableViewCell {
    
    @IBOutlet weak var statusTextLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var changeStatusLabel: UILabel!

    func prepareCell(with status: String) {
        if (status.isEmpty) {
            statusTextLabel.isHidden = true
            statusLabel.isHidden = true
            changeStatusLabel.isHidden = false
        } else {
            statusLabel.text = status
        }
    }
    
}
