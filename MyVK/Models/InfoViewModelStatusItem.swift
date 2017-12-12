//
//  InfoViewModelStatusItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelStatusItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .status
    }
    var sectionType: String{
        return ""
    }
    var rowCount: Int {
        return 1
    }
    var status: String
}
