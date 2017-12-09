//
//  UserRepository.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

class UserRepository: BaseRepository {
    
    let checkUserSQL = "SELECT \(field_user_id) FROM users WHERE \(field_user_email) = ? AND \(field_user_password) = ?;"
    let searchUserSQL = "SELECT * FROM users WHERE \(field_user_email) = ?;"
    
    override init() {
        super.init()
    }
    
    func check(with email: String, and password: String) -> Bool {
        if databaseManager.openDatabase() {
            do {
                let result = try databaseManager.database.executeQuery(checkUserSQL, values: [email, password])
                return result.next()
            } catch {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    func search(with email: String) -> UserVK? {
        if databaseManager.openDatabase() {
            do {
                let result = try databaseManager.database.executeQuery(searchUserSQL, values: [email])
                return getUsers(from: result)?.first
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
