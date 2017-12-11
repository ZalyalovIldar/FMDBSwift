//
//  Users.swift
//  VK
//
//  Created by Elina on 31/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation
import UIKit

class Users: NSObject, DataProtocol {
    
    var name: String
    var surname: String
    var gender: String
    var email: String
    var phoneNumber: String
    var age: String
    var city: String
    var password: String
    
    init (name: String, surname: String, gender: String, email: String, phoneNumber: String, age: String, city: String, password: String) {
        self.name = name
        self.surname = surname
        self.gender = gender
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(name, forKey: #keyPath(Users.name))
        aCoder.encode(surname, forKey: #keyPath(Users.surname))
        aCoder.encode(gender, forKey: #keyPath(Users.gender))
        aCoder.encode(email, forKey: #keyPath(Users.email))
        aCoder.encode(phoneNumber, forKey: #keyPath(Users.phoneNumber))
        aCoder.encode(age, forKey: #keyPath(Users.age))
        aCoder.encode(city, forKey: #keyPath(Users.city))
        aCoder.encode(password, forKey: #keyPath(Users.password))

    }
    
    required init?(coder aDecoder: NSCoder) {
        name = aDecoder.decodeObject(forKey: #keyPath(Users.name)) as? String ?? ""
        surname = aDecoder.decodeObject(forKey: #keyPath(Users.surname)) as? String ?? ""
        gender = aDecoder.decodeObject(forKey: #keyPath(Users.gender)) as? String ?? ""
        email = aDecoder.decodeObject(forKey: #keyPath(Users.email)) as? String ?? ""
        age = aDecoder.decodeObject(forKey: #keyPath(Users.age)) as? String ?? ""
        phoneNumber = aDecoder.decodeObject(forKey: #keyPath(Users.phoneNumber)) as? String ?? ""
        city = aDecoder.decodeObject(forKey: #keyPath(Users.city)) as? String ?? ""
        password = aDecoder.decodeObject(forKey: #keyPath(Users.password)) as? String ?? ""

    }
}
