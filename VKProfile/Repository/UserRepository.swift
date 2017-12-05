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
                if result.next() {
                    let id = Int(result.int(forColumn: BaseRepository.field_user_id))
                    let age = Int(result.int(forColumn: BaseRepository.field_user_age))
                    guard let name = result.string(forColumn: BaseRepository.field_user_name),
                    let surname = result.string(forColumn: BaseRepository.field_user_surname),
                    let email = result.string(forColumn: BaseRepository.field_user_email),
                    let phoneNumber = result.string(forColumn: BaseRepository.field_user_phone_number),
                    let city = result.string(forColumn: BaseRepository.field_user_city),
                    let password = result.string(forColumn: BaseRepository.field_user_password) else { return nil }
                    
                    return UserVK(id: id, name: name, surname: surname, email: email, phoneNumber: phoneNumber, age: age, city: city, password: password)
                }
            } catch {
                print(error.localizedDescription)
            }
        }
        return nil
    }
    
}
