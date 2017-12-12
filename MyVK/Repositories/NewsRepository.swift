//
//  NewsRepository.swift
//  MyVK
//
//  Created by Дамир Зарипов on 30.10.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import Foundation

class NewsRepository: RepositoryProtocol {
    
    @objc private var news = [News]()
    
    init() {
        if let currectNewsData = UserDefaults.standard.data(forKey: #keyPath(NewsRepository.news)) {
            guard let currentNews = NSKeyedUnarchiver.unarchiveObject(with: currectNewsData) as? [News] else {return}
            news = currentNews
        }
    }
    
    func syncSave(with news: News) {
        self.news.append(news)
        let archiver = NSKeyedArchiver.archivedData(withRootObject: self.news)
        UserDefaults.standard.set(archiver, forKey: #keyPath(NewsRepository.news))
    }
    
    func syncSave(with news: [News]) {
        self.news += news
        let archiver = NSKeyedArchiver.archivedData(withRootObject: self.news)
        UserDefaults.standard.set(archiver, forKey: #keyPath(NewsRepository.news))
    }
    
    func asynSave(with news: News, complitionBlock: @escaping (Bool) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {
                complitionBlock(false)
                return
            }
            strongSelf.syncSave(with: news)
            complitionBlock(true)
        }
    }
    
    func syncGetAll() -> [News] {
        return news
    }
    
    func asynGetAll(complitionBlock: @escaping ([News]) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {return}
            let newsArray = strongSelf.syncGetAll()
            complitionBlock(newsArray)
        }
    }
    
    func syncSearch(by id: Int) -> News? {
        return news.first(where: { $0.id == id })
    }
    
    func asynSearch(by id: Int, complitionBlock: @escaping (News?) -> ()) {
        let operationQueue = OperationQueue()
        operationQueue.addOperation { [weak self] in
            guard let strongSelf = self else {return}
            let resultNews: News? = strongSelf.news.first(where: { $0.id == id })
            complitionBlock(resultNews)
        }
        complitionBlock(nil)
    }
    
       
}

