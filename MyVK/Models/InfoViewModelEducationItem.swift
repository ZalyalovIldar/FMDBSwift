//
//  InfoViewModelEducationItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelEducationItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .education
    }
    var sectionType: String{
        return "Образование"
    }
    var educations: [Education]
    var rowCount: Int {
        return educations.count
    }
}
