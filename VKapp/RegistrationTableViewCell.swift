//
//  RegistrationTableViewCell.swift
//  VK
//
//  Created by Elina on 31/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class RegistrationTableViewCell: UITableViewCell, UITextFieldDelegate {
    
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var registrationTextField: UITextField!
    
    var registrationDataTransferDelegate: RegistrationDataTransferProtocol?
    
    var index: Int!
    
    func prepareCell(with title: String) {
        registrationTextField.delegate = self
        titleLabel.text = title
    }
    
    // MARK: UITextFieldDelegate
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        
        guard let text = registrationTextField.text,
            !text.isEmpty
            else { return }
        
        registrationDataTransferDelegate?.sendData(with: text, at: index)
    }
    
}
