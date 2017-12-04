//
//  UserRepository.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

class UserRepository: BaseRepository {
    
    func check(with email: String, and password: String) -> Bool {
        let users: [UserVK] = syncGetAll()
        return users.contains(where: { $0.email == email && $0.password == password })
    }
    
    func search(with email: String) -> UserVK? {
        let users: [UserVK] = syncGetAll()
        return users.first(where: { $0.email == email })
    }
    
}
