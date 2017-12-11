//
//  OtherInfoTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 23.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class OtherInfoTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    func prepareCell(with info: OtherInfo) {
        titleLabel.text = info.type.rawValue
        countLabel.text = String(info.count)
    }
    
}
