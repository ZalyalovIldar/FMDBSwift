	//
//  RepositoryProtocol.swift
//  MyVK
//
//  Created by Дамир Зарипов on 29.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

protocol RepositoryProtocol {
    associatedtype T
    
    func syncSave(with: T) -> Bool
    func asynSave(with: T, complitionBlock: @escaping (Bool) -> ())
    func syncGetAll() -> [T]
    func asynGetAll(complitionBlock: @escaping ([T]) -> ())
    func syncSearch(by id: Int) -> T?
    func asynSearch(by id: Int, complitionBlock: @escaping (T?) -> ())
 }
