//
//  FollowersTableViewController.swift
//  MyVK
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class FollowersTableViewController: UITableViewController {

    var followers = [User]()
    let cellIdentifier = "cellFollower"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "FollowerTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followers.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! FollowerTableViewCell
        let user = followers[indexPath.row]
        cell.prepareCell(with: user)
        return cell
    }
}
