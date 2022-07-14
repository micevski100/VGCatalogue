//
//  LoginViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 21.2.22.
//

import UIKit
import SnapKit

class LoginViewController: UIViewController {

    // UI
    var backgroundImageView: UIImageView!
    var splitViewVC = UISplitViewController(style: .doubleColumn)
    var customInputView: CustomInputView!
    var activityIndicator: UIActivityIndicatorView!

    // Back End
    var erpInfo: ErpInfo!
    var employee: Employee!
    var userInfo: UserInfo!
    var crmInfo: CrmInfo!
    var textfieldPlaceholders = [
        ["Database name", "xmark.circle.fill", ""],
        ["Database code", "eye", ""],
        ["First name", "xmark.circle.fill", ""],
        ["Password", "eye", ""]
    ]

//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }

//MARK: - VIEW WILL APPEAR
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        // add keyboard will show and will hide events
        NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
            NotificationCenter.default.addObserver(self, selector: #selector(LoginViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

//MARK: - VIEW WILL DISSAPEAR
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)

        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillShowNotification)
        NotificationCenter.default.removeObserver(LoginViewController.keyboardWillHideNotification)
    }

//MARK: - SETUP VIEWS
    func setupViews() {
        // Background Image
        backgroundImageView = CustomImageView(frame: CGRect.zero, imageName: "loginBackground", contentMode: .scaleAspectFill)
        customInputView = CustomInputView(frame: self.view.frame, textFieldPlaceHolders: textfieldPlaceholders, buttonText: "LOGIN", isForLogin: true)
        customInputView.delegate = self
        
        activityIndicator = UIActivityIndicatorView(style: .large)

        
        self.view.addSubview(backgroundImageView)
        self.view.addSubview(customInputView)
        self.view.addSubview(activityIndicator)
    }

//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        backgroundImageView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
        
        customInputView.snp.makeConstraints { make in
            make.top.bottom.equalTo(self.view).inset(self.view.frame.size.height / 14)
            make.width.equalTo(self.view).multipliedBy(0.65)
            make.centerX.equalTo(self.view)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
}

//MARK: HELPER FUNCTIONS
extension LoginViewController {
    func displayFillOutFieldsErrorMessage() {
        let alert = UIAlertController(title: "Please fill out all fields", message: "All fields are mandatory", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    func displayLoginErrorMessage(errorMsg: String) {
        let alert = UIAlertController(title: "Login Failed", message: errorMsg, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}

//MARK: - KEYBOARD EVENTS
extension LoginViewController {
    @objc func keyboardWillShow(notification: Notification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            customInputView.changeTableViewHeight(offset: keyboardSize.height - self.view.frame.size.height / 14)
        }
    }

    @objc func keyboardWillHide(notification: Notification) {
        customInputView.reloadTableViewConstraints()
    }
}


//MARK: API COMMUNICATION
extension LoginViewController {
    func createReqestforErpLogin() -> [String:Any] {
        let dbCodeCell = textfieldPlaceholders[0][2]
        let companyCode = textfieldPlaceholders[1][2]
        
        let dict = ["RequestInfo": ["DbCode": dbCodeCell, "CompanyCode": companyCode]]
        return dict
    }

    func erpLogin() {
        ApiManager.sharedInstance.erpLogin(params: createReqestforErpLogin()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any]
                let erpInfoResponseData = responseData?["ErpInfo"] as? [String:Any]
                let userInfo = responseObject?["ResponseUserInfo"] as? [String:Any]
                let decoder = JSONDecoder()

                if erpInfoResponseData == nil {
                    let alert = UIAlertController(title: "Login Failed", message: "", preferredStyle: UIAlertController.Style.alert)
                    alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    return
                }

                // save erp info
                var json = Utilities.sharedInstance.jsonToData(json: erpInfoResponseData ?? [:])
                do {
                    self.erpInfo = try decoder.decode(ErpInfo.self, from: json!)
                    UserPersistance.sharedInstance.setErpInfo(erpInfo: self.erpInfo)
                } catch {
                    print(error.localizedDescription)
                }
                
                // save user info
                json = Utilities.sharedInstance.jsonToData(json: userInfo ?? [:])
                do {
                    self.userInfo = try decoder.decode(UserInfo.self, from: json!)
                    UserPersistance.sharedInstance.setUserInfo(userInfo: self.userInfo)
                } catch {
                    print(error.localizedDescription)
                }

                
                self.employeeLogin(mobileNom: self.erpInfo.Mobile_Nom!, mobileMP: self.erpInfo.Mobile_Nom!)

            } else {
                let responseInfo = responseObject?["ResponseInfo"] as! [String:Any]
                let errorMsg = responseInfo["ErrorMessage"] as! String
                self.displayLoginErrorMessage(errorMsg: errorMsg)
            }
        }
    }

    func createRequestForEmployeeLogin(mobileNom: String, mobileMP: String) -> [String:Any] {
        let codeCell = textfieldPlaceholders[2][2]
        let passwordCell = textfieldPlaceholders[3][2]
        let erpInfo = UserPersistance.sharedInstance.getErpInfo()
        
        let dict = [
                    "UserInfo": ["Language": Locale.current.languageCode!],
                    "RequestInfo": ["Mobile_Nom": mobileNom,
                                    "Mobile_Mp": mobileMP,
                                    "Code": codeCell,
                                    "Password": passwordCell,
                                    "ShopNumber": erpInfo?.ShopNumber ?? 0]
                ]

                return dict
    }

    func employeeLogin(mobileNom: String, mobileMP: String)  {
        ApiManager.sharedInstance.employeeLogin(params: createRequestForEmployeeLogin(mobileNom: mobileNom, mobileMP: mobileMP)) { success, responseObject, statusCode in

            if success {
                let responseData = responseObject?["ResponseData"] as! [String:Any]
                let employeeRepsonseData = responseData["Employee"] as? [String:Any]
                let crmInfoResponseData = responseData["CrmInfo"] as? [String:Any]
                let decoder = JSONDecoder()

                // Save employee info
                var json = Utilities.sharedInstance.jsonToData(json: employeeRepsonseData!)
                do {
                    self.employee = try decoder.decode(Employee.self, from: json!)
                    UserPersistance.sharedInstance.setEmployee(employee: self.employee)
                } catch {
                    print(error.localizedDescription)
                }

                // save crm info
                json = Utilities.sharedInstance.jsonToData(json: crmInfoResponseData!)
                do {
                    self.crmInfo = try decoder.decode(CrmInfo.self, from: json!)
                    UserPersistance.sharedInstance.setCrmInfo(crmInfo: self.crmInfo)
                } catch {
                    print(error.localizedDescription)
                }

                // get access token
                let accessToken = responseData["AccessToken"] as! String
                UserPersistance.sharedInstance.setAccessToken(token: accessToken)

                // set user is logged in
                UserPersistance.sharedInstance.setuserLoggedIn(loggedIn: true)
                
                // present second screen
                let menuVC = MenuController()
                menuVC.modalPresentationStyle = .fullScreen
                self.present(menuVC, animated: true)
            } else {
                let responseInfo = responseObject?["ResponseInfo"] as! [String:Any]
                let errorMsg = responseInfo["ErrorMessage"] as! String
                self.displayLoginErrorMessage(errorMsg: errorMsg)
            }
        }
    }
}

extension LoginViewController: CustomInputViewDelegate {
    func textFieldChanged(textField: UITextField) {
        textfieldPlaceholders[textField.tag][2] = textField.text!
    }
    func bottomButtonTapped() {
        activityIndicator.startAnimating()
        erpLogin()
        self.activityIndicator.stopAnimating()
    }
}
