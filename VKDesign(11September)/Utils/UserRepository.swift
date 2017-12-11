//
//  UserRepository.swift
//  VKDesign(11September)
//
//  Created by BLVCK on 30/10/2017.
//  Copyright © 2017 blvvvck production. All rights reserved.
//

import Foundation

class UserRepository {
    
    static let sharedInstance = UserRepository()
    private init() {}
    
    var users =  [UserRegistration]()
    var manager = DataManager()
    let userCheckSQL = "select * from user where user_email = ? and user_password = ?"
    let userGetSQL = "select * from user where user_email = ?"
    
    func save(with user: UserRegistration) {
        users.append(user)
    }
    
    func get() -> UserRegistration? {
        if let user = users.first {
            return user
        }
        return nil
    }
    
    func check(with email: String, and password: String) -> Bool {
        
        if manager.openDatabase() {
            
            do {
                let result = try manager.database.executeQuery(userCheckSQL, values: [email, password])
                return result.next()
            }
            catch {
                print("неудачная попытка проверки при логине")
            }
        }
        return false
    }
    
    func getUser(with email: String) -> UserRegistration? {
        
        var users = [UserRegistration]()
        
        if manager.openDatabase() {
            
            do {
                let result = try manager.database.executeQuery(userGetSQL, values: [email])
                
                while result.next() == true {
                    guard let result_id = result.string(forColumn: "user_id"),
                        let result_name = result.string(forColumn: "user_name"),
                        let result_surname = result.string(forColumn: "user_surname"),
                        let result_gender = result.string(forColumn: "user_gender"),
                        let result_email = result.string(forColumn: "user_email"),
                        let result_phoneNumber = result.string(forColumn: "user_phoneNumber"),
                        let result_age = result.string(forColumn: "user_age"),
                        let result_city = result.string(forColumn: "user_city"),
                        let result_password = result.string(forColumn: "user_password") else { return nil }
                    
                    let user = UserRegistration(id: Int(result_id)!,name: result_name, surname: result_surname, gender: result_gender, email: result_email, phoneNumber: result_phoneNumber, age: result_age, city: result_city, password: result_password)
                    users.append(user)
                }
            }
            catch {
                print("неудачаная попытка получить юзера при логине")
            }
        
        }
        return users.first
    }
}
