//
//  MainInfo.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct MainInfo {
    var type: MainInfoType
    var info: String
}

enum MainInfoType: String {
    case birthday = "День рождения"
    case hometown = "Родной город"
    case placeOfStudy = "Место учебы"
    case familyStatus = "Семейное положение"
    case parents = "Родители"
    case siblings = "Братья, сестры"
}

enum FamilyStatus: String {
    case notMarried = "Не женат"
    case havePartner = "Есть подруга"
    case betrothed = "Помолвлен"
    case married = "Женат"
    case complicated = "Всё сложно"
    case activelyLooking = "В активном поиске"
    case inLove = "Влюблён"
    case inCivilMarriage = "В гражданском браке"
    
    static let statuses = [notMarried, havePartner, betrothed, married, complicated, activelyLooking, inLove, inCivilMarriage]
}
