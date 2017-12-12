//
//  News.swift
//  MyVK
//
//  Created by itisioslab on 11.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class News: NSObject, NSCoding, HasIdProtocol, DataProtocol {
    
    @objc var id: Int
    @objc let date: String
    @objc let text: String?
    @objc let image: UIImage?
    @objc let numberOfLikes: String
    @objc let numberOfComments: String
    @objc let numberOfReposts: String
    @objc let idUser: Int
    
    init(id: Int = 0, date: String, text: String?, image: UIImage?, numberOfLikes: String, numberOfComments: String, numberOfReposts: String, idUser: Int) {
        self.id = 0
        self.date = date
        self.text = text
        self.image = image
        self.numberOfLikes = numberOfLikes
        self.numberOfComments = numberOfComments
        self.numberOfReposts = numberOfReposts
        self.idUser = idUser
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(id, forKey: #keyPath(News.id))
        aCoder.encode(date, forKey: #keyPath(News.date))
        aCoder.encode(text, forKey: #keyPath(News.text))
        aCoder.encode(image, forKey: #keyPath(News.image))
        aCoder.encode(numberOfLikes, forKey: #keyPath(News.numberOfLikes))
        aCoder.encode(numberOfComments, forKey: #keyPath(News.numberOfComments))
        aCoder.encode(numberOfReposts, forKey: #keyPath(News.numberOfReposts))
        aCoder.encode(idUser, forKey: #keyPath(News.idUser))
    }
   
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: #keyPath(News.id))
        guard let date = aDecoder.decodeObject(forKey: #keyPath(News.date)) as? String else {return nil}
        let text = aDecoder.decodeObject(forKey: #keyPath(News.text)) as? String
        let image = aDecoder.decodeObject(forKey: #keyPath(News.image)) as? UIImage
        guard let numberOfLikes = aDecoder.decodeObject(forKey: #keyPath(News.numberOfLikes)) as? String else {return nil}
        guard let numberOfComments = aDecoder.decodeObject(forKey: #keyPath(News.numberOfComments)) as? String else {return nil}
        guard let numberOfReposts = aDecoder.decodeObject(forKey: #keyPath(News.numberOfReposts)) as? String else {
            return nil}
        let idUser = aDecoder.decodeInteger(forKey: #keyPath(News.idUser))
            
        self.init(
            id: id,
            date: date,
            text: text,
            image: image,
            numberOfLikes: numberOfLikes,
            numberOfComments: numberOfComments,
            numberOfReposts: numberOfReposts,
            idUser: idUser
        )
    }
    
    
}
