import UIKit

class RegistrationViewController: UIViewController {

    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var registrationScrollView: UIScrollView!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var dateBirthdayPickerTextField: UITextField!
    @IBOutlet weak var sexSegmentControl: UISegmentedControl!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordRepeatTextField: UITextField!
    
    let datePicker = UIDatePicker()
    var textFieldsArray = [UITextField]()
    var dataManager: DataManager!
    
    override func viewDidLoad() {
        dataManager = DataManager()
        super.viewDidLoad()
        fillTextFieldsArray()
        createDatePicker()
        prepareNotifications()
        self.hideKeyboardWhenTappedAround()
    }
    
    @IBAction func pressedContinue(_ sender: Any) {
        let check = createUser()
        print (check)
        guard check else { return }
        navigationController?.popViewController(animated: true)
    }
    
    //MARK: - Other methods
    
    func fillTextFieldsArray() {
        textFieldsArray.append(nameTextField)
        textFieldsArray.append(surnameTextField)
        textFieldsArray.append(cityTextField)
        textFieldsArray.append(passwordTextField)
    }
    
    //MARK: - Data Picker
    
    func createDatePicker(){
        datePicker.datePickerMode = .date
        datePicker.maximumDate = Date()
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        // bar button item
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(donePressed))
        toolbar.setItems([doneButton], animated: false)
        dateBirthdayPickerTextField.inputAccessoryView = toolbar
        dateBirthdayPickerTextField.inputView = datePicker
    }
    
    @objc func donePressed(){
        let dateBirthdayFormatter = DateFormatter()
        dateBirthdayFormatter.dateStyle = .medium
        dateBirthdayFormatter.timeStyle = .none
        dateBirthdayFormatter.dateFormat = "dd.MM.yyyy"
        dateBirthdayPickerTextField.text =  dateBirthdayFormatter.string(from: datePicker.date)
        self.view.endEditing(true)
    }
    
    //MARK: - Scroll & Keybord methods
    
    func prepareNotifications(){
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
    }
 
    @objc func keyboardWillShow(notification: NSNotification){
        if var userInfo = notification.userInfo {
            var keyboardFrame: CGRect = (userInfo[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
            keyboardFrame = self.view.convert(keyboardFrame, from: nil)
            var contentInset:UIEdgeInsets = self.registrationScrollView.contentInset
            contentInset.bottom = keyboardFrame.size.height
            registrationScrollView.contentInset = contentInset
        }
    }
    
    @objc func keyboardWillHide(notification:NSNotification){
        registrationScrollView.contentInset = .zero
    }
    
    
    //MARK: - Check methods
    
    func createUser() -> Bool {
        
        var check:Bool = true
        
        for currentTextField in textFieldsArray {
            if let currectText = currentTextField.text, !currectText.isEmpty {
                currentTextField.setClearBorder()
            }
            else {
                currentTextField.setRedBorder()
                check = false
            }
        }
    
        if let email = emailTextField.text, email.contains("@") {
            emailTextField.setClearBorder()
        } else {
            emailTextField.setRedBorder()
            check = false
        }
        
        
        if let date = dateBirthdayPickerTextField.text, !date.isEmpty {
            let checkDate = checkCurrectDate(with: date)
            if (checkDate) {
                dateBirthdayPickerTextField.setClearBorder()
            } else {
                check = false
                dateBirthdayPickerTextField.setRedBorder()
            }
        } else {
            check = false
            dateBirthdayPickerTextField.setRedBorder()
        }
        
        var userPassword = ""
        if let password = passwordTextField.text, !password.isEmpty {
            passwordTextField.setClearBorder()
            userPassword = password
        } else {
            check = false
            passwordTextField.setRedBorder()
        }
        
        if let passwordRepeat = passwordRepeatTextField.text, !passwordRepeat.isEmpty {
            let checkRepeatPassword = checkCurrectRepeatPassword(with: userPassword, and: passwordRepeat)
            if (checkRepeatPassword) {
                passwordRepeatTextField.setClearBorder()
            } else {
                passwordRepeatTextField.setRedBorder()
                check = false
            }
        } else {
            passwordRepeatTextField.setRedBorder()
            check = false
        }
        
    
        guard check else { return false }
        
        guard let name = nameTextField.text, !name.isEmpty,
            let surname = surnameTextField.text, !surname.isEmpty,
            let email = emailTextField.text, !email.isEmpty,
            let city = cityTextField.text, !city.isEmpty,
            let date = dateBirthdayPickerTextField.text, !date.isEmpty,
            let password = passwordTextField.text, !password.isEmpty,
            let sex = sexSegmentControl.titleForSegment(at: sexSegmentControl.selectedSegmentIndex),
            let dateBirthday = dateBirthdayPickerTextField.text, !dateBirthday.isEmpty,
            let repeatPassword = passwordRepeatTextField.text, !repeatPassword.isEmpty else { return false }
        
        let newUser = UserWithRegistration(name: name, surname: surname, email: email, sex: sex, dateBirthday: date, city: city, password: password)
        return dataManager.syncSave(with: newUser)
    }
    
    func checkCurrectDate(with date: String) -> Bool {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        let dateBirthday = dateFormatter.date(from: date)
        let currentDate = NSDate()
        
        if (currentDate as Date > dateBirthday!) {
            return true
        } else {
            return false
        }
    }
    
    func checkCurrectRepeatPassword(with password: String, and repeatPassword: String) -> Bool {
        return (password == repeatPassword)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
}
