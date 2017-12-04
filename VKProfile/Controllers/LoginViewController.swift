//
//  LoginViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    var repository: UserRepository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = UserRepository()
        
        createDemoUser()
        self.hideKeyboardWhenTappedAround()
    }
    
    private func createDemoUser() {
        let demoUserCreatedKey = "demoUserCreated"
        if !UserDefaults.standard.bool(forKey: demoUserCreatedKey) {
            let user = UserVK(name: "Тимур", surname: "Шафигуллин", email: "iOSDeveloper@icloud.com", phoneNumber: "+79172513599", age: 19, city: "Казань", password: "qwe")
            repository.syncSave(with: user)
            UserDefaults.standard.set(true, forKey: demoUserCreatedKey)
        }
    }
    
    @IBAction func onLoginClick(_ sender: UIButton) {
        let errorLoginMessage = "Неверный логин/пароль"
        let errorTitle = "Ошибка"
        let alertButtonOk = "Понятно"
        
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.shake()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.shake()
            return
        }
        
        if repository.check(with: email, and: password) {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let mainPageNVC = storyboard.instantiateViewController(withIdentifier: "mainPageNavigationVC") as! UINavigationController
            guard let mainPageVC = mainPageNVC.viewControllers.first as? ViewController else { return }
            
            guard let userVK = repository.search(with: email) else { return }
            mainPageVC.userVK = userVK
            
            present(mainPageNVC, animated: true, completion: nil)
        } else {
            let alertController = UIAlertController(title: errorTitle, message: errorLoginMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: alertButtonOk, style: .default, handler: nil))
            
            present(alertController, animated: true, completion: nil)
        }
    }
    

}
