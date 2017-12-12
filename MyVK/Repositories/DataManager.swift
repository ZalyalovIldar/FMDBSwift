//
//  DataManager.swift
//  MyVK
//
//  Created by Дамир Зарипов on 03.12.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation
import FMDB

class DataManager: ManagerProtocol {
    
    var databaseManager: DatabaseManager!
   
    private let insertUserSQL = "INSERT INTO users (\(DatabaseManager.field_user_name), \(DatabaseManager.field_user_surname), \(DatabaseManager.field_user_email), \(DatabaseManager.field_user_sex), \(DatabaseManager.field_user_date_birthday), \(DatabaseManager.field_user_city), \(DatabaseManager.field_user_password)) VALUES (?,?,?,?,?,?,?);"
    
    private let insertNewsSQL = "INSERT INTO news (\(DatabaseManager.field_news_date), \(DatabaseManager.field_news_text), \(DatabaseManager.field_news_image), \(DatabaseManager.field_news_number_of_likes), \(DatabaseManager.field_news_number_of_comments), \(DatabaseManager.field_news_number_of_reposts), \(DatabaseManager.field_news_id_user)) VALUES (?,?,?,?,?,?,?);"
    
    private let selectAllUsersSQL = "SELECT * FROM users;"
    private let selectAllNewsSQL = "SELECT * FROM news;"
    private let searchUserByIdSQL = "SELECT * FROM users WHERE \(DatabaseManager.field_user_id) = ?;"
    private let searchNewsByIdSQL = "SELECT * FROM news WHERE \(DatabaseManager.field_news_id) = ?;"
    private let selectNewsForUserSQL = "SELECT * FROM news WHERE \(DatabaseManager.field_news_id_user) = ?;"
    
    let classUserWithRegistration = "UserWithRegistration"
    let classNews = "News"
    
    init() {
        databaseManager = DatabaseManager()
        databaseManager.createDatabase()
    }

    func syncSave<T: AnyObject>(with obj: T) -> Bool {
        guard databaseManager.openDatabase() else { return false }
        var isSaved = false
    
        if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == classUserWithRegistration) {
            guard let newUser = obj as? UserWithRegistration else { return false }
            isSaved = databaseManager.database.executeUpdate(insertUserSQL, withArgumentsIn: [newUser.name, newUser.surname, newUser.email, newUser.sex, newUser.dateBirthday, newUser.city, newUser.password])
        }
        
        if (NSStringFromClass(T.self).components(separatedBy: ".")[1] == classNews) {
            guard let newNews = obj as? News else { return false }
            
            var imageData = Data()
            
            if let imageCheck = newNews.image {
                if let imageToBlob = UIImageJPEGRepresentation(imageCheck, 1) {
                    imageData = imageToBlob
                }
            }
            
            var textNews = ""
            
            if let textCheck = newNews.text {
                textNews = textCheck
            }
            
            isSaved = databaseManager.database.executeUpdate(insertNewsSQL, withArgumentsIn: [newNews.date, textNews, imageData, newNews.numberOfLikes, newNews.numberOfComments, newNews.numberOfReposts, newNews.idUser])
        }
        
        databaseManager.database.close()
       
