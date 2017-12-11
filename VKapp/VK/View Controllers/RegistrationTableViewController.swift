//
//  RegistrationTableViewController.swift
//  VK
//
//  Created by Elina on 31/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class RegistrationTableViewController: UITableViewController, GetAllertsProtocol, RegistrationDataTransferProtocol, UITextFieldDelegate {
    
    var titles = ["Имя", "Фамилия", "Пол", "Возраст", "Город", "Номер телефона", "Email", "Пароль"]
    
    var nameRow = 0
    var surnameRow = 1
    var genderRow = 2
    var ageRow = 3
    var cityRow = 4
    var phoneNumberRow = 5
    var emailRow = 6
    var passwordRow = 7
    
    var rowHeight: CGFloat = 70
    var information: [String] = []
    var usersDataBase: DBManagerProtocol!
    var users = [Users]()
    
    override func viewDidLoad() {
        usersDataBase = DBManager()
        users = usersDataBase.get(with: nil)
        super.viewDidLoad()
        setupNavigationBar()
        setupRefreshControl()
        nibsRegister()
        fillingInformationArray()
    }
    
    func fillingInformationArray() {
        for _ in 0..<titles.count {
            information.append("")
        }
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refreshTableView(sender:)), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    func refreshTableView(sender: UIRefreshControl) {
        tableView.reloadData()
        sender.endRefreshing()
    }
    
    func setupNavigationBar() {
        navigationController?.navigationBar.backItem?.title = "Назад"
        navigationController?.navigationBar.tintColor = UIColor.white
    }
    
    func nibsRegister() {
        let registrationNib = UINib(nibName: .registrationCellNibName)
        tableView.register(registrationNib, forCellReuseIdentifier: Identifiers.registrationCeellIdentifier.rawValue)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return titles.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: Identifiers.registrationCeellIdentifier.rawValue) as! RegistrationTableViewCell
        
        cell.prepareCell(with: titles[indexPath.row])
        cell.registrationDataTransferDelegate = self
        cell.index = indexPath.row
     
        if indexPath.row == passwordRow {
            cell.registrationTextField.isSecureTextEntry = true
        }
            
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return rowHeight
    }

    //MARK: Buttons actions
    
    @IBAction func registrationButtonPressed(_ sender: Any) {
        self.tableView.endEditing(true)
        let access = downloadInformation()
        if access == true {
            let user = Users(name: information[nameRow], surname: information[surnameRow], gender: information[genderRow], email: information[emailRow], phoneNumber: information[phoneNumberRow], age: information[ageRow], city: information[cityRow], password: information[passwordRow])
                        
            usersDataBase.save(with: user, on: nil)            
            performSegue(withIdentifier: Identifiers.registrationIdentifier.rawValue, sender: nil)
        }
    }
    
    func downloadInformation() -> Bool {
        
        if information.contains("") {
            let alert = self.getErrorOkAlert()
            alert.message = "Заполните все поля."
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if !validateEmail(enteredEmail: information[emailRow]) {
            let alert = self.getErrorOkAlert()
            alert.message = "Неверный email."
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        for user in users {
            if user.email == information[emailRow] {
                let alert = self.getErrorOkAlert()
                alert.message = "Пользователь с таким email уже существует."
                self.present(alert, animated: true, completion: nil)
                return false
            }
        }
        
        if !validateNumbers(enteredText: information[ageRow]) {
            let alert = self.getErrorOkAlert()
            alert.message = "Неверный возраст."
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        if !validateNumbers(enteredText: information[phoneNumberRow]) {
            let alert = self.getErrorOkAlert()
            alert.message = "Неверный номер телефона."
            self.present(alert, animated: true, completion: nil)
            return false
        }
        
        return true
    }
    
    //MARK: inputs validation
    func validateEmail(enteredEmail: String) -> Bool {
        let emailFormat = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+"
        let emailPredicate = NSPredicate(format:"SELF MATCHES %@", emailFormat)
        return emailPredicate.evaluate(with: enteredEmail)
    }
    
    func validateNumbers(enteredText: String) -> Bool {
        let numberFormat = "[0-9]+"
        let numberPredicate = NSPredicate(format:"SELF MATCHES %@", numberFormat)
        return numberPredicate.evaluate(with: enteredText)
    }
    
    //MARK: RegistrationDataTransferProtocol
    
    func sendData(with data: String, at index: Int) {
        information[index] = data
    }
}
