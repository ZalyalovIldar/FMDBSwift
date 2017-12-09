//
//  RepositoryManager.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 27.11.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit
import FMDB

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
    private let createNewsTableSQL = "CREATE TABLE news (\(field_news_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_news_text) TEXT NOT NULL, \(field_news_image) BLOB, \(field_news_like_count) INTEGER NOT NULL, \(field_news_comment_count) INTEGER NOT NULL, \(field_news_repost_count) INTEGER NOT NULL, \(field_user_id) INTEGER NOT NULL);"
    private let selectAllNewsSQL = "SELECT * FROM news;"
    private let selectAllUsersSQL = "SELECT * FROM users;"
    private let searchNewsSQL = "SELECT * FROM news WHERE \(field_news_id) = ?;"
    private let searchUserSQL = "SELECT * FROM users WHERE \(field_user_id) = ?;"
    
    init() {
        databaseManager = DatabaseManager()
        databaseManager.createDatabase(sql: [createNewsTableSQL, createUsersTableSQL])
    }
    
    func syncSave<T>(with object: T) -> Bool where T : Storable {
        guard databaseManager.openDatabase() else { return false }

        let isSaved = databaseManager.database.executeUpdate(object.insertQuery.query, withArgumentsIn: object.insertQuery.data)
        databaseManager.close()
        return isSaved
    }
    
    func asyncSave<T>(with object: T, completionBlock: @escaping (Bool) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            let isSaved = strongSelf.syncSave(with: object)
            completionBlock(isSaved)
        }
    }
    
    func syncGetAll<T>() -> [T]? where T : Storable {
        let objectName = genericName(T.self)
        if objectName == "News" {
            return getAllNews() as? [T]
        } else if objectName == "UserVK" {
            return getAllUsers() as? [T]
        }
        
        return nil
    }
    
    func asyncGetAll<T>(completionBlock: @escaping ([T]?) -> ()) where T : Storable {
        OperationQueue().addOperation { [weak self] in
            guard let strongSelf = self else { return }
            completionBlock(strongSelf.syncGetAll())
        }
    }
    
    func syncSearch<T>(id: Int, type: T.Type) -> T? where T : Storable {
        let objectName = genericName(T.self)
        if objectName == "News" {
            return getNews(with: id) as? T
        } else if objectName == "UserVK" {
            return getUser(with: id) as? T
        }
        
        return nil
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
    
    //MARK: - Get methods
    
    private func getAllNews() -> [News]? {
        guard databaseManager.openDatabase() else { return nil }
    
        do {
            let results = try databaseManager.database.executeQuery(selectAllNewsSQL, values: nil)
            databaseManager.close()
            return getNews(from: results)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getAllUsers() -> [UserVK]? {
        guard databaseManager.openDatabase() else { return nil }
        
        do {
            let results = try databaseManager.database.executeQuery(selectAllUsersSQL, values: nil)
            databaseManager.close()
            return getUsers(from: results)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    private func getNews(with ID: Int) -> News? {
        guard databaseManager.openDatabase() else { return nil }
        
        do {
            let result = try databaseManager.database.executeQuery(searchNewsSQL, values: [ID])
            databaseManager.close()
            return getNews(from: result)?.first
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    private func getUser(with ID: Int) -> UserVK? {
        guard databaseManager.openDatabase() else { return nil }
        
        do {
            let result = try databaseManager.database.executeQuery(searchUserSQL, values: [ID])
            databaseManager.close()
            return getUsers(from: result)?.first
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
    //MARK: - Helpers methods
    
    func getUsers(from result: FMResultSet) -> [UserVK]? {
        var users = [UserVK]()
        while result.next() {
            let id = Int(result.int(forColumn: BaseRepository.field_user_id))
            let age = Int(result.int(forColumn: BaseRepository.field_user_age))
            guard let name = result.string(forColumn: BaseRepository.field_user_name),
                let surname = result.string(forColumn: BaseRepository.field_user_surname),
                let email = result.string(forColumn: BaseRepository.field_user_email),
                let phoneNumber = result.string(forColumn: BaseRepository.field_user_phone_number),
                let city = result.string(forColumn: BaseRepository.field_user_city),
                let password = result.string(forColumn: BaseRepository.field_user_password) else { return nil }
            
            users.append(UserVK(id: id, name: name, surname: surname, email: email, phoneNumber: phoneNumber, age: age, city: city, password: password))
        }
        return users.isEmpty ? nil : users
    }
    
    func getNews(from results: FMResultSet) -> [News]? {
        var news = [News]()
        while results.next() {
            let id = Int(results.int(forColumn: BaseRepository.field_news_id))
            let likeCount = Int(results.int(forColumn: BaseRepository.field_news_like_count))
            let commentCount = Int(results.int(forColumn: BaseRepository.field_news_comment_count))
            let repostCount = Int(results.int(forColumn: BaseRepository.field_news_repost_count))
            let userID = Int(results.int(forColumn: BaseRepository.field_user_id))
            guard let text = results.string(forColumn: BaseRepository.field_news_text) else { return nil }
            
            var image: UIImage?
            if let imageData = results.data(forColumn: BaseRepository.field_news_image) {
                image = UIImage(data: imageData)
            }
            
            news.append(News(id: id, text: text, image: image, likeCount: likeCount, commentCount: commentCount, respostCount: repostCount, userID: userID))
        }
        databaseManager.close()
        return (news.isEmpty) ? nil : news
    }
    
    private func genericName<T: AnyObject>(_ type: T.Type) -> String {
        let fullName = NSStringFromClass(T.self)
        let range = fullName.range(of: ".")
        if let range = range {
            return String(fullName[range.upperBound..<fullName.endIndex])
        }
        return fullName
    }
}

