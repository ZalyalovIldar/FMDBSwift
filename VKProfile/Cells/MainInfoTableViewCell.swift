//
//  MainInfoTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class MainInfoTableViewCell: UITableViewCell {

    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!

    func prepareCell(with mainInfo: MainInfo) {
        titleLabel.text = mainInfo.type.rawValue
        infoLabel.text = mainInfo.info
    }
    
}
