//
//  ManagerProtocol.swift
//  MyVK
//
//  Created by Дамир Зарипов on 03.12.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

protocol ManagerProtocol {
    func syncSave<T: AnyObject>(with obj: T) -> Bool
    func asynSave<T: AnyObject>(with obj: T, complitionBlock: @escaping (Bool) -> ())
    func syncGetAll<T: AnyObject>() -> [T]?
    func asynGetAll<T: AnyObject>(complitionBlock: @escaping([T]) -> ())
    func syncSearch<T: AnyObject> (by id: Int, type: T.Type) -> T?
    func asynSearch<T: AnyObject> (by id: Int, type: T.Type, complitionBlock: @escaping(T?) -> ())
}
