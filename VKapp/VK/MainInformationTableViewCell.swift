//
//  MainInformationTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class MainInformationTableViewCell: UITableViewCell {
    
    let brothersAAndSistersRowName = "Братья, сестры"
    
    @IBOutlet weak var rowNameLabel: UILabel!
    
    @IBOutlet weak var rowFillingLabel: UILabel!
    
    func prepareCell(with information: [Information], cellForRowAt indexPath: IndexPath) {
        
        let rowsName = information[indexPath.section].rowsNames[indexPath.row]
        rowNameLabel.text = rowsName
        
        let fillingInformation = information[indexPath.section].rowsFilling[indexPath.row]
        
        
        rowFillingLabel.text = fillingInformation
        
        if information[indexPath.section].rowsNames[indexPath.row] == brothersAAndSistersRowName {
            rowFillingLabel.textColor = UIColor.blue
        }
    }
}
