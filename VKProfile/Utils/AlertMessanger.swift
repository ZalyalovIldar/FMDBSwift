//
//  AlertMessanger.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 06.12.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

extension UIViewController {
    
    func showMessageAlert(with title: String, and text: String) {
        let alert = UIAlertController(title: title, message: text, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func showDatabaseSaveError() {
        showMessageAlert(with: "Oups!", and: "Произошла ошибка при сохранении в базу данных")
    }
    
}
