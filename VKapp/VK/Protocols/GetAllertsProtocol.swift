//
//  FormsValidationProtocol.swift
//  VK
//
//  Created by Elina on 01/11/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation
import UIKit

protocol GetAllertsProtocol {
    func getErrorOkAlert() -> UIAlertController
}

extension GetAllertsProtocol {
    
    func getErrorOkAlert() -> UIAlertController {
        
        let alert: UIAlertController = UIAlertController(title: "Ошибка", message: nil, preferredStyle: .alert)
        
        let OKAction = UIAlertAction(title: "OK", style: .default)
        
        alert.addAction(OKAction)
        
        return alert
        
    }
}