        return isSaved
    }
    
    func asynSave<T: AnyObject>(with obj: T, complitionBlock: @escaping (Bool) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            let isSaved = strongSelf.syncSave(with: obj)
            complitionBlock(isSaved)
        }
    }
    
    func syncGetAll<T: AnyObject>() -> [T]? {
        let className = NSStringFromClass(T.self).components(separatedBy: ".")[1]
        if className == classUserWithRegistration {
            return getAllUsers() as? [T]
        } else if className == classNews {
            return getAllNews() as? [T]
        }
        return nil
    }

    func asynGetAll<T: AnyObject>(complitionBlock: @escaping([T]) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            guard let arrayOfCurrectObject: [T] = strongSelf.syncGetAll() else { return }
            complitionBlock(arrayOfCurrectObject)
        }
    }
    
    func syncSearch<T: AnyObject> (by id: Int, type: T.Type) -> T? {
        let className = NSStringFromClass(T.self).components(separatedBy: ".")[1]
        if className == classUserWithRegistration {
            return getUser(with: id) as? T
        } else if className == classNews {
            return getNews(by: id) as? T
        }
        return nil
    }
    
   func asynSearch<T: AnyObject> (by id: Int, type: T.Type, complitionBlock: @escaping(T?) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else { return }
            complitionBlock(strongSelf.syncSearch(by: id, type: type))
        }
    }
    
    // MARK: - Users's methods
    func getAllUsers() -> [UserWithRegistration]? {
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
    
    func getUsers(from results: FMResultSet) -> [UserWithRegistration]? {
        var users = [UserWithRegistration]()
        while results.next() {
            let id = Int(results.int(forColumn: DatabaseManager.field_user_id))
            guard let name = results.string(forColumn: DatabaseManager.field_user_name),
                let surname = results.string(forColumn: DatabaseManager.field_user_surname),
                let email = results.string(forColumn: DatabaseManager.field_user_email),
                let sex = results.string(forColumn: DatabaseManager.field_user_sex),
                let dateBirthday = results.string(forColumn: DatabaseManager.field_user_date_birthday),
                let city = results.string(forColumn: DatabaseManager.field_user_city),
                let password = results.string(forColumn: DatabaseManager.field_user_password) else { return nil }
            
            let user = UserWithRegistration(id: id, name: name, surname: surname, email: email, sex: sex, dateBirthday: dateBirthday, city: city, password: password)
            
            users.append(user)
        }
        return (users.isEmpty) ? nil : users
    }
    
    func getUser(with id: Int) -> UserWithRegistration? {
        guard databaseManager.openDatabase() else { return nil }
        do {
            let result = try databaseManager.database.executeQuery(searchUserByIdSQL, values: [id])
            databaseManager.close()
            return getUsers(from: result)?.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    // MARK: - News's methods
    func getAllNews() -> [News]? {
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
    
    func getNews(from results: FMResultSet) -> [News]? {
        var news = [News]()
        while results.next() {
            let id = Int(results.int(forColumn: DatabaseManager.field_news_id))
            let idUser = Int(results.int(forColumn: DatabaseManager.field_news_id_user))
            
            guard let date = results.string(forColumn: DatabaseManager.field_news_date),
                let numberOfLikes = results.string(forColumn: DatabaseManager.field_news_number_of_likes),
                let numberOfComments = results.string(forColumn: DatabaseManager.field_news_number_of_comments),
                let numberOfReposts = results.string(forColumn: DatabaseManager.field_news_number_of_reposts) else { return nil }
            
            var text: String?
            if let textNews = results.string(forColumn: DatabaseManager.field_news_text) {
                text = textNews
            }
            
            var image: UIImage?
            if let imageNews = results.data(forColumn: DatabaseManager.field_news_image) {
                image = UIImage(data: imageNews)
            }
            
            news.append(News(id: id, date: date, text: text, image: image, numberOfLikes: numberOfLikes, numberOfComments: numberOfComments, numberOfReposts: numberOfReposts, idUser: idUser))
        }
        return (news.isEmpty) ? nil : news
    }
    
    func getNews(by id: Int) -> News? {
        guard databaseManager.openDatabase() else { return nil }
        do {
            let results = try databaseManager.database.executeQuery(searchNewsByIdSQL, values: [id])
            databaseManager.close()
            return getNews(from: results)?.first
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
    
    func getNewsForUser(by userId: Int) -> [News]? {
        guard databaseManager.openDatabase() else { return nil }
        do {
            let results = try databaseManager.database.executeQuery(selectNewsForUserSQL, values: [userId])
            return getNews(from: results)
        } catch {
            print(error.localizedDescription)
        }
        return nil
    }
}
