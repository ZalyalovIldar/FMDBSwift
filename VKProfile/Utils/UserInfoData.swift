//
//  UserInfoData.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 17.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class UserInfoData {
    
    private static let names = ["Феликс", "Велислав", "Леонард", "Флорин", "Милонег", "Юджин"]
    private static let surnames = ["Трофимов", "Шилов", "Алексеев", "Гончарук", "Сидоров", "Горбачев"]
    private static let cities = ["Кумертау", "Павловск", "Дубна", "Осташков", "Минеральные Воды", "Благовещенск"]
    private static let photos = [#imageLiteral(resourceName: "album1"), #imageLiteral(resourceName: "album2"), #imageLiteral(resourceName: "album3"), #imageLiteral(resourceName: "album4"), #imageLiteral(resourceName: "album5"), #imageLiteral(resourceName: "album6")]
    private static let profilePhotos = [#imageLiteral(resourceName: "avatar1"), #imageLiteral(resourceName: "avatar2"), #imageLiteral(resourceName: "avatar3"), #imageLiteral(resourceName: "avatar4"), #imageLiteral(resourceName: "avatar5"), #imageLiteral(resourceName: "avatar6")]
    
    private static let statuses = ["I ❤️ swift programming", "I ❤️ java programming", "I ❤️ Android programming", "I ❤️ iOS programming", "I ❤️ ITIS", "I ❤️ learn programming", ""]
    private static let universities = ["КФУ", "Казанский национальный исследовательский технологический университет", "Казанский государственный медицинский университет", "Казанский государственный архитектурно-строительный университет", "МКГЭУ", "Казанский государственный аграрный университет"]
    private static let twitters = ["old_dn", "fact_yes", "rrrandomize", "spasisisohranis", "EmilyGasparyan", "pusildameow"]
    private static let instagrams = ["burmistrov.d", "iconaccidental", "shablich_ann", "qzmeraks", "zen", "hammer"]
    private static let skypes = ["jazzy", "admiral", "vulture", "dino", "sizzle", "fancy"]
    private static let directions = ["Информационные технологии", "Прикладная математика и информатика", "Прикладная математика и информатика", "Физика", "Экономика", "Бухгалтерский учет, анализ и аудит"]
    private static let schools = ["Международная школа Казани", "Лицей № 177", "Гимназия №102 им. М.С. Устиновой", "Гимназия № 122 имени Ж.А. Зайцевой", "Средняя общеобразовательная школа №165 с углубленным изучением английского языка г.Казани", "Гимназия 19"]
    private static let schoolDirections = ["физ-мат", "хим-био", "инфо-тех", "инфо-мат", "лингвистическое", "культурное"]
    private static let companies = ["Лаконикс", "Икс-Игрек-Зет Автоматизация", "КомЛайн", "АБАК", "ЦИФРОВЫЕ ТЕХНОЛОГИИ", "Ситиком"]
    private static let professions = ["BIM-менеджер-проектировщик", "BI разработчик", "Digital-стратег", "ERP-консультант", "GR-менеджер", "HR-специалист"]
    
    static func generateUser() -> User {
        let maxRandomValue: UInt32 = 1000
        
        let name = names[Int(arc4random_uniform(UInt32(names.count - 1)))]
        let surname = surnames[Int(arc4random_uniform(UInt32(surnames.count - 1)))]
        let online = OnlineStatus.statuses[Int(arc4random_uniform(2))]
        let age = Int(arc4random_uniform(99) + 1)
        let city = cities[Int(arc4random_uniform(UInt32(cities.count - 1)))]
        let friends = Int(arc4random_uniform(maxRandomValue))
        var photos = [UIImage]()
        for _ in 0 ..< 4 {
            photos.append(self.photos[Int(arc4random_uniform(UInt32(self.photos.count - 1)))])
        }
        let groups = Int(arc4random_uniform(maxRandomValue))
        let videos = Int(arc4random_uniform(maxRandomValue))
        let audios = Int(arc4random_uniform(maxRandomValue))
        let presents = Int(arc4random_uniform(maxRandomValue))
        let files = Int(arc4random_uniform(maxRandomValue))
        let avatar = profilePhotos[Int(arc4random_uniform(UInt32(profilePhotos.count - 1)))]
        
        let info = generateUserInfo(with: age)
        
        return User(name: name, surname: surname, onlineStatus: online, age: age, city: city, friends: friends, followers: [User](), photos: photos, groups: groups, videos: videos, audios: audios, presents: presents, files: files, profileImage: avatar, info: info)
    }
    
    static func generateUserInfo(with age: Int) -> UserInfo {
        let status = randomString(from: statuses)
        
        var mainInformations = [MainInfo]()
        mainInformations.append(MainInfo(type:.birthday, info: generateBirthdayDate(with: age)))
        mainInformations.append(MainInfo(type: .hometown, info: randomString(from: cities)))
        mainInformations.append(MainInfo(type: .placeOfStudy, info: universities[Int(arc4random_uniform(UInt32(universities.count - 1)))]))
        let familyStatuses = FamilyStatus.statuses
        mainInformations.append(MainInfo(type: .familyStatus, info: familyStatuses[Int(arc4random_uniform(UInt32(familyStatuses.count - 1)))].rawValue))
        mainInformations.append(MainInfo(type: .parents, info: "\(randomString(from: names)) \(randomString(from: surnames))"))
        mainInformations.append(MainInfo(type: .siblings, info: "\(randomString(from: names)) \(randomString(from: surnames))"))
        
        var contacts = [Contact]()
        contacts.append(Contact(icon: #imageLiteral(resourceName: "phone"), type: .phone, info: generatePhoneNumber()))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "home"), type: .city, info: randomString(from: cities)))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "twitter"), type: .twitter, info: randomString(from: twitters)))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "instagram"), type: .instagram, info: randomString(from: instagrams)))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "skype"), type: .skype, info: randomString(from: skypes)))
        contacts.append(Contact(icon: #imageLiteral(resourceName: "vk"), type: .vk, info: generateID()))
        
        var professions = [Profession]()
        let randomYear = generateYear(from: 2000)
        if let startDate = date(with: randomYear) {
            if let endDate = date(with: 2017) {
                professions.append(Profession(name: randomString(from: self.professions), company: randomString(from: companies), city: randomString(from: cities), startDate: startDate, endDate: endDate))
                professions.append(Profession(name: randomString(from: self.professions), company: randomString(from: companies), city: randomString(from: cities), startDate: endDate, endDate: nil))
            }
        }
        
        var school: School!
        let ageStartSchool = 7
        let studyingDurationYear = 11
        let startSchoolYear = Calendar.current.component(.year, from: Date()) - age + ageStartSchool
        let endSchoolYear = startSchoolYear + studyingDurationYear
        if let startDateSchool = date(with: startSchoolYear) {
            if let endDateSchool = date(with: endSchoolYear) {
                school = School(name: randomString(from: schools), city: randomString(from: cities), startDate: startDateSchool, endDate: endDateSchool, direction: randomString(from: schoolDirections))
            }
        }
        let institute = Institute(name: randomString(from: universities), direction: randomString(from: directions), department: DepartmentType.departments[Int(arc4random_uniform(UInt32(DepartmentType.departments.count - 1)))], typeStudying: StudyingType.types[Int(arc4random_uniform(UInt32(StudyingType.types.count - 1)))])
        let education = Education(institutes: [institute], schools: [school])
        
        var presents = [Present]()
        let presentsCount = 5
        for _ in 1 ..< presentsCount {
            if let presentImage = UIImage(named: "present\(Int(arc4random_uniform(UInt32(presentsCount)) + 1))") {
                presents.append(Present(image: presentImage, message: ""))
            }
        }
        
        var others = [OtherInfo]()
        others.append(OtherInfo(type: .interestingPages, count: Int.randomDigit(bound: 1000)))
        others.append(OtherInfo(type: .notes, count: Int.randomDigit(bound: 1000)))
        others.append(OtherInfo(type: .documents, count: Int.randomDigit(bound: 1000)))
        
        return UserInfo(status: status, main: mainInformations, contacts: contacts, professions: professions, education: education, presents: presents, others: others)
    }
    
    private static func date(with year: Int) -> Date? {
        var dateComponents = DateComponents()
        dateComponents.year = year
        return Calendar.current.date(from: dateComponents)
    }
}

extension Int {
    static func randomDigit(bound: Int) -> Int {
        return Int(arc4random_uniform(UInt32(bound)))
    }
}

//generators
extension UserInfoData {
    private static func generateBirthdayDate(with age: Int) -> String {
        let monthCount: UInt32 = 11
        let dayCount: UInt32 = 29
        let locale = "ru"
        
        var dateComponents = DateComponents()
        let today = Date()
        let currentYear = Calendar.current.component(.year, from: today)
        
        dateComponents.year = currentYear - age
        dateComponents.month = Int(arc4random_uniform(monthCount) + 1)
        dateComponents.day = Int(arc4random_uniform(dayCount) + 1)
        
        if let birthdayDate = Calendar.current.date(from: dateComponents) {
            let dateFormat = "d MMM yyyy"
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = dateFormat
            dateFormatter.locale = Locale.init(identifier: locale)
            
            return dateFormatter.string(from: birthdayDate)
        }
        return "null"
    }
    
    private static func randomString(from array: [String]) -> String {
        return array[Int(arc4random_uniform(UInt32(array.count - 1)))]
    }
    
    private static func generateYear(from startYear: Int) -> Int {
        let currentYear = Calendar.current.component(.year, from: Date())
        
        let randomYear = Int(arc4random_uniform(UInt32(currentYear - startYear))) + startYear
        return randomYear
    }
    
    private static func generatePhoneNumber() -> String {
        let seperator = "-"
        let digitsCount: UInt32 = 9
        var phoneNumber = "+7-"
        
        for _ in 0 ..< 2 {
            for _ in 0 ..< 3 {
                phoneNumber.append(String(arc4random_uniform(digitsCount)))
            }
            phoneNumber.append(seperator)
        }
        
        for _ in 0 ..< 2 {
            for _ in 0 ..< 2 {
                phoneNumber.append(String(arc4random_uniform(digitsCount)))
            }
            phoneNumber.append(seperator)
        }
        phoneNumber.removeLast()
        return phoneNumber
    }
    
    private static func generateID() -> String {
        let lengthID = 8
        let digitsCount: UInt32 = 9
        var ID = "id"
        for _ in 0 ..< lengthID {
            ID.append(String(arc4random_uniform(digitsCount)))
        }
        return ID
    }
}
