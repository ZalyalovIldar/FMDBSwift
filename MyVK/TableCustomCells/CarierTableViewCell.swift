//
//  CarierTableViewCell.swift
//  MyVK
//
//  Created by Дамир Зарипов on 24.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class CarierTableViewCell: UITableViewCell {
    
    @IBOutlet weak var companyLabel: UILabel!
    @IBOutlet weak var localAndYearsLabel: UILabel!
    @IBOutlet weak var professionLabel: UILabel!
   
    func prepareCell(with item: InfoViewModelCarierItem) {
        companyLabel.text = item.company
        localAndYearsLabel.text = item.locationAndPeriod
        professionLabel.text = item.position
    }
}
