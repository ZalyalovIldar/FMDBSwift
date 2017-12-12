//
//  UserManager.swift
//  MyVK
//
//  Created by Дамир Зарипов on 08.12.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

class UserManager: DataManager {

    let chekUserSQL = "SELECT * FROM users WHERE \(DatabaseManager.field_user_email) = ? AND \(DatabaseManager.field_user_password) = ?;"
    let searchUserSQL = "SELECT * FROM users WHERE \(DatabaseManager.field_user_email) = ?;"
    
    override init() {
        super.init()
    }
    
    func checkUser(email: String, password: String) -> Bool {
        if databaseManager.openDatabase() {
            do {
                let result = try databaseManager.database.executeQuery(chekUserSQL, values: [email, password])
                return result.next()
            } catch {
                print(error.localizedDescription)
            }
        }
        return false
    }
    
    func searchUser(email: String) -> UserWithRegistration? {
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
