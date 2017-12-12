//
//  User.swift
//  MyVK
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class UserInfo {
    
//    private static let names = ["Sergey", "Cesar", "Maxim"]
//    private static let surnames = ["Ryzhikov", "Navas", "Kannunikov"]
//    private static let cities = ["Kazan", "Madrid", "Moscow"]
    private static let avatars = [#imageLiteral(resourceName: "test-avatar-1"), #imageLiteral(resourceName: "test-avatar-2"), #imageLiteral(resourceName: "test-avatar-3")]
    private static let statuses = [#imageLiteral(resourceName: "icon-online"), #imageLiteral(resourceName: "icon-phone"), #imageLiteral(resourceName: "icon-offline")]
    private static let maxRandomValue: UInt32 = 100
    
    static func createInfo(with userWithRegistration: UserWithRegistration) -> User {
        let idUser = userWithRegistration.id
        let avatar = avatars[Int(arc4random_uniform(UInt32(avatars.count)))]
        let name = userWithRegistration.name
        let surname = userWithRegistration.surname
        let city = userWithRegistration.city
        let age = Int(arc4random_uniform(maxRandomValue))
        let status = statuses[Int(arc4random_uniform(UInt32(statuses.count)))]
        let presents = Int(arc4random_uniform(maxRandomValue))
        return User(idUser: idUser, avatar: avatar, name: name, surname: surname, age: age, city: city, status: status,
                    followers: [User](), presents: presents)
    }
    

}
