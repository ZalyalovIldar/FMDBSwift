//
//  ViewController.swift
//  Informantion&Followers
//
//  Created by itisioslab on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var followersButton: UIButton!
    @IBOutlet weak var avatarUIImage: UIImageView!
    
    let barNavigationBackGroundImage = #imageLiteral(resourceName: "bar-navigation-background-image")
    var user: User!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        changeBackgroundNavagation()
        user = createUser()
        setInfo(for: user)
    }
    
    func changeBackgroundNavagation() {
        navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "bar-navigation-background-image"), for: .default)
    }
    
    func createUser() -> User {
        var user = UserInfo.createInfo()
        for _ in 0 ..< 10 {
            user.followers.append(UserInfo.createInfo())
        }
        return user
    }
    
    func setInfo(for user: User) {
        avatarUIImage.image = user.avatar
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let followersInfo = segue.destination as! FollowersTableViewController
        followersInfo.followers = user.followers
    }
    
    @IBAction func refresh(_ sender: Any) {
        user = createUser()
        setInfo(for: user)
    }
}

