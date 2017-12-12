//
//  UserWithRegistration.swift
//  MyVK
//
//  Created by itisioslab on 07.11.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class UserWithRegistration: HasIdProtocol {
    var id: Int
    var name: String
    var surname: String
    var email: String
    var sex: String
    var dateBirthday: String
    var city: String
    var password: String
    
    init(name: String, surname: String, email: String, sex: String, dateBirthday: String, city: String, password: String) {
        self.id = 0
        self.name = name
        self.surname = surname
        self.email = email
        self.sex = sex
        self.dateBirthday = dateBirthday
        self.city = city
        self.password = password
    }
    
    init(id: Int, name: String, surname: String, email: String, sex: String, dateBirthday: String, city: String, password: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.sex = sex
        self.dateBirthday = dateBirthday
        self.city = city
        self.password = password
    }
    
    
}

