//
//  AddClientViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 9.3.22.
//

import UIKit

class AddClientViewController: UIViewController {
    
    var titleLabel: UILabel!
    var customInputView: CustomInputView!
    var textfieldPlaceholders = [
            ["Company Name", "xmark.circle.fill", ""],
            ["First Name", "xmark.circle.fill", ""],
            ["Last Name", "xmark.circle.fill", ""],
            ["Email", "xmark.circle.fill", ""],
            ["Phone Number", "xmark.circle.fill", ""],
        ]
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        // add keyboard will show and will hide events
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        setupViews()
        setupConstraints()
    }
    
//MARK: - VIEW WILL DISSAPEAR
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillHideNotification)
    }
    
//MARK: - SETUP VIEWS
    func setupViews() {
        self.title = "Add Client"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = true
        self.view.backgroundColor = .white
        
        customInputView = CustomInputView(frame: self.view.frame, textFieldPlaceHolders: textfieldPlaceholders, buttonText: "ADD CLIENT", isForLogin: false)
        customInputView.delegate = self
        
        self.view.addSubview(customInputView)
    }
    
//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        customInputView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(self.view.frame.size.height / 5)
            make.bottom.equalTo(self.view).offset(-(self.view.frame.size.height / 10))
            make.width.equalTo(self.view).dividedBy(1.5)
            make.centerX.equalTo(self.view)
        }
    }
}

//MARK: - KEYBOARD EVENTS
extension AddClientViewController {
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            customInputView.changeTableViewHeight(offset: keyboardSize.height - self.view.frame.size.height / 10)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        customInputView.reloadTableViewConstraints()
    }
}

//MARK: - CUSTOM INPUT VIEW DELEGATES
extension AddClientViewController: CustomInputViewDelegate {
    func bottomButtonTapped() {
        let companyName = textfieldPlaceholders[0][2]
        let firstName = textfieldPlaceholders[1][2]
        let lastName = textfieldPlaceholders[2][2]
        let email = textfieldPlaceholders[3][2]
        let phoneNumber = textfieldPlaceholders[4][2]
        
        if companyName == "" || firstName == "" || lastName == "" || !isValidEmail(email: email) || phoneNumber == "" {
            let alertVC = UIAlertController(title: "All fields are mandatory", message: "", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertVC, animated: true)
            
            return
        }
        
        addClient()
    }
    
    func textFieldChanged(textField: UITextField) {
        textfieldPlaceholders[textField.tag][2] = textField.text!
    }
}

//MARK: - API COMMUNICATION
extension AddClientViewController {
    func createRequestForAddClient() -> [String:Any] {
        let companyName = textfieldPlaceholders[0][2]
        let firstName = textfieldPlaceholders[1][2]
        let lastName = textfieldPlaceholders[2][2]
        let email = textfieldPlaceholders[3][2]
        let phoneNumber = textfieldPlaceholders[4][2]
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber ?? 0], "RequestInfo": ["CompanyName": companyName, "FirstName": firstName, "LastName": lastName, "Email": email, "PhoneNumber": phoneNumber]]

        return dict
    }
    
    func addClient() {
        ApiManager.sharedInstance.addClient(params: createRequestForAddClient()) { success, responseObject, statusCode in
            if success {
                for i in 0..<self.textfieldPlaceholders.count {
                    let cell = self.customInputView.tableView.cellForRow(at: IndexPath(row: i, section: 0)) as! LoginTableViewCell
                    cell.textField.text = ""
                }
                
                let alert = UIAlertController(title: "Client Added", message: "", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            
            } else {
                
            }
        }
    }
}

//MARK: - HELPER FUNCTIONS
extension AddClientViewController {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}
