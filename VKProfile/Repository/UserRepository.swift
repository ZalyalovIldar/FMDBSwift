//
//  UserRepository.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

class UserRepository: BaseRepository {
    
    let checkUserSQL = "SELECT user_id FROM users WHERE user_email = ? AND user_passwrod = ?;"
    
    func check(with email: String, and password: String) -> Bool {
        if openDatabase() {
            do {
                let result = try database.executeQuery(checkUserSQL, values: [email, password])
                return result.next()
            } catch {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    func search(with email: String) -> UserVK? {
        let users: [UserVK] = syncGetAll()
        return users.first(where: { $0.email == email })
    }
    
}
