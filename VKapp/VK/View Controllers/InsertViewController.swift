//
//  InsertViewController.swift
//  VK
//
//  Created by Elina on 31/10/2017.
//  Copyright © 2017 Elina. All rights reserved.
//

import UIKit

class InsertViewController: UIViewController, GetAllertsProtocol {

    @IBOutlet weak var loginTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var insertButton: UIButton!
    @IBOutlet weak var scrollView: UIScrollView!
    
    var currentUser: Users? = nil
    var usersDataBase: DBManagerProtocol!
    var users = [Users]()
    var usersId: Int!
    
    override func viewDidLoad() {
        usersDataBase = DBManager()
        users = usersDataBase.get(with: nil)
        super.viewDidLoad()
        setUpKeyboard()
    }
    
    func setUpKeyboard() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            scrollView.contentInset.bottom = keyboardSize.height
        }
    }
    
    func keyboardWillHide(_ notification: NSNotification) {
        scrollView.contentInset.bottom = 0
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Identifiers.insertIdentifier.rawValue && sender != nil && currentUser != nil {
            let destinationVC = segue.destination as! ViewController
            destinationVC.user = currentUser
            destinationVC.usersId = usersId
        }
    }
    
    @IBAction func insertButtonPressed(_ sender: Any) {
        let email = loginTextField.text
        let password = passwordTextField.text
        users.forEach { (user) in
            if (user.email == email || user.phoneNumber == email) && user.password == password {
                currentUser = user
            }
        }
        if currentUser != nil {
            usersId = usersDataBase.getId(object: currentUser!)
            performSegue(withIdentifier: Identifiers.insertIdentifier.rawValue, sender: self)
        } else {
            let alert = self.getErrorOkAlert()
            alert.message = "Пользователь с таким логином и паролем не существует."
            self.present(alert, animated: true, completion: nil)
            
            loginTextField.text = ""
            passwordTextField.text = ""
        }
    }
}
