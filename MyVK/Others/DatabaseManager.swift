//
//  DatabaseManager.swift
//  MyVK
//
//  Created by Дамир Зарипов on 10.12.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation
import FMDB

class DatabaseManager {
    
    // MARK: - USERS TABLE CONSTANTS
    static let field_user_id = "user_id"
    static let field_user_name = "user_name"
    static let field_user_surname = "user_surname"
    static let field_user_email = "user_email"
    static let field_user_sex = "user_sex"
    static let field_user_date_birthday = "user_date_birthday"
    static let field_user_city = "user_city"
    static let field_user_password = "user_password"
    
    // MARK: - NEWS TABLE CONSTANTS
    static let field_news_id = "news_id"
    static let field_news_date = "news_date"
    static let field_news_text = "news_text"
    static let field_news_image = "news_image"
    static let field_news_number_of_likes = "news_number_of_likes"
    static let field_news_number_of_comments = "news_number_of_comments"
    static let field_news_number_of_reposts = "news_number_of_reposts"
    static let field_news_id_user = "news_id_user"
  
    private let createUsersTableSQL = "CREATE TABLE users (\(field_user_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_user_name) TEXT NOT NULL, \(field_user_surname) TEXT NOT NULL, \(field_user_email) TEXT NOT NULL, \(field_user_sex) TEXT NOT NULL, \(field_user_date_birthday) INTEGER NOT NULL, \(field_user_city) TEXT NOT NULL, \(field_user_password) TEXT NOT NULL, CONSTRAINT email_unique UNIQUE (\(field_user_email)));"
    
    private let createNewsTableSQL = "CREATE TABLE news (\(field_news_id) INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, \(field_news_date) TEXT NOT NULL, \(field_news_text) TEXT NOT NULL, \(field_news_image) BLOB, \(field_news_number_of_likes) INTEGER NOT NULL, \(field_news_number_of_comments) INTEGER NOT NULL, \(field_news_number_of_reposts) INTEGER NOT NULL, \(field_news_id_user) INTEGER NOT NULL);"
    
    let databaseFileName = "vkdatabase.sqlite"
    private lazy var pathToDatabase: String = {
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        return documentsDirectory.appending("/\(databaseFileName)")
    }()
    
    var database: FMDatabase!
    
    func createDatabase() {
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase)
            
            if database != nil {
                if database.open() {
                    do {
                        try database.executeUpdate(createUsersTableSQL, values: nil)
                        try database.executeUpdate(createNewsTableSQL, values: nil)
                    } catch {
                        print("Could not create tables")
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
    
    func close() {
        database.close()
    }
    
}
