//
//  InfoViewModelItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

protocol InfoViewModelItem {
    var type: InfoViewModelItemType {get}
    var sectionType: String {get}
    var rowCount: Int {get}
}
