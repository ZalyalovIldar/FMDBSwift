//
//  UserVK.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

class UserVK: NSObject, Storable {
    
    @objc var id: Int
    @objc var name: String
    @objc var surname: String
    @objc var email: String
    @objc var phoneNumber: String
    @objc var age: Int
    @objc var city: String
    @objc var password: String
    
    init(id: Int = 0, name: String, surname: String, email: String, phoneNumber: String, age: Int, city: String, password: String) {
        self.id = id
        self.name = name
        self.surname = surname
        self.email = email
        self.phoneNumber = phoneNumber
        self.age = age
        self.city = city
        self.password = password
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: #keyPath(UserVK.id))
        coder.encode(name, forKey: #keyPath(UserVK.name))
        coder.encode(surname, forKey: #keyPath(UserVK.surname))
        coder.encode(email, forKey: #keyPath(UserVK.email))
        coder.encode(phoneNumber, forKey: #keyPath(UserVK.phoneNumber))
        coder.encode(age, forKey: #keyPath(UserVK.age))
        coder.encode(city, forKey: #keyPath(UserVK.city))
        coder.encode(password, forKey: #keyPath(UserVK.password))
    }
    
    required convenience init?(coder decoder: NSCoder) {
        let id = decoder.decodeInteger(forKey: #keyPath(UserVK.id))
        let age = decoder.decodeInteger(forKey: #keyPath(UserVK.age))
        guard let name = decoder.decodeObject(forKey: #keyPath(UserVK.name)) as? String,
            let surname = decoder.decodeObject(forKey: #keyPath(UserVK.surname)) as? String,
            let email = decoder.decodeObject(forKey: #keyPath(UserVK.email)) as? String,
            let phoneNumber = decoder.decodeObject(forKey: #keyPath(UserVK.phoneNumber)) as? String,
            let city = decoder.decodeObject(forKey: #keyPath(UserVK.city)) as? String,
            let password = decoder.decodeObject(forKey: #keyPath(UserVK.password)) as? String else { return nil }
        
        self.init(id: id, name: name, surname: surname, email: email, phoneNumber: phoneNumber, age: age, city: city, password: password)
    }
}
