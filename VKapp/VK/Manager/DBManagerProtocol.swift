//
//  DBManagerProtocol.swift
//  VK
//
//  Created by Elina on 07/12/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation

protocol DBManagerProtocol {
    func save<T: DataProtocol> (with object: T, on usersId: Int?)
    func get<T: DataProtocol> (with usersId: Int?) -> [T]
    func getId<T: DataProtocol> (object: T) -> Int 
}
