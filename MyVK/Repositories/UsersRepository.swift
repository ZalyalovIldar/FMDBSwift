//
//  UserRepository.swift
//  MyVK
//
//  Created by Дамир Зарипов on 16.11.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

class UsersRepository {
   
    static let instance = UsersRepository()
    
    private var users = [UserWithRegistration]()
    
    func register(user: UserWithRegistration) {
        users.append(user)
    }
    
    func checkData(with email: String, and password: String) -> Bool {
        return users.contains(where: { $0.email == email && $0.password == password })
    }
    
    func search(with email: String) -> UserWithRegistration? {
        return users.first(where: { $0.email == email })
    }
}
