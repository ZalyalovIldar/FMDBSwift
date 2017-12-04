//
//  CheckBox.swift
//  GTD
//
//  Created by Тимур Шафигуллин on 27.10.2017.
//  Copyright © 2017 Flatstack. All rights reserved.
//

import UIKit

protocol CheckBoxChangeListener {
    func checkBoxChanged(sender: CheckBox)
}

class CheckBox: UIButton {
    
    let checkedImage: UIImage = #imageLiteral(resourceName: "checked")
    let uncheckedImage: UIImage = #imageLiteral(resourceName: "unchecked")
    var changeListener: CheckBoxChangeListener?
    
    var isChecked = false {
        didSet {
            if isChecked {
                self.setImage(#imageLiteral(resourceName: "checked"), for: .normal)
            } else {
                self.setImage(#imageLiteral(resourceName: "unchecked"), for: .normal)
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.isChecked = false
    }
    
}
