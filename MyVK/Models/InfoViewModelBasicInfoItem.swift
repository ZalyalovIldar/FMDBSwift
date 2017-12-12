//
//  InfoViewModelBasicInfoItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoViewModelBasicInfoItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .basicInfo
    }
    var sectionType: String{
        return ""
    }
    
    var basicInfo: [BasicInfo]
    
    var rowCount: Int{
        return basicInfo.count
    }
    
}
