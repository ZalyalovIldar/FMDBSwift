

import UIKit

enum InfoType {
    case friends
    case followers
    case groups
    case photos
    case videos
    case audios
    case gifts
    case docs
}

class NewViewController: UITableViewController, DataTransferProtocol, UICollectionViewDelegate, UICollectionViewDataSource {
  
    //MARK: - Declaring variables
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameNavigationItem: UINavigationItem!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var surnameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addEntryButton: UIButton!
    @IBOutlet weak var addPhotoButton: UIButton!
    @IBOutlet weak var addPlaceButton: UIButton!
    @IBOutlet weak var infoCollectionView: UICollectionView!
    @IBOutlet weak var photoCollectionView: UICollectionView!
    var user: User!
    var photoArray = [UIImage(named: "fcrk-1"),UIImage(named: "fcrk-2"),UIImage(named: "fcrk-3"), UIImage(named: "fcrk-1"), UIImage(named: "fcrk-1"),UIImage(named: "fcrk-2"),UIImage(named: "fcrk-3"), UIImage(named: "fcrk-1")]
    var news = [News]()
    let newsTestImageArray = [UIImage(named: "fcrk-4")!, UIImage(named: "fcrk-5")!, UIImage(named: "fcrk-6")!]
    let types: [InfoType] = [.friends, .followers, .groups, .photos, .videos, .audios, .gifts, .docs]
    
    //MARK: - Constants
    
