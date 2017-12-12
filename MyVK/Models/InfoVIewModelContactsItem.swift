//
//  InfoVIewModelContactsItem.swift
//  MyVK
//
//  Created by Дамир Зарипов on 25.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

struct InfoVIewModelContactsItem: InfoViewModelItem {
    var type: InfoViewModelItemType {
        return .contacts
    }
    var sectionType: String{
        return "Контакты"
    }
    var contacts: [Contacts]
    var rowCount: Int {
        return contacts.count
    }
}
