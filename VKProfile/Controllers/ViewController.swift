//
//  ViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 11.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class ViewController: UITableViewController, CreateNewsDelegate, UICollectionViewDelegate, UICollectionViewDataSource {


    @IBOutlet weak var infoButtonsCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    @IBOutlet var menuButtons: [UIButton]!
    @IBOutlet weak var avatarImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var onlineStatusLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var photosButton: UIButton!
    @IBOutlet weak var buttonsView: UIView!
    
    var count = 0
    var user: User!
    var infoButtons = [UIButton]()
    var indentionButtonConstraints = [NSLayoutConstraint]()
    var imageViews = [UIImageView]()
    var indentionImageViewConstraints = [NSLayoutConstraint]()
    let defaultIndention: CGFloat = 8
    let photo = "фото"
    let audio = "аудио"
    let video = "видео"
    let seperator = ","
    
    let infoIdentifierSegue = "infoSegue"
    let followersIdentifierSegue = "followersSegue"
    let createNewsIdentifierSegue = "createNewsSegue"
    let detailsNewsSegue = "detailsNewsSegue"
    
    let infoButtonsCellIdentefier = "infoButtonCell"
    let photoCellIdentefier = "photoCell"
    let newsCellIdentefier = "newsCell"
    var news = [News]()
    
    let buttonCounts = 8
    let fontName = "Arial"
    
    //Buttons section
    let friendsButton = 0
    let followersButton = 1
    let groupsButton = 2
    let albumButton = 3
    let videosButton = 4
    let audiosButton = 5
    let presentsButton = 6
    let filesButton = 7
    let createNewsButton = 1
    let takePhotoButton = 0
    
    let imageWidth: CGFloat = 129
    let imageHeight: CGFloat = 97
    
    var userVK: UserVK!
    var repository: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        user = generateUser()
        repository = BaseRepository()
        
        infoButtonsCollectionView.delegate = self
        prepareCollectionViews()
        prepareTableView()
        registerCell()
        setLabels()
        createNews()
        loadNews()
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    //MARK: - initialize methods
    
    private func registerCell() {
        let nib = UINib(nibName: "NewsTableViewCell", bundle: nil)
        self.tableView.register(nib, forCellReuseIdentifier: newsCellIdentefier)
        
        let infoButtonNib = UINib(nibName: "InfoButtonCollectionViewCell", bundle: nil)
        infoButtonsCollectionView.register(infoButtonNib, forCellWithReuseIdentifier: infoButtonsCellIdentefier)
        
        let photoNib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photoCollectionView.register(photoNib, forCellWithReuseIdentifier: photoCellIdentefier)
    }
    
    private func prepareCollectionViews() {
        if let infoFlowLayout = infoButtonsCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            infoFlowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
        
        if let photoFlowLayout = photoCollectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            photoFlowLayout.estimatedItemSize = CGSize(width: 1, height: 1)
        }
    }
    
    private func prepareTableView() {
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 50
        
        refreshControl = UIRefreshControl()
        if let refreshControl = refreshControl {
            refreshControl.attributedTitle = NSAttributedString(string: "Pull to refresh")
            refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        }
    }
    
    @objc private func refresh() {
        news = repository.syncGetAll()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    private func createNews() {
        let demoNewsCreatedKey = "demoNewsCreated"
        guard !UserDefaults.standard.bool(forKey: demoNewsCreatedKey) else { return }
        
        let news1 = News(text: newsText1, image: user.photos[0], likeCount: 72, commentCount: 8, respostCount: 16)
        let news2 = News(text: newsText2, image: user.photos[1], likeCount: 5, commentCount: 17, respostCount: 48)
        let news3 = News(text: newsText3, image: user.photos[2], likeCount: 77, commentCount: 39, respostCount: 2)
        
        repository.syncSave(with: news1)
        repository.syncSave(with: news2)
        repository.syncSave(with: news3)
        
        UserDefaults.standard.set(true, forKey: demoNewsCreatedKey)
    }
    
    private func loadNews() {
        news = repository.syncGetAll()
    }
    
    override func viewDidLayoutSubviews() {
        createStyles()
    }
    
    private func setContentSize(with scrollView: UIScrollView, elements: [UIView], indention: CGFloat) {
        let heightContent = scrollView.frame.height
        var widthContent: CGFloat = 0
        
        elements.forEach { widthContent += $0.frame.width + indention }
        scrollView.contentSize = CGSize(width: widthContent, height: heightContent)
    }
    
    private func createStyles() {
        let defaultMarginX:CGFloat = 10
        
        infoButtonsCollectionView.createBorders(on: .bottom, marginX: defaultMarginX)
        infoButtonsCollectionView.createBorders(on: .top, marginX: defaultMarginX)
        buttonsView.createBorders(on: .top, marginX: defaultMarginX)
        menuButtons[createNewsButton].createBorders(on: .right, marginX: defaultMarginX)
        menuButtons[takePhotoButton].createBorders(on: .right, marginX: defaultMarginX)
        
        self.navigationController?.navigationBar.barTintColor = UIColor(rgb: 0x3180d6)
        self.navigationController?.navigationBar.barStyle = UIBarStyle.black
        self.navigationController?.navigationBar.tintColor = UIColor.white
        
        avatarImage.roundCorners()
        self.view.layoutIfNeeded()
    }
    
    private func generateUser() -> User {
        var user = UserInfoData.generateUser()
        for _ in 0 ..< 25 {
            user.followers.append(UserInfoData.generateUser())
        }
        user.followers[0].onlineStatus = .computer
        
        user.name = userVK.name
        user.surname = userVK.surname
        user.age = userVK.age
        user.city = userVK.city
        
        return user
    }
    
    private func setLabels() {
        self.title = user.name
        nameLabel.text = user.name + " " + user.surname
        onlineStatusLabel.text = user.onlineStatus.rawValue
        
        ageLabel.text = String(user.age)
        yearsLabel.text = EndingWord.getCorrectEnding(with: user.age, and: DeclinationWord.age) + seperator
        cityLabel.text = user.city
        
        let photoCount = user.photos.count
        let photoTitle = EndingWord.getCorrectEnding(with: photoCount, and: DeclinationWord.photograph)
        photosButton.setTitle("\(photoCount) " + photoTitle, for: .normal)
        
        avatarImage.image = user.profileImage
    }
    
    func createNews(from newsData: News) {
        news.append(newsData)
        tableView.reloadData()
        repository.syncSave(with: newsData)
    }
    
    @IBAction func onMoreClick(_ sender: UIBarButtonItem) {
        present(MoreProfileAlert.getAlert(), animated: true, completion: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if (segue.identifier == followersIdentifierSegue) {
            let followerTVC = segue.destination as! FollowersTableViewController
            followerTVC.followers = user.followers
        } else if (segue.identifier == infoIdentifierSegue) {
            let infoTVC = segue.destination as! InfoTableViewController
            infoTVC.user = user
        } else if (segue.identifier == createNewsIdentifierSegue) {
            let noteVC = segue.destination as! NoteViewController
            noteVC.createNewsDelegate = self
        } else if (segue.identifier == detailsNewsSegue) {
            let detailsNewsVC = segue.destination as! DetailsNewsViewController
            detailsNewsVC.newsID = sender as! Int
        }
    }
    
    //MARK: - TableView methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: newsCellIdentefier, for: indexPath) as! NewsTableViewCell
        
        let news = self.news.reversed()[indexPath.row]
        cell.prepareCell(with: news, from: user, number: indexPath.row)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let pickedNews = news.reversed()[indexPath.row]
        performSegue(withIdentifier: detailsNewsSegue, sender: pickedNews.id)
    }
    
    //MARK: - CollectionView methods
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let buttonsCount = 8
        if collectionView == infoButtonsCollectionView {
            return buttonsCount
        } else if collectionView == photoCollectionView {
            return user.photos.count
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let row = indexPath.row
        
        if collectionView == infoButtonsCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: infoButtonsCellIdentefier, for: indexPath) as! InfoButtonCollectionViewCell
            cell.prepareCell(with: InformationType.types[row], and: user)
            return cell
        } else if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: photoCellIdentefier, for: indexPath) as! PhotoCollectionViewCell
            cell.prepareCell(with: user.photos[row])
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let followersButton = 1
        
        if indexPath.row == followersButton {
            performSegue(withIdentifier: followersIdentifierSegue, sender: nil)
        }
    }
    
}










