//
//  User.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 17.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

enum OnlineStatus: String {
    case offline = "Offline"
    case mobile = "Online (Моб.)"
    case computer = "Online"
    
    static let statuses = [offline, mobile, computer]
}

enum InformationType {
    case friends
    case followers
    case groups
    case photos
    case videos
    case audios
    case presents
    case files
    
    static let types = [friends, followers, groups, photos, videos, audios, presents, files]
}

struct User {
    var name: String
    var surname: String
    var onlineStatus: OnlineStatus
    var age: Int
    var city: String
    var friends: Int
    var followers: [User]
    var photos: [UIImage]
    var groups: Int
    var videos: Int
    var audios: Int
    var presents: Int
    var files: Int
    var profileImage: UIImage
    
    var info: UserInfo
}

struct UserInfo {
    var status: String
    var main: [MainInfo]
    var contacts: [Contact]
    var professions: [Profession]
    var education: Education
    var presents: [Present]
    var others: [OtherInfo]
}
