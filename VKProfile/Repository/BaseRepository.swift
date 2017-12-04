//
//  RepositoryManager.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 27.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import FMDB

fileprivate enum ObjectType {
    case user
    case news
}

fileprivate let field_user_id = "user_id"
fileprivate let field_user_name = "user_name"
fileprivate let field_user_surname = "user_surname"
fileprivate let field_user_email = "user_email"
fileprivate let field_user_phone_number = "user_phone_number"
fileprivate let field_user_age = "user_age"
fileprivate let field_user_city = "user_city"
fileprivate let field_user_password = "user_password"

fileprivate let field_news_id = "news_id"
fileprivate let field_news_text = "news_text"
fileprivate let field_news_image = "news_image"
fileprivate let field_news_like_count = "news_like_count"
fileprivate let field_news_comment_count = "news_comment_count"
fileprivate let field_news_repost_count = "news_repost_count"

class BaseRepository: Repository {
    
    private let createUsersTableSQL = "CREATE TABLE users (\(field_user_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_user_name) TEXT NOT NULL, \(field_user_surname) TEXT NOT NULL, \(field_user_email) TEXT NOT NULL, \(field_user_phone_number) TEXT NOT NULL, \(field_user_age) INTEGER NOT NULL, \(field_user_city) TEXT NOT NULL, \(field_user_password) TEXT NOT NULL, CONSTRAINT email_unique UNIQUE (\(field_user_email));"
    private let createNewsTableSQL = "CREATE TABLE news (\(field_news_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_news_text) TEXT NOT NULL, \(field_news_image) TEXT NOT NULL, \(field_news_like_count) INTEGER NOT NULL, \(field_news_comment_count) INTEGER NOT NULL, \(field_news_repost_count) INTEGER NOT NULL);"
    private let insertUserSQL = "INSERT INTO users (\(field_user_name), \(field_user_surname), \(field_user_email), \(field_user_phone_number), \(field_user_age), \(field_user_city), \(field_user_password)) VALUES (?, ?, ?, ?, ?, ?, ?);"
    private let insertNewsSQL = "INSERT INTO news (\(field_news_text), \(field_news_image), \(field_news_like_count), \(field_news_comment_count), \(field_news_repost_count)) VALUES (?, ?, ?, ?, ?);"
    
    private let databaseFileName = "vkapp.sqlite"
    private lazy var pathToDatabase: String = {
       let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        return documentsDirectory.appending("/\(databaseFileName)")
    }()
    var database: FMDatabase!
    
    init() {
        createDatabase()
        
    }
    
    func syncSave<T>(with object: T) where T : Storable {
        object.id = Int(arc4random())
        let objectName = genericName(object)
        if objectName == "News" {
            let _ = insert(object, type: .news)
        }
        if objectName == "User" {
            let _ = insert(object, type: .user)
        }
    }
    
    func asyncSave<T>(with object: T, completionBlock: @escaping (Bool) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.syncSave(with: object)
            completionBlock(true)
        }
    }
    
    func syncGetAll<T>() -> [T] where T : Storable {
        let objectName = NSStringFromClass(T.self)
        return getData(key: objectName) ?? [T]()
    }
    
    func asyncGetAll<T>(completionBlock: @escaping ([T]) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            completionBlock(strongSelf.syncGetAll())
        }
    }
    
    func syncSearch<T>(id: Int, type: T.Type) -> T? where T : Storable {
        let objectName = NSStringFromClass(type)
        let objects = getData(key: objectName) ?? [T]()
        if objects.isEmpty {
            return nil
        }
        return objects.first(where: { $0.id == id })
    }
    
    func asyncSearch<T>(id: Int, type: T.Type, completionBlock: @escaping (T?) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            completionBlock(strongSelf.syncSearch(id: id, type: type))
        }
    }
    
    private func saveData<T: Storable>(array: [T], key: String) {
        let data = NSKeyedArchiver.archivedData(withRootObject: array)
        UserDefaults.standard.set(data, forKey: key)
    }
    
    private func getData<T>(key: String) -> [T]? where T: Storable {
        if let data = UserDefaults.standard.data(forKey: key) {
            return NSKeyedUnarchiver.unarchiveObject(with: data) as? [T]
        }
        return nil
    }
    
    //MARK: - Database prepare methods
    
    private func createDatabase() {
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase)
            if database != nil {
                if database.open() {
                    do {
                        try database.executeUpdate(createUsersTableSQL, values: nil)
                        try database.executeUpdate(createNewsTableSQL, values: nil)
                    } catch {
                        print("Could not create table")
                        print(error.localizedDescription)
                    }
                    database.close()
                } else {
                    print("Could not open the database")
                }
            }
        }
    }
    
    func openDatabase() -> Bool {
        if database == nil {
            if FileManager.default.fileExists(atPath: pathToDatabase) {
                database = FMDatabase(path: pathToDatabase)
            }
        }
        if database != nil {
            if database.open() {
                return true
            }
        }
        return false
    }
    
    //MARK: - Insert methods
    
    private func insert<T: Storable>(_ user: T, type: ObjectType) -> Bool {
        if openDatabase() {
            let userMirror = Mirror(reflecting: user)
            var values = userMirror.children.map { $0.value }
            values.removeFirst()
            var insertSQL: String!
            if type == .news {
                insertSQL = insertNewsSQL
            }
            if type == .user {
                insertSQL = insertUserSQL
            }
            let isUpdated = database.executeUpdate(insertSQL, withArgumentsIn: values)
            if !isUpdated {
                print("Failed to insert news")
                print(database.lastError(), database.lastErrorMessage())
            }
            return isUpdated
        }
        return false
    }
    
    //MARK: - Helpers methods
    
    private func genericName<T: Storable>(_ object: T) -> String {
        let fullName = NSStringFromClass(T.self)
        let range = fullName.range(of: ".")
        if let range = range {
            return String(fullName[range.lowerBound..<range.upperBound])
        }
        return fullName
    }
}

