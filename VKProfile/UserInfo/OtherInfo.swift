//
//  OtherInfo.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 23.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct OtherInfo {
    var type: OtherInfoType
    var count: Int
}

enum OtherInfoType: String {
    case interestingPages = "Интересные страницы"
    case notes = "Заметки"
    case documents = "Документы"
}
