//
//  RegistrationViewController.swift
//  VKProfile
//
//  Created by Тимур Шафигуллин on 30.10.17.
//  Copyright © 2017 iOS Lab ITIS. All rights reserved.
//

import UIKit

class RegistrationViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var maleCheckbox: CheckBox!
    @IBOutlet weak var femaleCheckBox: CheckBox!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    @IBOutlet weak var ageTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    var repository: Repository!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        repository = UserRepository()
        
        prepareNotifications()
        self.hideKeyboardWhenTappedAround()
    }
    
    //MARK: - prepare methods
    
    func prepareNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
    
    //MARK: - keyboard methods
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if var userInfo = notification.userInfo {
            var keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            
            var contentInset = self.contentScrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            contentScrollView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification: NSNotification) {
        contentScrollView.contentInset = .zero
    }
    
    @objc func handleTap(_ recognizer: UITapGestureRecognizer) {
        view.endEditing(true)
    }
    
    //MARK: - main methods
    
    @IBAction func onRegisterClick(_ sender: UIButton) {
        guard let name = nameTextField.text, !name.isEmpty else {
            nameTextField.shake()
            return
        }
        guard let surname = surnameTextField.text, !surname.isEmpty else {
            surnameTextField.shake()
            return
        }
        guard let email = emailTextField.text, !email.isEmpty else {
            emailTextField.shake()
            return
        }
        guard let phoneNumber = phoneNumberTextField.text, !phoneNumber.isEmpty else {
            phoneNumberTextField.shake()
            return
        }
        guard let ageText = ageTextField.text, let age = Int(ageText) else {
            ageTextField.shake()
            return
        }
        guard let city = cityTextField.text, !city.isEmpty else {
            cityTextField.shake()
            return
        }
        guard let password = passwordTextField.text, !password.isEmpty else {
            passwordTextField.shake()
            return
        }
        
        let userVK = UserVK(name: name, surname: surname, email: email, phoneNumber: phoneNumber, age: age, city: city, password: password)
        repository.syncSave(with: userVK)
        
        navigationController?.popViewController(animated: true)
    }
    
    
    @IBAction func maleChecked(_ sender: CheckBox) {
        sender.isChecked = true
        femaleCheckBox.isChecked = false
    }
    
    @IBAction func femaleChecked(_ sender: CheckBox) {
        sender.isChecked = true
        maleCheckbox.isChecked = false
    }
}
