//
//  InstituteTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class InstituteTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    @IBOutlet weak var departmentLabel: UILabel!
    @IBOutlet weak var typeStudyingLabel: UILabel!
    
    func prepareCell(with institute: Institute) {
        nameLabel.text = institute.name
        directionLabel.text = institute.direction
        departmentLabel.text = institute.department.rawValue
        typeStudyingLabel.text = institute.typeStudying.rawValue
    }
    
}
