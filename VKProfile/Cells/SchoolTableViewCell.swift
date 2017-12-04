//
//  SchoolTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class SchoolTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var datePeriodLabel: UILabel!
    @IBOutlet weak var directionLabel: UILabel!
    
    func prepareCell(with school: School) {
        let since = "с"
        
        nameLabel.text = school.name
        cityLabel.text = school.city
        directionLabel.text = school.direction
        
        let calendar = Calendar.current
        let startYear = calendar.component(.year, from: school.startDate)
        if let endDate = school.endDate {
            let endYear = calendar.component(.year, from: endDate)
            datePeriodLabel.text = "\(startYear)-\(endYear)"
        } else {
            datePeriodLabel.text = since + " \(startYear) г."
        }
    }
    
}
