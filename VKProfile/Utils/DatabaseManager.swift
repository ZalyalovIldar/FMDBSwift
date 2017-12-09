//
//  DatabaseManager.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 06.12.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation
import FMDB

class DatabaseManager {
    
    private let databaseFileName = "vkapp.sqlite"
    private lazy var pathToDatabase: String = {
        let documentsDirectory = (NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as NSString) as String
        return documentsDirectory.appending("/\(databaseFileName)")
    }()
    var database: FMDatabase!
    
    func createDatabase(sql: [String]) {
        if !FileManager.default.fileExists(atPath: pathToDatabase) {
            database = FMDatabase(path: pathToDatabase)
            if database != nil {
                if database.open() {
                    do {
                        for query in sql {
                            try database.executeUpdate(query, values: nil)
                        }
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
    
    func close() {
        database.close()
    }
    
}
