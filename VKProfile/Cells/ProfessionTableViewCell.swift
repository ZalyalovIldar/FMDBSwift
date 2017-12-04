//
//  CareerTableViewCell.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

let since = "с"

class ProfessionTableViewCell: UITableViewCell {

    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var datePeriodLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
    
    func prepareCell(with profession: Profession) {
        companyLabel.text = profession.company
        cityLabel.text = profession.city
        professionLabel.text = profession.name
        
        let calendar = Calendar.current
        let startDate = profession.startDate
        let startYear = calendar.component(.year, from: startDate)
        if let endDate = profession.endDate {
            let endYear = calendar.component(.year, from: endDate)
            datePeriodLabel.text = "\(startYear) - \(endYear)"
        } else {
            datePeriodLabel.text = since + " \(startYear) г."
        }
    }
    
}
