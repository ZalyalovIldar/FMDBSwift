//
//  ExtensionTextField.swift
//  MyVK
//
//  Created by itisioslab on 07.11.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

extension UITextField {
    
    func setRedBorder() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.red.cgColor
        self.layer.masksToBounds = true
    }
    
    func setClearBorder() {
        self.layer.cornerRadius = 3.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor.clear.cgColor
        self.layer.masksToBounds = true
    }
    
}
