//
//  OwnInfoTableViewController.swift
//  MyVK
//
//  Created by Дамир Зарипов on 22.09.17.
//  Copyright © 2017 itisioslab. All rights reserved.
//

import UIKit

class OwnInfoTableViewController: UITableViewController {
    
    var nameUser: String = ""
    var surnameUser: String = ""
    var avatarUser: UIImage? = nil
    var cityUser: String = ""
    var ageUser: String = ""
    let statusCellIdentifier = "statusCellIdentifier"
    let basicCellIdentifier = "basicCellIdentifier"
    let contatsCellIdentifier = "contatsCellIdentifier"
    let carierCellIdentifier = "carierCellIdentifier"
    let educationCellIdentifier = "educationCellIdentifier"
    let presentsCellIdentifier = "presentsCellIdentifier"
    let filesCellIdentifier = "filesCellIdentifier"
    var items: [InfoViewModelItem] = []
    var statusArray = ["Рубин чемпик", "Чемпик ли Рубин?", "Ya ne pishy po russki"]
    var basicInfoTitleArray = ["День рождения", "Место работы", "Семейное положение", "Языки", "Родители"]
    var basicInfoSubtitleArry = [ ["17 июня 1998", "24 января 2002"],
                                 ["Рубин", "Ростов"],
                                 ["Все hard", "Есть девушка, которой ставлю лайки"],
                                 ["Русский, Spain", "Английский, Татарча"],
                                 ["Курбан Бердыев, Маша", "Курбан Бердыев, Паша"] ]
    var contactArray = [ ["89178823292;;", "89189929222;;"],
                         ["Мадрид", "Казань"],
                         ["rubin_player", "rubin_golkiper"] ]
    var contactImageArray = [UIImage(named: "icon-info-phone")!, UIImage(named: "icon-info-home")!, UIImage(named: "icon-info-vk")!]
    var carierCompanyArray = ["Рубин", "Ростов"]
    var carierLocationAndPeriodArray = ["Казань, 2003-2015", "Мадрид, 2015-20018"]
    var carierPositionArray = ["Подавал навесы и к столу", "Разрезал тортики на др"]
    var carierLogoesCompany = [UIImage(named: "icon-info-phone")!, UIImage(named: "icon-info-home")!, UIImage(named: "icon-info-vk")!]
    let educationTypeArray = ["Вуз", "Школа"]
    let educationNameArray = [ ["КФУ", "МГУ", "ПТУ"],
                               ["It-лицей", "16 школа"] ]
    let presentsNumberArray = ["22 подарков", "24 подарок", "11 подарков"]
    let filesInfoTitleArray = ["Интересные страницы", "Заметки", "Документы"]
    let filesInfoCountArray = [["12", "43", "42"],
                              ["13", "49", "76"],
                              ["43", "97", "22"]]
    let presents = [UIImage(named: "present-1")!, UIImage(named: "present-2")!, UIImage(named: "present-3")!, UIImage(named: "present-1")!, UIImage(named: "present-2")!, UIImage(named: "present-3")!]
    let basicInfoCellHeight: CGFloat = 50
    let contactsCellHeight: CGFloat = 40
    let carierCellHeight: CGFloat = 80
    let presentsCellHeight: CGFloat = 120
    let defaultCellHeight: CGFloat = 44
    let rightBarButtonImage = UIImage(named: "icon-points")
    let rightBarButtonFrame = CGRect(x: 0, y: 0, width: 30, height: 30)
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLable: UILabel!
    @IBOutlet weak var surnameLable: UILabel!
    @IBOutlet weak var ageLable: UILabel!
    @IBOutlet weak var cityLable: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setInfo()
        createStatus()
        createBasicInfo()
        createContacts()
        createCarier()
        createEdicational()
        createPresents()
        createFiles()
        registrateCell()
        setupRefreshControl()
        setRightBarButtonImage()
    }

    //MARK: - Methods associated with Navigation Bar
    func setRightBarButtonImage() {
        let btn1 = UIButton(type: .custom)
        btn1.addTarget(self, action: #selector(threeDotButtonPressed), for: .touchUpInside)
        btn1.setImage(rightBarButtonImage, for: .normal)
        btn1.frame = rightBarButtonFrame
        let item1 = UIBarButtonItem(customView: btn1)
        navigationItem.setRightBarButton(item1, animated: true)
    }
    
    @objc func threeDotButtonPressed() {
        present(alertForShowStandartFunc(), animated: true, completion: nil)
    }
    
    func createStatus() {
        let status = InfoViewModelStatusItem(status: "\(statusArray[Int(arc4random_uniform(UInt32(statusArray.count)))])")
        items.append(status)
    }
    
    func setInfo() {
        nameLable.text = nameUser
        surnameLable.text = surnameUser
        avatarImageView.image = avatarUser
        cityLable.text = cityUser
        ageLable.text = ageUser
        navigationItem.title = nameUser
    }
    
    func registrateCell() {
        let statusCellNib = UINib(nibName: "StatusTableViewCell", bundle: nil)
        tableView.register(statusCellNib, forCellReuseIdentifier: statusCellIdentifier)
        let basicInfoCellNib = UINib(nibName: "BasicInfoTableViewCell", bundle: nil)
        tableView.register(basicInfoCellNib, forCellReuseIdentifier: basicCellIdentifier)
        let contactsCellNib = UINib(nibName: "ContactsTableViewCell", bundle: nil)
        tableView.register(contactsCellNib, forCellReuseIdentifier: contatsCellIdentifier)
        let carierCellNib = UINib(nibName: "CarierTableViewCell", bundle: nil)
        tableView.register(carierCellNib, forCellReuseIdentifier: carierCellIdentifier)
        let educationCellNib = UINib(nibName: "EducationTableViewCell", bundle: nil)
        tableView.register(educationCellNib, forCellReuseIdentifier: educationCellIdentifier)
        let presentsCellNib = UINib(nibName: "PresentsTableViewCell", bundle: nil)
        tableView.register(presentsCellNib, forCellReuseIdentifier: presentsCellIdentifier)
        let filesCellNib = UINib(nibName: "FilesTableViewCell", bundle: nil)
        tableView.register(filesCellNib, forCellReuseIdentifier: filesCellIdentifier)
        
    }
    
    func setupRefreshControl() {
        refreshControl?.addTarget(self, action: #selector(OwnInfoTableViewController.handleRefresh(refreshControl:)), for: UIControlEvents.valueChanged)
    }
    
    func createBasicInfo() {
        var basicInformations = [BasicInfo]()
        for i in 0 ..< 5 {
            let basicInfo = BasicInfo(title: "\(basicInfoTitleArray[i])",
                info: "\(basicInfoSubtitleArry[i][Int(arc4random_uniform(UInt32( basicInfoSubtitleArry[i].count)))])")
            basicInformations.append(basicInfo)
        }
        items.append(InfoViewModelBasicInfoItem(basicInfo: basicInformations))
    }
    
    func createContacts() {
        var contactsInformation = [Contacts]()
        for i in 0 ..< 3 {
            let contactInfo = Contacts(image: contactImageArray[i], contact: "\(contactArray[i][Int(arc4random_uniform(UInt32(contactArray[i].count)))])")
            contactsInformation.append(contactInfo)
        }
        items.append(InfoVIewModelContactsItem(contacts: contactsInformation))
    }
    
    
    func createCarier() {
        let carierInfo = InfoViewModelCarierItem(company: "\(carierCompanyArray[Int(arc4random_uniform(UInt32(carierCompanyArray.count)))])", locationAndPeriod: "\(carierLocationAndPeriodArray[Int(arc4random_uniform(UInt32(carierLocationAndPeriodArray.count)))])", position: "\(carierPositionArray[Int(arc4random_uniform(UInt32(carierPositionArray.count)))])")
        items.append(carierInfo)
    }
    
    func createEdicational() {
        var educationInformation = [Education]()
        for i in 0 ..< 2 {
            let educationalInfo = Education(type: "\(educationTypeArray[i])", name: "\(educationNameArray[i][Int(arc4random_uniform(UInt32(educationNameArray.count)))])")
            educationInformation.append(educationalInfo)
        }
        items.append(InfoViewModelEducationItem(educations: educationInformation))
    }
    
    func createPresents() {
        let presents = InfoViewModelPresentsItem(presentsNumbers: "\(presentsNumberArray[Int(arc4random_uniform(UInt32(presentsNumberArray.count)))])")
        items.append(presents)
    }
    
    func createFiles() {
        var filesInformation = [Files]()

        for i in 0 ..< 3 {
            let filesInfo = Files(name: "\(filesInfoTitleArray[i])", numbersOfIt: "\(filesInfoCountArray[i][Int(arc4random_uniform(UInt32(filesInfoCountArray[i].count)))])" )
            filesInformation.append(filesInfo)
        }
        items.append(InfoViewModelFilesItem(files: filesInformation))
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items[section].rowCount
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let item = items[indexPath.section]
        switch item.type {
        case .status:
            let cell = tableView.dequeueReusableCell(withIdentifier: statusCellIdentifier, for: indexPath) as! StatusTableViewCell
            cell.prepateCell(with: item as! InfoViewModelStatusItem)
            return cell
            
        case .basicInfo:
            let cell = tableView.dequeueReusableCell(withIdentifier: basicCellIdentifier, for: indexPath) as! BasicInfoTableViewCell
            let basicInfoItemModel = item as! InfoViewModelBasicInfoItem
            cell.prepateCell(with: basicInfoItemModel.basicInfo[indexPath.row])
            return cell
            
        case .contacts:
            let cell = tableView.dequeueReusableCell(withIdentifier: contatsCellIdentifier, for: indexPath) as! ContactsTableViewCell
            let contactInfoItem = item as! InfoVIewModelContactsItem
            cell.prepareCell(with: contactInfoItem.contacts[indexPath.row])
            return cell
            
        case .carier:
            let cell = tableView.dequeueReusableCell(withIdentifier: carierCellIdentifier, for: indexPath) as! CarierTableViewCell
            cell.prepareCell(with: item as! InfoViewModelCarierItem)
            return cell
            
        case .education:
            let cell = tableView.dequeueReusableCell(withIdentifier: educationCellIdentifier, for: indexPath) as! EducationTableViewCell
            let educationInfoItem = item as! InfoViewModelEducationItem
            cell.prepareCell(with: educationInfoItem.educations[indexPath.row])
            return cell
            
        case .presents:
            let cell = tableView.dequeueReusableCell(withIdentifier: presentsCellIdentifier, for: indexPath) as! PresentsTableViewCell
            cell.prepareCell(with: item as! InfoViewModelPresentsItem)
            cell.presents = presents
            return cell
        case .files:
            let cell = tableView.dequeueReusableCell(withIdentifier: filesCellIdentifier, for: indexPath) as! FilesTableViewCell
            let fileInfoItem = item as! InfoViewModelFilesItem
            cell.prepareCell(with: fileInfoItem.files[indexPath.row])
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = items[indexPath.section]
        switch item.type {
        case .basicInfo:
            return basicInfoCellHeight
        
        case .contacts:
            return contactsCellHeight
            
        case .carier:
            return carierCellHeight
        
        case .presents:
            return presentsCellHeight
            
        default:
            return defaultCellHeight
        }
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionType
    }
 
    @objc func handleRefresh(refreshControl: UIRefreshControl) {
        items.removeAll()
        createStatus()
        createBasicInfo()
        createContacts()
        createCarier()
        createEdicational()
        createPresents()
        createFiles()
        tableView.reloadData()
        refreshControl.endRefreshing()
    }
    

}
