//
//  User.swift
//  MyVK
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

struct User {
    var idUser: Int
    var avatar: UIImage
    var name: String
    var surname: String
    var age: Int
    var city: String
    var status: UIImage
    var followers: [User]
    var presents: Int
}