    let scrollWidth: CGFloat = 1000
    let borderWidth: CGFloat = 1
    let borderColour = UIColor.init(red:222/255.0, green:225/255.0, blue:227/255.0, alpha: 1.0).cgColor
    let navigationBarColor = UIColor.init(red: 89/255.0, green: 125/255.0, blue: 163/255.0, alpha: 1.0)
    let buttonWidth = 35
    let buttonHeight = 35
    let years = " years"
    let followersSegueIdentifier = "followersIdentifier"
    let ownInfoSegueIdentifier = "ownInfoIdentifier"
    let newsTestTextArray = ["Test1", "Test2", "Test3"]
    let newsTestLikesArray = ["10", "20", "30"]
    let newsTestCommentsArray = ["15", "25", "35"]
    let newsTestRepostsArray = ["12", "24", "36"]
    let newsTestDateArray = ["15 авг в 20:08", "15 авг в 20:15", "15 сент в 20:28", "18 дек в 20:11"]
    let newsCellIdentifier = "newsIdentifier"
    let cellNewsIdentifier = "cellNewsIdentifier"
    let cellInfoIdentifier = "infoCollectionCellIdentifier"
    let cellPhotoIdentifier = "identifierPhotoCollectionViewCell"
    let newsCellHeight: CGFloat = 290
    let newsSequeIdentifier = "createNewsIdentifier"
    let newsCellClass = "NewsTableViewCell"
    let estimatedNewsCellHeight: CGFloat = 100
    var userEmail = ""
    var currentUser: UserWithRegistration!
    var newsManager: DataManager!
    let currentUserKey = "currentUserKey"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newsManager = DataManager()
        setNavigationBarColorAndFont()
        user = createUser(with: currentUser)
        setInfo(for: user)
        roundImage(for: avatarImageView)
        changeBorder(for: addPhotoButton)
        changeBorder(for: addEntryButton)
        changeBorder(for: addPlaceButton)
        cellRegistration()
        prepareForDynamicCellSize()
        createRefreshControl()
        loadNews()
    }
    
    func prepareForDynamicCellSize() {
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = estimatedNewsCellHeight
    }
    
    //MARK: - My methods
    func roundImage(for image: UIImageView) {
        image.layer.cornerRadius = image.frame.size.width/2
        image.clipsToBounds = true
    }
    
    func changeBorder(for view: UIView) {
        view.layer.borderWidth = borderWidth
        view.layer.borderColor = borderColour
    }
    
    func loadNews() {
        let currentUserId = UserDefaults.standard.integer(forKey: currentUserKey)
        guard let newsDB = newsManager.getNewsForUser(by: currentUserId) else { return }
        news = newsDB
    }
    
    //MARK: - Refresh
    
    private func createRefreshControl() {
        refreshControl = UIRefreshControl()
        refreshControl?.attributedTitle = NSAttributedString(string: "Pull to refresh")
        refreshControl?.addTarget(self, action: #selector(refresh), for: .valueChanged)
    }
    
    @objc private func refresh() {
        loadNews()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }
    
    //MARK: - Create User
    
    func createUser(with userWithRegistartion: UserWithRegistration) -> User {
        var user = UserInfo.createInfo(with: userWithRegistartion)
        for _ in 0 ..< 10 {
            user.followers.append(UserInfo.createInfo(with: userWithRegistartion))
        }
        return user 
    }
    
    func setInfo(for user: User) {
        avatarImageView.image = user.avatar
        nameNavigationItem.title = user.name
        nameLabel.text = user.name
        surnameLabel.text = user.surname
        ageLabel.text = String(user.age) + years
        cityLabel.text = user.city
    }
    
    //MARK: - Cells Registration
    
    func cellRegistration() {
        let newsCellNib = UINib(nibName: newsCellClass, bundle: nil)
        tableView.register(newsCellNib, forCellReuseIdentifier: cellNewsIdentifier)
        
        let infoCollectionViewCellNib = UINib(nibName: "InfoCollectionViewCell", bundle: nil)
        infoCollectionView.register(infoCollectionViewCellNib, forCellWithReuseIdentifier: cellInfoIdentifier)
        
        let photoCollectionViewCellNib = UINib(nibName: "PhotoCollectionViewCell", bundle: nil)
        photoCollectionView.register(photoCollectionViewCellNib, forCellWithReuseIdentifier: cellPhotoIdentifier)
    }
    
    //MARK: - Table View Methods
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return news.count
        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellNewsIdentifier) as! NewsTableViewCell
        let reverseNews: [News] = news.reversed()
        let newsModel = reverseNews[indexPath.row]
        cell.prepare(with: newsModel, and: user)
        return cell
    }
        
    //MARK: - Methods associated with Navigation Bar
    
    @IBAction func threeDotButton(_ sender: Any) {
        present(alertForShowStandartFunc(), animated: true, completion: nil)
    }
    
    func setNavigationBarColorAndFont(){
        navigationController?.navigationBar.barTintColor = navigationBarColor
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    //MARK: - DataTransferProtocol
    
    func didPressDone(with note: String) {
        
        let newNews = News (date: newsTestDateArray[Int(arc4random_uniform((UInt32(newsTestDateArray.count))))],
                            text: note,
                            image: newsTestImageArray[Int(arc4random_uniform(UInt32(newsTestImageArray.count)))],
                            numberOfLikes: newsTestLikesArray[Int(arc4random_uniform(UInt32(newsTestLikesArray.count)))],
                            numberOfComments: newsTestCommentsArray[Int(arc4random_uniform(UInt32(newsTestCommentsArray.count)))],
                            numberOfReposts: newsTestRepostsArray[Int(arc4random_uniform(UInt32(newsTestRepostsArray.count)))],
                           idUser: UserDefaults.standard.integer(forKey: currentUserKey))

        newsManager.asynSave(with: newNews) { [weak self] (isSaved) in
            guard let strongSelf = self else {return}
            if (isSaved) {
                strongSelf.news.append(newNews)
                DispatchQueue.main.async {
                    strongSelf.tableView.reloadData()
                }
            }
        }
    }
    
    //MARK: - Test search
    
    func testSynhSearch() {
        if let recievedNews = newsManager.syncSearch(by: 1, type: News.self) {
            print("\(String(describing: recievedNews.text))")
        }
    }
    
    func testAsynSearch() {
        newsManager.asynSearch(by: 1, type: News.self) { (recievedNews) in
            print("\(String(describing: recievedNews?.text))")
        }
    }
    
    //MARK: - Collection View Methods

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {

        if collectionView == infoCollectionView {
            return types.count
        }
        
        if collectionView == photoCollectionView {
            return photoArray.count
        }
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

        if collectionView == infoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier:  cellInfoIdentifier, for: indexPath) as! InfoCollectionViewCell
            cell.prepareCell(with: types[indexPath.row])

            return cell
        }
        
        if collectionView == photoCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellPhotoIdentifier, for: indexPath) as! PhotoCollectionViewCell
            cell.prepareCell(with: photoArray[indexPath.row]!)
            
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if indexPath.row == types.index(of: .followers) {
            performSegue(withIdentifier: followersSegueIdentifier, sender: nil)
        }
    }
  
    // MARK: - Prepare methods
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
        if segue.identifier == followersSegueIdentifier {
            let followersVC = segue.destination as! FollowersTableViewController
            followersVC.followers = user.followers
        }
        
        if segue.identifier == ownInfoSegueIdentifier {
            let ownInfoVC = segue.destination as! OwnInfoTableViewController
            ownInfoVC.nameUser = user.name
            ownInfoVC.surnameUser = user.surname
            ownInfoVC.avatarUser = user.avatar
            ownInfoVC.ageUser = String(user.age) + years
            ownInfoVC.cityUser = user.city
        }
        if segue.identifier == newsSequeIdentifier {
            let controller = segue.destination as! CreateNewsViewController
            controller.dataTransferDelagete = self
        }
    }
    
    
}
