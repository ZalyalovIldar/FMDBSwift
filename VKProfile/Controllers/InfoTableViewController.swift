//
//  InfoTableViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 20.09.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class InfoTableViewController: UITableViewController {
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var statusLabel: UILabel!
    @IBOutlet weak var yearsLabel: UILabel!
    @IBOutlet weak var yearTextLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    let contacts = "контакты"
    let career = "карьера"
    let education = "образование"
    
    let cellsInfo = [
        CellInfo(fileName: "StatusTableViewCell", identifier: "statusCell"),
        CellInfo(fileName: "MainInfoTableViewCell", identifier: "mainInfoCell"),
        CellInfo(fileName: "ContactTableViewCell", identifier: "contactCell"),
        CellInfo(fileName: "ProfessionTableViewCell", identifier: "professionCell"),
        CellInfo(fileName: "InstituteTableViewCell", identifier: "instituteCell"),
        CellInfo(fileName: "PresentTableViewCell", identifier: "presentCell"),
        CellInfo(fileName: "OtherInfoTableViewCell", identifier: "otherInfoCell")
    ]
    let schoolCellInfo = CellInfo(fileName: "SchoolTableViewCell", identifier: "schoolCell")
    
    var numberOfRowsAtSection = [Int]()
    var user: User!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.estimatedRowHeight = 50
        tableView.estimatedSectionHeaderHeight = 50
        
        prepareNavBar()
        createPullToRefresh()
        user.info = UserInfoData.generateUserInfo(with: user.age)
        fillLabels(with: user)
        registerNumberOfRowsAtSection()
        registerCells()
    }
    
    //MARK: - setting UI information
    
    private func prepareNavBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "more"), style: .plain, target: self, action: #selector(onMoreClick))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "", style: .plain, target: nil, action: nil)
        title = user.name
    }
    
    @objc private func onMoreClick() {
        present(MoreProfileAlert.getAlert(), animated: true, completion: nil)
    }
    
    private func createPullToRefresh() {
        let refreshText = "Pull to random"
        
        refreshControl = UIRefreshControl()
        if let refreshControl = refreshControl {
            refreshControl.attributedTitle = NSAttributedString(string: refreshText)
            refreshControl.addTarget(self, action: #selector(self.refresh(_:)), for: .valueChanged)
            tableView.addSubview(refreshControl)
        }
    }
    
    @objc func refresh(_ sender: Any) {
        let delay: TimeInterval = 3
        user.info = UserInfoData.generateUserInfo(with: user.age)
        Timer.scheduledTimer(withTimeInterval: delay, repeats: false) {[weak self] (timer) in
            
            guard let strongSelf = self else { return }
            
            DispatchQueue.main.async {
                strongSelf.tableView.reloadData()
                strongSelf.refreshControl?.endRefreshing()
            }
        }
    }
    
    private func fillLabels(with user: User) {
        let seperator = ","
        
        avatarImageView.roundCorners()
        avatarImageView.image = user.profileImage
        nameLabel.text = "\(user.name) \(user.surname)"
        statusLabel.text = user.onlineStatus.rawValue
        yearsLabel.text = "\(user.age)"
        yearTextLabel.text = EndingWord.getCorrectEnding(with: user.age, and: DeclinationWord.age) + seperator
        cityLabel.text = user.city
    }
    
    private func registerCells() {
        for i in 0 ..< cellsInfo.count {
            let cellInfo = cellsInfo[i]
            let nib = UINib(nibName: cellInfo.fileName, bundle: nil)
            tableView.register(nib, forCellReuseIdentifier: cellInfo.identifier)
        }
        
        let nib = UINib(nibName: schoolCellInfo.fileName, bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: schoolCellInfo.identifier)
    }
    
    private func registerNumberOfRowsAtSection() {
        let userInfo = user.info
        let userEducation = userInfo.education
        let statusCountRow = 1
        let presentsCountRow = 1
        numberOfRowsAtSection.append(statusCountRow)
        numberOfRowsAtSection.append(userInfo.main.count)
        numberOfRowsAtSection.append(userInfo.contacts.count)
        numberOfRowsAtSection.append(userInfo.professions.count)
        numberOfRowsAtSection.append(userEducation.institutes.count + userEducation.schools.count)
        numberOfRowsAtSection.append(presentsCountRow)
        numberOfRowsAtSection.append(userInfo.others.count)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return cellsInfo.count
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        var rows = 0
        
        if (section < numberOfRowsAtSection.count) {
            rows = numberOfRowsAtSection[section]
        }
        
        return rows
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = indexPath.section
        let row = indexPath.row
        
        let userInfo = user.info
        
        switch section {
        case 0:
            let statusCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! StatusTableViewCell
            statusCell.prepareCell(with: userInfo.status)
            return statusCell
        case 1:
            let mainInfoCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! MainInfoTableViewCell
            mainInfoCell.prepareCell(with: userInfo.main[row])
            return mainInfoCell
        case 2:
            let contactCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! ContactTableViewCell
            contactCell.prepareCell(with: userInfo.contacts[row])
            return contactCell
        case 3:
            let professionCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! ProfessionTableViewCell
            professionCell.prepareCell(with: userInfo.professions[row])
            return professionCell
        case 4:
            let instituteCount = userInfo.education.institutes.count
            if row < instituteCount {
                let instituteCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! InstituteTableViewCell
                instituteCell.prepareCell(with: userInfo.education.institutes[row])
                return instituteCell
            } else {
                let schoolCell = tableView.dequeueReusableCell(withIdentifier: schoolCellInfo.identifier, for:indexPath) as! SchoolTableViewCell
                schoolCell.prepareCell(with: userInfo.education.schools[row - instituteCount])
                return schoolCell
            }
        case 5:
            let presentCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! PresentTableViewCell
            presentCell.presents = userInfo.presents
            return presentCell
        case 6:
            let otherInfoCell = tableView.dequeueReusableCell(withIdentifier: cellsInfo[section].identifier, for: indexPath) as! OtherInfoTableViewCell
            otherInfoCell.prepareCell(with: userInfo.others[row])
            return otherInfoCell
        default:
            break
        }

        return UITableViewCell()
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch section {
            case 2: return contacts
            case 3: return career
            case 4: return education
            default: return ""
        }
    }

}
