//
//  ProfileTableViewController.swift
//  VK
//
//  Created by Elina on 22/09/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class ProfileTableViewController: UITableViewController, ThreePointsButtonProtocol {
    
    let iosIconImage = UIImage(assetName: .iosIcon)
    
    @IBOutlet weak var usersAvatar: UIImageView!
    @IBOutlet weak var usersName: UILabel!
    @IBOutlet weak var usersStatus: UILabel!
    @IBOutlet weak var usersAgeAndCity: UILabel!
    @IBOutlet weak var nameInToolBar: UINavigationItem!
    
    var nameAndSurname = ""
    var status = ""
    var usersPhoto = UIImage(assetName: .empty)
    var ageAndCity = ""
    var usersNameForToolBar = ""
    
    var statusSection = 0
    var mainInformationSection = 1
    var contactsSection = 2
    var careerSection = 3
    var educationSection = 4
    var giftsSection = 5
    var interestsSection = 6
    
    var interestsSectionRowHeight: CGFloat = 65
    var sectionsRowHeight: CGFloat = 70
    var mainInfoHeaderHeight: CGFloat = 3
    var giftsHeaderHeight: CGFloat = 120
    var headerHeight: CGFloat = 30
    
    var user: Users!
    
    var usersInformation: [Information] = [Information(sectionName: "Изменить статус", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["День рождения", "Семейное положение", "Языки", "Братья, сестры" ], rowsImages: [], rowsFilling: ["24 мая 1996", "не замужем", "русский, english", "Элина Батырова"]), Information(sectionName: "Контакты", rowsNames: [], rowsImages: [
    UIImage(named: "phone icon")!, UIImage(named: "home icon")!, UIImage(named: "vk icon")!], rowsFilling: ["89667777799", "Kazan, Nab.Chelny", "vk.com/id8888"]), Information(sectionName: "Карьера", rowsNames: ["iOS lab"], rowsImages: [UIImage(named:"ios icon")!], rowsFilling: ["iOS Developer"]), Information(sectionName: "Образование", rowsNames: ["Вуз", "Школа"], rowsImages: [], rowsFilling: ["МГУ", "Лицей 78 им.А.С.Пушкина"]), Information(sectionName: "Подарки", rowsNames: [], rowsImages: [], rowsFilling: []), Information(sectionName: "", rowsNames: ["Интересные страницы", "Заметки", "Документы"], rowsImages: [], rowsFilling: ["178", "5","90"])]
    

    override func viewDidLoad() {
        super.viewDidLoad()
        setupNavigationBar()
        
        usersAvatar.image = usersPhoto
        usersName.text = nameAndSurname
        usersAgeAndCity.text = ageAndCity
        nameInToolBar.title = usersNameForToolBar
        
        setupRefreshControl()
        nibsRegister()
        
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func refreshTableView(sender: UIRefreshControl) {
        
        usersAvatar.image = iosIconImage
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func nibsRegister() {
        
        let mainInfoNib = UINib(nibName: .mainInfoNibName)
        tableView.register(mainInfoNib, forCellReuseIdentifier: Identifiers.mainInfoIdentifier.rawValue)
        
        let contactsNib = UINib(nibName: .contactsNibName)
        tableView.register(contactsNib, forCellReuseIdentifier: Identifiers.contactsIdentifier.rawValue)
        
        let careerNib = UINib(nibName: .careerNibName)
        tableView.register(careerNib, forCellReuseIdentifier: Identifiers.careerIdentifier.rawValue)
        
        let educationNib = UINib(nibName: .educationNibName)
        tableView.register(educationNib, forCellReuseIdentifier: Identifiers.educationIdentifier.rawValue)
        
        let interestsNib = UINib(nibName: .interestsNibName)
        tableView.register(interestsNib, forCellReuseIdentifier: Identifiers.interestsIdentifier.rawValue)
        
        let statusNib = UINib(nibName: .statusNibName)
        tableView.register(statusNib, forCellReuseIdentifier: Identifiers.statusIdentifier.rawValue)
        
        let giftsNib = UINib(nibName: .giftsNibName)
        tableView.register(giftsNib, forCellReuseIdentifier: Identifiers.giftsIdentifier.rawValue)
        
        let headerNib = UINib(nibName: .headerNibName)
        tableView.register(headerNib, forCellReuseIdentifier: Identifiers.headerIdentifier.rawValue)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return usersInformation.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usersInformation[section].rowsFilling.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if indexPath.section == mainInformationSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.mainInfoIdentifier.rawValue) as! MainInformationTableViewCell
            
            cell.prepareCell(with: usersInformation, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == contactsSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.contactsIdentifier.rawValue) as! ContactsTableViewCell
            
            cell.prepareCell(with: usersInformation, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == careerSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.careerIdentifier.rawValue) as! CareerTableViewCell
            
            cell.prepareCell(with: usersInformation, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == educationSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.educationIdentifier.rawValue) as! EducationTableViewCell
            
            cell.prepareCell(with: usersInformation, cellForRowAt: indexPath)
            
            return cell
            
        }
        
        if indexPath.section == interestsSection {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.interestsIdentifier.rawValue) as! InterestsTableViewCell
            
            cell.prepareCell(with: usersInformation, cellForRowAt: indexPath)
            
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.labelIdentifier.rawValue, for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section) Row \(indexPath.row)"

        return cell
        
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        if indexPath.section == interestsSection {
            return interestsSectionRowHeight
        }
        return interestsSectionRowHeight
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        if section == statusSection {
            
        let headerCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.statusIdentifier.rawValue) as! StatusTableViewCell
            
        headerView.addSubview(headerCell)
            
            return headerView
        }
        
        if section == giftsSection {
            
            let headerCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.giftsIdentifier.rawValue) as! GiftsTableViewCell
            
            headerView.addSubview(headerCell)
            
            return headerView
        }
            
        let headerCell = tableView.dequeueReusableCell(withIdentifier: Identifiers.headerIdentifier.rawValue) as! CustomHeaderTableViewCell
        
        headerCell.prepareCell(with: usersInformation, viewForHeaderInSection: section)
        headerView.addSubview(headerCell)
        
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == mainInformationSection {
            return mainInfoHeaderHeight
        }
        
        if section == giftsSection {
            return giftsHeaderHeight
        }
        return headerHeight
    }
    
    //MARK: Buttons actions
    
    @IBAction func threePointsButtonAction(_ sender: Any) {
        
        let actionSheetController = self.didPressThreePointsButton()
        
        present(actionSheetController, animated: true, completion: nil)
    }
}
