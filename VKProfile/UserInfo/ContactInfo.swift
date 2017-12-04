//
//  ContactInfo.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 22.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

struct Contact {
    var icon: UIImage
    var type: ContactType
    var info: String
}

enum ContactType {
    case phone
    case city
    case twitter
    case instagram
    case skype
    case vk
}
