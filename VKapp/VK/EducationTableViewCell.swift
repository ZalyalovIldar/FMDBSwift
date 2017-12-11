//
//  EducationTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class EducationTableViewCell: UITableViewCell {
    
    @IBOutlet weak var educationTypeLabel: UILabel!
    
    @IBOutlet weak var educationPlaceLabel: UILabel!
    
    func prepareCell(with information: [Information], cellForRowAt indexPath: IndexPath) {
        
        educationTypeLabel.text = information[indexPath.section].rowsNames[indexPath.row]
        
        educationPlaceLabel.text = information[indexPath.section].rowsFilling[indexPath.row]
    }

}
