
//
//  FollowersTableViewController.swift
//  VK
//
//  Created by Elina on 18/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class FollowersTableViewController: UITableViewController {
    
    fileprivate var rowAtHeight: CGFloat = 100
    fileprivate var iosIconImage = UIImage(assetName: .iosIcon)
    
    var users: [Users] = [Users(name: "Элина", surname: "Батырова", gender: "жен", email: "Elina" , phoneNumber: "89625692459", age: String(19), city: "Казань" , password: "Elina"), Users(name: "Эльвира", surname: "Батырова", gender:"жен" , email: "Elvira" , phoneNumber: "89764567890", age: String(21), city: "Казань", password: "Elvira"), Users(name: "Айгуль", surname: "Ризатдинова", gender: "жен", email: "Aigul", phoneNumber: "89765678756", age: String(19), city: "Казань", password: "Aigul")]
    
    var avatar = UIImage(assetName: .elina)
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        setupRefreshControl()
        setupNavigationBar()
        
        cellsRegister()
    }
    
    func cellsRegister() {
        let nib = UINib(nibName: .followersCellNibName)
        tableView.register(nib, forCellReuseIdentifier: Identifiers.cellIdentifier.rawValue)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func refreshTableView(sender: UIRefreshControl) {
        
        tableView.reloadData()
        
        sender.endRefreshing()
    }
    

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return users.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.cellIdentifier.rawValue, for: indexPath) as! CustomFollowersTableViewCell
        
        let model = users[indexPath.row]
        
        cell.prepareCell(with: model)
        
        return cell
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowAtHeight
    }
}

