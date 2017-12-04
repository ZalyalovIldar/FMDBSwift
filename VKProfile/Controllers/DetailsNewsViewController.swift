//
//  DetailsNewsViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 27.10.2017.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class DetailsNewsViewController: UIViewController {

    @IBOutlet weak var textLabel: UILabel!
    @IBOutlet weak var photoImageView: UIImageView!
    
    var newsID: Int!
    var repository: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = BaseRepository()
        
        repository.asyncSearch(id: newsID, type: News.self) { [weak self] (resultNews) in
            guard let selfStrong = self else { return }
            if let news = resultNews {
                DispatchQueue.main.async {
                    selfStrong.textLabel.text = news.text
                    if let newsImage = news.image {
                        selfStrong.photoImageView.image = newsImage
                    } else {
                        selfStrong.photoImageView.isHidden = true
                    }
                }
            }
        }
    }
}
