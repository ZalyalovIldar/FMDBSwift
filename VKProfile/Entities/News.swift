//
//  News.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 02.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class News: NSObject, Storable {
    
    @objc var id: Int
    @objc var text: String!
    @objc var image: UIImage?
    @objc var likeCount: Int
    @objc var commentCount: Int
    @objc var respostCount: Int
    
    init(id: Int = 0, text: String, image: UIImage?, likeCount: Int, commentCount: Int, respostCount: Int) {
        self.id = id
        self.text = text
        self.image = image
        self.likeCount = likeCount
        self.commentCount = commentCount
        self.respostCount = respostCount
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let id = aDecoder.decodeInteger(forKey: #keyPath(News.id))
        guard let text = aDecoder.decodeObject(forKey: #keyPath(News.text)) as? String else { return nil }
        let image = aDecoder.decodeObject(forKey: #keyPath(News.image)) as? UIImage
        let likeCount = aDecoder.decodeInteger(forKey: #keyPath(News.likeCount))
        let commentCount = aDecoder.decodeInteger(forKey: #keyPath(News.commentCount))
        let repostsCount = aDecoder.decodeInteger(forKey: #keyPath(News.respostCount))
        
        self.init(id: id, text: text, image: image, likeCount: likeCount, commentCount: commentCount, respostCount: repostsCount)
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: #keyPath(News.id))
        coder.encode(text, forKey: #keyPath(News.text))
        coder.encode(image, forKey: #keyPath(News.image))
        coder.encode(likeCount, forKey: #keyPath(News.likeCount))
        coder.encode(commentCount, forKey: #keyPath(News.commentCount))
        coder.encode(respostCount, forKey: #keyPath(News.respostCount))
    }
    
}
