//
//  InterestsTableViewCell.swift
//  VK
//
//  Created by Elina on 24/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class InterestsTableViewCell: UITableViewCell {
    
    @IBOutlet weak var interestNameLabel: UILabel!
    
    @IBOutlet weak var interestsCountLabel: UILabel!
    
    func prepareCell(with information: [Information], cellForRowAt indexPath: IndexPath) {
        
        interestNameLabel.text = information[indexPath.section].rowsNames[indexPath.row]
        interestsCountLabel.text = information[indexPath.section].rowsFilling[indexPath.row]
        
    }
}
