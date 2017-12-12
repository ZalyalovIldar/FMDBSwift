//
//  BasicInfoTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 23.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class BasicInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var infoLabel: UILabel!
    
    func prepateCell(with basicInfoModel: BasicInfo) {
        upperLabel.text = basicInfoModel.title
        infoLabel.text = basicInfoModel.info
    }
    
}
