//
//  EducationTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {

    @IBOutlet weak var upperLabel: UILabel!
    @IBOutlet weak var infpLabel: UILabel!
    
    func prepareCell(with educationalModel: Education) {
        upperLabel.text = educationalModel.type
        infpLabel.text = educationalModel.name
    }
    
}
