//
//  DBManager.swift
//  VK
//
//  Created by Elina on 06/12/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit
import FMDB

class DBManager: DBManagerProtocol {
    
    lazy var databasePath = { () -> String in
        let dbName = "dbVKapp.db"
        let dirPaths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        return dirPaths[0].appendingPathComponent(dbName).path
    }
    
    let createNewsStmt = "CREATE TABLE IF NOT EXISTS NEWS (ID INTEGER PRIMARY KEY AUTOINCREMENT, CONTENT TEXT, IMAGE BLOB, USERS_ID INTEGER);"
    let createUsersStmt = "CREATE TABLE IF NOT EXISTS USERS (ID INTEGER PRIMARY KEY AUTOINCREMENT, NAME TEXT, SURNAME TEXT, GENDER TEXT, EMAIL TEXT, PHONE TEXT, AGE TEXT, CITY TEXT, PASSWORD TEXT);"
    
    let insUserStmt = "INSERT INTO USERS (NAME, SURNAME, GENDER, EMAIL, PHONE, AGE, CITY, PASSWORD) VALUES (?, ?, ?, ?, ?, ?, ?, ?)"
    let insNewsStmtWithImg = "INSERT INTO NEWS (CONTENT, IMAGE, USERS_ID) VALUES (?, ?, ?)"
    let insNewsStmtWithoutImg = "INSERT INTO NEWS (CONTENT, USERS_ID) VALUES (?, ?)"
    
    let selectUsersId = "SELECT ID FROM USERS WHERE EMAIL = "
    let selectNew = "SELECT * FROM NEWS WHERE USERS_ID = "
    
    let contentColumn = "CONTENT"
    let imageColumn = "IMAGE"
    let selectUsers = "SELECT * FROM USERS"
    let nameColumn = "NAME"
    let surnameColumn = "SURNAME"
    let genderColumn = "GENDER"
    let emailColumn = "EMAIL"
    let phoneColumn = "PHONE"
    let ageColumn = "AGE"
    let cityColumn = "CITY"
    let passwordColumn = "PASSWORD"
    
    init() {
        
        if !FileManager.default.fileExists(atPath: databasePath() as String) {
            let vkDB = FMDatabase(path: databasePath() as String)
            
            if (vkDB.open()) {
                
                if !(vkDB.executeStatements(createNewsStmt)) {
                    print("Error: \(vkDB.lastErrorMessage())")
                }
                if !(vkDB.executeStatements(createUsersStmt)) {
                    print("Error: \(vkDB.lastErrorMessage())")
                }
                vkDB.close()
            } else {
                print("Error: \(vkDB.lastErrorMessage())")
            }
        }
    }
    
    func save<T> (with object: T, on usersId: Int?) where T: DataProtocol {
        
        let vkDB = FMDatabase(path: databasePath() as String)
        if (vkDB.open()) {
            
            var insertSQL = ""
            var result = false
            
            if let obj = object as? News {
                if let id = usersId {
                    var imageData = Data()
                    if obj.image != nil {
                        imageData = UIImageJPEGRepresentation(obj.image!, 1)!
                        insertSQL = insNewsStmtWithImg
                        result = vkDB.executeUpdate(insertSQL, withArgumentsIn: [obj.content, imageData, id])
                    } else {
                        insertSQL = insNewsStmtWithoutImg
                        result = vkDB.executeUpdate(insertSQL, withArgumentsIn: [obj.content, id])
                    }
                }
            }
            
            if let obj = object as? Users {
                insertSQL = insUserStmt
                result = vkDB.executeUpdate(insertSQL, withArgumentsIn: [obj.name, obj.surname, obj.gender, obj.email, obj.phoneNumber, obj.age, obj.city, obj.password])
            }
            
            if !result {
                print("Error: \(vkDB.lastErrorMessage())")
            }
            
        } else {
            print("Error: \(vkDB.lastErrorMessage())")
        }
    }
    
    func get<T> (with usersId: Int?) -> [T] where T: DataProtocol {
        
        let vkDB = FMDatabase(path: databasePath() as String)
        var result: [T] = []
        
        if (vkDB.open()) {
            
            if T.self == News.self {
                if let id = usersId {
                    let querySQL = selectNew + "'\(id)'"
                    let results:FMResultSet? = vkDB.executeQuery(querySQL, withArgumentsIn: [])
                    while results?.next() == true {
                        var text = ""
                        var image: UIImage?
                        
                        if let content = results?.string(forColumn: contentColumn) {
                            text = content
                        }
                        
                        if let imageData = results?.data(forColumn: imageColumn) {
                            image = UIImage(data: imageData)
                        }
            
                        result.append(News(content: text, image: image) as! T)
                    }
                }
            }
            
            if T.self == Users.self {
                var name = ""
                var surname = ""
                var gender = ""
                var email = ""
                var phoneNumber = ""
                var age = ""
                var city = ""
                var password = ""
                
                let results:FMResultSet? = vkDB.executeQuery(selectUsers, withArgumentsIn: [])
                while results?.next() == true {
                    if let text = results?.string(forColumn: nameColumn) {
                        name = text
                    }
                    if let text = results?.string(forColumn: surnameColumn) {
                        surname = text
                    }
                    if let text = results?.string(forColumn: genderColumn) {
                        gender = text
                    }
                    if let text = results?.string(forColumn: emailColumn) {
                        email = text
                    }
                    if let text = results?.string(forColumn: phoneColumn) {
                        phoneNumber = text
                    }
                    if let text = results?.string(forColumn: ageColumn) {
                        age = text
                    }
                    if let text = results?.string(forColumn: cityColumn) {
                        city = text
                    }
                    if let text = results?.string(forColumn: passwordColumn) {
                        password = text
                    }
                    result.append(Users(name: name, surname: surname, gender: gender, email: email, phoneNumber: phoneNumber, age: age, city: city, password: password) as! T)
                }
            }
            vkDB.close()
        } else {
            print("Error: \(vkDB.lastErrorMessage())")
        }
        return result
    }
    
    func getId<T> (object: T) -> Int where T: DataProtocol {
        
        let vkDB = FMDatabase(path: databasePath() as String)
        var id = -1
        
        if (vkDB.open()) {
            
            var selectSQL = ""
            
            if let obj = object as? Users {
                selectSQL = selectUsersId + "'\(obj.email)'"
                let results:FMResultSet? = vkDB.executeQuery(selectSQL, withArgumentsIn: [])
                while results?.next() == true {
                    if let usersId = results?.int(forColumn: "ID") {
                        id = Int(usersId)
                    }
                }
                if id == -1 {
                    print ("Error: User not found.")
                }
            } else {
                print("Error: \(vkDB.lastErrorMessage())")
            }
        }
        return id
    }
}



