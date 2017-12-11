//
//  ViewController.swift
//  VK
//
//  Created by Elina on 11/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UICollectionViewDelegate, UICollectionViewDataSource, DataTransferProtocol, ThreePointsButtonProtocol {
    
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var usersStatus: UILabel!
    @IBOutlet weak var ageAndCity: UILabel!
    @IBOutlet weak var userNameInToolBar: UINavigationItem!
    @IBOutlet weak var usersAvatar: UIImageView!
    @IBOutlet weak var informationButton: UIButton!
    @IBOutlet weak var photosCollectionView: UICollectionView!
    @IBOutlet weak var descriptionCollectionView: UICollectionView!
    @IBOutlet weak var photoArrow: UIButton!
    @IBOutlet weak var newsTableView: UITableView!
    
    var user: Users!
    var avatarImage = UIImage(assetName: .elina)
    var photos = [UIImage(assetName: .heart), UIImage(assetName: .heart), UIImage(assetName: .iosIcon), UIImage(assetName: .heart)]
    var buttonsTitles = ["195 друзей", "248 подписчиков", "39 групп", "18 фото", "9 видео"]
    let createdNews = [ News(content: "Река Замбези! Четвертая по протяженности река в Африке. Имеет длину 2574 км.", image: UIImage(assetName: .zambezi)), News(content: "Доброе утро :)", image: UIImage(assetName: .nature)), News(content: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", image: nil), News(content: "", image: UIImage(assetName: .zambezi))]
    var arrowButtonLabel = "фотографий"
    var space = " "
    var comma = ", "
    
    let newsRowHeight: CGFloat = 300
    let newsRowHeightWithioutPicture: CGFloat = 150
    let estimatedRowHeight: CGFloat = 100
    let followersButton = 1
    
    var newsDataBase: DBManagerProtocol!
    var news = [News]()
    var usersId: Int!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        newsDataBase = DBManager()
        profileFilling()
        setupNavigationBar()
        
        setUpButtons()
        cellsRegister()
        setupTableViewSize()
        createExistingNews()
        setupRefreshControl()
        reloadNewsData()
        
    }
    
    func setUpButtons() {
        informationButton.addTarget(self, action: #selector(informationButtonPressed), for: .touchDragEnter)
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(pullToRefresh(sender:)), for: .valueChanged)
        newsTableView.refreshControl = refreshControl
    }
    
    func pullToRefresh(sender: UIRefreshControl) {
        reloadNewsData()
        sender.endRefreshing()
    }
    
    func reloadNewsData() {
        
        news = newsDataBase.get(with: usersId)
        DispatchQueue.main.async {[weak self] in
            guard let strongSelf = self else { return }
            strongSelf.newsTableView.reloadData()
        }
    }
    
    func createExistingNews() {
        if news.isEmpty {
            for new in createdNews {
                newsDataBase.save(with: new, on: usersId)
            }
            news = newsDataBase.get(with: usersId)
        }
    }
    
    func setupTableViewSize() {
        newsTableView.estimatedRowHeight = estimatedRowHeight
        newsTableView.rowHeight = UITableViewAutomaticDimension
    }
    
    func cellsRegister() {
        let tableNib = UINib(nibName: .newsCellNibName)
        newsTableView.register(tableNib, forCellReuseIdentifier: Identifiers.newsCellIdentifier.rawValue)
        
        let collectionPhotoNib = UINib(nibName: .photosCellNibName)
        photosCollectionView.register(collectionPhotoNib, forCellWithReuseIdentifier: Identifiers.photosCellIdentifier.rawValue)
        
        let collectionDescriptionNib = UINib(nibName: .descriptionCellNibName)
        descriptionCollectionView.register(collectionDescriptionNib, forCellWithReuseIdentifier: Identifiers.descriptionCellIdentifier.rawValue)
    }
    
    func informationButtonPressed() {
        performSegue(withIdentifier: Identifiers.informationButtonIdentifier.rawValue, sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.informationButtonIdentifier.rawValue && sender != nil {
            
            let destinationTVC = segue.destination as! ProfileTableViewController
            destinationTVC.user = user
            
            if let nameAndSurname = name.text {
                destinationTVC.nameAndSurname = nameAndSurname
            }
            
            if let ageAndCity = ageAndCity.text {
                destinationTVC.ageAndCity = ageAndCity
            }
            
            if let status = usersStatus.text {
                destinationTVC.status = status
            }
            
            destinationTVC.usersPhoto = usersAvatar.image
            destinationTVC.usersNameForToolBar = user.name
            
            // Уберем текст backitem следующего контроллера

            let backItem = UIBarButtonItem()
            backItem.title = ""
            navigationItem.backBarButtonItem = backItem
            
        }
        
        if segue.identifier == Identifiers.notesIdentifier.rawValue && sender != nil {
            
            let destinationVC = segue.destination as! NotesViewController
            destinationVC.dataTransferDelegate = self
        }
        
        if segue.identifier == Identifiers.followersButtonIdentifier.rawValue && sender != nil {
            let destinationVC = segue.destination as! FollowersTableViewController
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func setupNavigationBar() {
        let navigationBarAppearace = UINavigationBar.appearance()
        
        navigationBarAppearace.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
    }
    
    func profileFilling() {
        name.text = user.name + space + user.surname
        userNameInToolBar.title = user.name
        usersAvatar.image = avatarImage
        ageAndCity.text = String(user.age) + comma + user.city
    }
    
    //MARK: UITableViewDelegate & Datasource
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.newsCellIdentifier.rawValue, for: indexPath as IndexPath) as! NewsTableViewCell
        
        if news[indexPath.row].image != nil {
            
            cell.prepare(with: (news[indexPath.row].content), picture: (news[indexPath.row].image)!, userName: user.name + space + user.surname, usersAvatar: avatarImage!)
        }
        else {
            let cellContent = news[indexPath.row].content
            cell.prepare(with: cellContent, userName: user.name + space + user.surname, usersAvatar: avatarImage!)
        }
            return cell
    }
    
    //MARK: DataTransferProtocol
    
    func didPressReturn(with text: String) {
        
        let new = News(content: text, image: nil)
        news.append(new)
        
        newsDataBase.save(with: new, on: usersId)
        
        reloadNewsData()
    }
    
    //MARK: Buttons actions
    
    @IBAction func ThreePointsButtonAction(_ sender: Any) {
        
        let actionSheetController = self.didPressThreePointsButton()
        present(actionSheetController, animated: true, completion: nil)
    }
    
    // MARK: UICollectionViewDelegate & Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let descriptionButtonsCount = 5
        
        if collectionView == photosCollectionView {
        return photos.count
        }
        if collectionView == descriptionCollectionView {
            return descriptionButtonsCount
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if collectionView == photosCollectionView {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.photosCellIdentifier.rawValue, for: indexPath) as! PhotosCollectionViewCell
        
        if let image = photos[indexPath.row] {
            cell.prepareCell(with: image)
        }
        return cell
        }
        if collectionView == descriptionCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifiers.descriptionCellIdentifier.rawValue, for: indexPath) as! DescriptionCollectionViewCell
            
            cell.prepareButton(title: buttonsTitles[indexPath.row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == descriptionCollectionView {
            if indexPath.row == followersButton {
                performSegue(withIdentifier: Identifiers.followersButtonIdentifier.rawValue, sender: nil)
            }
        }
    }
}

