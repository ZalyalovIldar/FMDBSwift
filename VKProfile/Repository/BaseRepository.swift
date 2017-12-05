//
//  RepositoryManager.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 27.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

fileprivate enum ObjectType {
    case user
    case news
}



class BaseRepository: Repository {
    
    static let field_user_id = "user_id"
    static let field_user_name = "user_name"
    static let field_user_surname = "user_surname"
    static let field_user_email = "user_email"
    static let field_user_phone_number = "user_phone_number"
    static let field_user_age = "user_age"
    static let field_user_city = "user_city"
    static let field_user_password = "user_password"
    
    static let field_news_id = "news_id"
    static let field_news_text = "news_text"
    static let field_news_image = "news_image"
    static let field_news_like_count = "news_like_count"
    static let field_news_comment_count = "news_comment_count"
    static let field_news_repost_count = "news_repost_count"
    
    var databaseManager: DatabaseManager!
    
    private let createUsersTableSQL = "CREATE TABLE users (\(field_user_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_user_name) TEXT NOT NULL, \(field_user_surname) TEXT NOT NULL, \(field_user_email) TEXT NOT NULL, \(field_user_phone_number) TEXT NOT NULL, \(field_user_age) INTEGER NOT NULL, \(field_user_city) TEXT NOT NULL, \(field_user_password) TEXT NOT NULL, CONSTRAINT email_unique UNIQUE (\(field_user_email)));"
    private let createNewsTableSQL = "CREATE TABLE news (\(field_news_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_news_text) TEXT NOT NULL, \(field_news_image) TEXT NOT NULL, \(field_news_like_count) INTEGER NOT NULL, \(field_news_comment_count) INTEGER NOT NULL, \(field_news_repost_count) INTEGER NOT NULL, \(field_user_id) INTEGER NOT NULL);"
    private let insertUserSQL = "INSERT INTO users (\(field_user_name), \(field_user_surname), \(field_user_email), \(field_user_phone_number), \(field_user_age), \(field_user_city), \(field_user_password)) VALUES (?, ?, ?, ?, ?, ?, ?);"
    private let insertNewsSQL = "INSERT INTO news (\(field_news_text), \(field_news_image), \(field_news_like_count), \(field_news_comment_count), \(field_news_repost_count), \(field_user_id)) VALUES (?, ?, ?, ?, ?, ?);"
    
    init() {
        databaseManager = DatabaseManager()
        databaseManager.createDatabase(sql: [createNewsTableSQL, createUsersTableSQL])
    }
    
    func syncSave<T>(with object: T) -> Bool where T : Storable {
        let objectName = genericName(object)
        if objectName == "News" {
            return insert(object, type: .news)
        }
        if objectName == "UserVK" {
            return insert(object, type: .user)
        }
        return false
    }
    
    func asyncSave<T>(with object: T, completionBlock: @escaping (Bool) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            let isSaved = strongSelf.syncSave(with: object)
            completionBlock(isSaved)
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
    
    //MARK: - Insert methods
    
    private func insert<T: Storable>(_ user: T, type: ObjectType) -> Bool {
        if databaseManager.openDatabase() {
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
            let isUpdated = databaseManager.database.executeUpdate(insertSQL, withArgumentsIn: values)
            if !isUpdated {
                print("Failed to insert news")
                print(databaseManager.database.lastError(),databaseManager.database.lastErrorMessage())
            }
            return isUpdated
        }
        return false
    }
    
    //MARK: - Get methods
    
    
    //MARK: - Helpers methods
    
    private func genericName<T: Storable>(_ object: T) -> String {
        let fullName = NSStringFromClass(T.self)
        let range = fullName.range(of: ".")
        if let range = range {
            return String(fullName[range.upperBound..<fullName.endIndex])
        }
        return fullName
    }
}

