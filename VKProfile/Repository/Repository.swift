//
//  Repository.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 26.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

protocol Repository {
    
    func syncSave<T: Storable>(with: T)
    func asyncSave<T: Storable>(with: T, completionBlock: @escaping (Bool) -> ())
    func syncGetAll<T: Storable>() -> [T]
    func asyncGetAll<T: Storable>(completionBlock: @escaping ([T]) -> ())
    func syncSearch<T: Storable>(id: Int, type: T.Type) -> T?
    func asyncSearch<T: Storable>(id: Int, type: T.Type, completionBlock: @escaping (T?) -> ())
    
}
