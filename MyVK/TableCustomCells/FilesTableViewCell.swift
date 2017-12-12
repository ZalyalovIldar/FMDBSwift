//
//  FilesTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class FilesTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet weak var countLabel: UILabel!
    
    func prepareCell(with filesModel: Files) {
        nameLabel.text = filesModel.name
        countLabel.text = filesModel.numbersOfIt
    }
    
}
