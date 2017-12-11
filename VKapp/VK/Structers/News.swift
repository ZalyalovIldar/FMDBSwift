//
//  News.swift
//  VK
//
//  Created by Elina on 30/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import Foundation
import UIKit

class News: NSObject, DataProtocol {
    
    var content: String
    var image: UIImage?
    
    init (content: String, image: UIImage?) {
        self.content = content
        self.image = image
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(content, forKey: #keyPath(News.content))
        aCoder.encode(image, forKey: #keyPath(News.image))
    }
    
    required init?(coder aDecoder: NSCoder) {
        content = aDecoder.decodeObject(forKey: #keyPath(News.content)) as? String ?? ""
        image = aDecoder.decodeObject(forKey: #keyPath(News.image)) as? UIImage
    }
}
