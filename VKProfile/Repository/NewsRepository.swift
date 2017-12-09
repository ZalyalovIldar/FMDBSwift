//
//  NewsRepository.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 08.12.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

class NewsRepository: BaseRepository {
    
    private let searchNewsWithUserSQL = "SELECT * FROM news WHERE \(field_user_id) = ?;"
    
    override init() {
        super.init()
    }
    
    func getNews(with userID: Int) -> [News]? {
        guard databaseManager.openDatabase() else { return nil }
        
        do {
            let results = try databaseManager.database.executeQuery(searchNewsWithUserSQL, values: [userID])
            return getNews(from: results)
        } catch {
            print(error.localizedDescription)
        }
        
        return nil
    }
    
}
