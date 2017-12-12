//
//  InfoViewModelCarierItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelCarierItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .carier
    }
    
    var sectionType: String {
        return "Карьера"
    }
    
    var rowCount: Int {
        return 1
    }
    
    var company: String
    var locationAndPeriod: String
    var position: String
}
