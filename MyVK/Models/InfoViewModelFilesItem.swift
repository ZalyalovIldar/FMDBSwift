//
//  InfoViewModelFilesItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelFilesItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .files
    }
    
    var sectionType: String {
        return ""
    }
    
    var files: [Files]
    var rowCount: Int {
        return 3
    }
    
}
