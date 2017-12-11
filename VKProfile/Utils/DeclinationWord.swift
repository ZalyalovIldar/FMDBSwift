//
//  DeclinationWord.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 21.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import Foundation

struct DeclinationWord {
    var single: String
    var several: String
    var many: String
}

//ready to use words
extension DeclinationWord {
    static let friend = DeclinationWord(single: "друг", several: "друга", many: "друзей")
    static let follower = DeclinationWord(single: "подписчик", several: "подписчика", many: "подписчиков")
    static let group = DeclinationWord(single: "группа", several: "группы", many: "групп")
    static let photograph = DeclinationWord(single: "фотография", several: "фотографии", many: "фотографий")
    static let present = DeclinationWord(single: "подарок", several: "подарка", many: "подарков")
    static let file = DeclinationWord(single: "файл", several: "файла", many: "файлов")
    static let age = DeclinationWord(single: "год", several: "года", many: "лет")
}
