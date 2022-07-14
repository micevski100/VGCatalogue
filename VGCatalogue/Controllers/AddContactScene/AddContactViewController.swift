//
//  AddContactViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 1.4.22.
//

import UIKit

protocol AddContactProtocol {
    func reloadData()
}

class AddContactViewController: UIViewController {

    var delegate: AddContactProtocol?
    var customInputView: CustomInputView!
    var client: Client!
    var textfieldPlaceholders = [
            ["First Name", "xmark.circle.fill", ""],
            ["Last Name", "xmark.circle.fill", ""],
            ["Email", "xmark.circle.fill", ""],
            ["Phone Number", "xmark.circle.fill", ""],
        ]

//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }

//MARK: - VIEW WILL DISSAPPEAR
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillHideNotification)
    }

//MARK: - SETUP VIEWS
    func setupViews() {
        self.view.backgroundColor = .white
        self.title = "Add Contact".localized()

        customInputView = CustomInputView(frame: self.view.frame, textFieldPlaceHolders: textfieldPlaceholders, buttonText: "ADD CONTACT", isForLogin: false)
        customInputView.delegate = self
        
        self.view.addSubview(customInputView)
    }

//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        customInputView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(self.view.frame.size.height / 14)
            make.bottom.equalTo(self.view).offset(-(self.view.frame.size.height / 10))
            make.width.equalTo(self.view).dividedBy(1.5)
            make.centerX.equalTo(self.view)
        }
    }
}

//MARK: - KEYBOARD EVENTS
extension AddContactViewController {
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
extension AddContactViewController: CustomInputViewDelegate {
    func bottomButtonTapped() {
        let firstName = textfieldPlaceholders[0][2]
        let lastName = textfieldPlaceholders[1][2]
        let email = textfieldPlaceholders[2][2]
        let phoneNumber = textfieldPlaceholders[3][2]
        
        if firstName == "" || lastName == "" || !isValidEmail(email: email) || phoneNumber == "" {
            let alertVC = UIAlertController(title: "All fields are mandatory", message: "", preferredStyle: .alert)
            alertVC.addAction(UIAlertAction(title: "OK", style: .default))
            self.present(alertVC, animated: true)
            
            return
        }
        
        addContact()
    }
    
    func textFieldChanged(textField: UITextField) {
        textfieldPlaceholders[textField.tag][2] = textField.text!
    }
}

//MARK: - HELPER FUNCTIONS
extension AddContactViewController {
    func isValidEmail(email: String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"

        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

//MARK: - API COMMUNICATION
extension AddContactViewController {
    func createRequestForAddContact() -> [String:Any] {
        let firstName = textfieldPlaceholders[0][2]
        let lastName = textfieldPlaceholders[1][2]
        let email = textfieldPlaceholders[2][2]
        let phoneNumber = textfieldPlaceholders[3][2]
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber ?? 0, "Language": crmInfo?.Language ?? ""], "RequestInfo": ["Address": "", "Civility": "", "Zip": 0, "City": "", "MobileNumber": "", "FaxNumber": "", "Web": "", "Position": "", "Info": "","ShopNumber": crmInfo?.ShopNumber ?? 0,"ClientId": client.ClientId ?? 0, "FirstName": firstName, "LastName": lastName, "Email": email, "PhoneNumber": phoneNumber]]
        
        return dict 
    }
    
    func addContact() {
        ApiManager.sharedInstance.addContact(params: createRequestForAddContact()) { success, responseObject, statusCode in
            if success {
                self.navigationController?.popViewController(animated: true)
                self.delegate?.reloadData()
            } else {
                
            }
        }
    }
}
