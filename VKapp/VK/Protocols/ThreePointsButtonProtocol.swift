//
//  ThreePointsButtonProtocol.swift
//  VK
//
//  Created by Elina on 09/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation
import UIKit

/// Протокол для обработки нажатия кнопки (three points)
protocol ThreePointsButtonProtocol {
    func didPressThreePointsButton() -> UIAlertController
}

extension ThreePointsButtonProtocol {
    
    func didPressThreePointsButton() -> UIAlertController {
        let actionSheetController: UIAlertController = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        
        let firstAction: UIAlertAction = UIAlertAction(title: "Редактировать профиль", style: .default)
        
        let secondAction: UIAlertAction = UIAlertAction(title: "Скопировать ссылку", style: .default)
        
        let thirdAction: UIAlertAction = UIAlertAction(title: "Поделиться...", style: .default)
        
        let cancelAction: UIAlertAction = UIAlertAction(title: "Отмена", style: .cancel)
        
        actionSheetController.addAction(firstAction)
        actionSheetController.addAction(secondAction)
        actionSheetController.addAction(thirdAction)
        actionSheetController.addAction(cancelAction)
        
        return actionSheetController
    }
}
