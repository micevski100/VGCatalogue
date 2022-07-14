//
//  HistoryViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 6.5.22.
//

import UIKit

class HistoryViewController: UIViewController {
    
    var buttonsView: ButtonsView!
    var tableView: UITableView!
    var byProductCollectionView: UICollectionView!
    var selectedButton: Int = 1
    var backLogList: [Backlog] = []
    var invoicesList: [HistoryInvoice] = []
    var openInvoices: [HistoryOpenInvoice] = []
    var totalOpenInvoices: Int = 0
    var historyProductsList: [Product] = []
    var totalBacklogs: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getBackLogList()
        getInvoicesList()
        getOpenInvoicesList()
        getHistoryProductsList()
        NotificationCenter.default.addObserver(self, selector: #selector(menuToggled), name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
    }
    
    func setupViews() {
        self.title = "History"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        buttonsView = ButtonsView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: 50))
        buttonsView.delegate = self
        
        tableView = UITableView()
        tableView.register(BacklogTableViewCell.self, forCellReuseIdentifier: "backlogCell")
        tableView.register(OpenInvoicesTableViewCell.self, forCellReuseIdentifier: "openInvoicesCell")
        tableView.delegate = self
        tableView.dataSource = self
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        byProductCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        byProductCollectionView.backgroundColor = .clear
        byProductCollectionView.delegate = self
        byProductCollectionView.dataSource = self
        byProductCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        byProductCollectionView.isHidden = true
        
        self.view.addSubview(buttonsView)
        self.view.addSubview(tableView)
        self.view.addSubview(byProductCollectionView)
    }
    
    func setupConstraints() {
        buttonsView.snp.makeConstraints { make in
            make.top.left.right.equalTo(self.view)
            make.height.equalTo(50)
        }
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(buttonsView.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.bottom.equalTo(self.view)
        }
        
        byProductCollectionView.snp.makeConstraints { make in
            make.top.equalTo(buttonsView.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.bottom.equalTo(self.view)
        }
    }
    
    @objc func menuToggled() {
        if self.selectedButton == 4 {
            byProductCollectionView.collectionViewLayout.invalidateLayout()
        }
    }
}

extension HistoryViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if selectedButton == 1 {
            return backLogList.count
        } else {
            return openInvoices.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if selectedButton == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "backlogCell") as! BacklogTableViewCell
            
            cell.setupCell(backlog: backLogList[indexPath.row])
            
            if indexPath.row == backLogList.count - 1 {
                if totalBacklogs > backLogList.count {
                    getBackLogList()
                }
            }
            
            return cell
        }
        else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "openInvoicesCell") as! OpenInvoicesTableViewCell
            
            cell.setupCell(openInvoice: self.openInvoices[indexPath.row])
            
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if selectedButton == 1 {
            // backlog select
            let vc = BacklogDetailsViewController()
            vc.backLog = backLogList[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return self.view.frame.size.height / 3.5
    }
}

extension HistoryViewController: ButtonsViewProtocol {
    
    func shouldShowCollectionView(tag: Int) {
        if tag == 4 {
            tableView.isHidden = true
            byProductCollectionView.isHidden = false
        } else {
            byProductCollectionView.isHidden = true
            tableView.isHidden = false
        }
    }
    
    func buttonSelected(tag: Int) {
        selectedButton = tag
        shouldShowCollectionView(tag: tag)
        if tag == 1 {
            tableView.reloadData()
        } else if tag == 2 {
            
        } else if tag == 3 {
            tableView.reloadData()
        } else {
            byProductCollectionView.reloadData()
        }
    }
}


extension HistoryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return historyProductsList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = byProductCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductsCollectionViewCell
//        cell.setupCell(product: productList[indexPath.row], imageInfo: imageInfo, forGeneralCatalog: false)
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DataHolder.sharedInstance.menuExpanded {
            if UIScreen.main.bounds.height <= 810 {
                return CGSize(width: (self.view.frame.size.width - 60) / 2, height: self.view.frame.size.height / 1.5)
            } else {
                return CGSize(width: (self.view.frame.size.width - 60) / 3, height: self.view.frame.size.height / 1.8)
            }
        } else {
            if UIScreen.main.bounds.height <= 810 {
                return CGSize(width: (self.view.frame.size.width - 60) / 3, height: self.view.frame.size.height / 1.5)
            } else {
                return CGSize(width: (self.view.frame.size.width - 60) / 4, height: self.view.frame.size.height / 1.8)
            }
        }
    }
    
}

//MARK: - API COMMUNICATION
extension HistoryViewController {
    
    func createRequestForHistoryProductsList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber,
                                 "ClientNo": contact?.ClientId,
                                 "LoginNo": userInfo?.LoginNo,
                                 "EmployeeId": employee?.EmployeeId,
                                 "Language": crmInfo?.Language,
                                 "CartNo": DataHolder.sharedInstance.existingCartId],
                    "RequestInfo": ["SearchString": "",
                                    "Skip": historyProductsList.count,
                                    "Take": 30]]
        
        return dict
    }
    
    func getHistoryProductsList() {
        ApiManager.sharedInstance.historyProductsList(params: createRequestForHistoryProductsList()) { success, responseObject, statusCode in
            if success {
                
            } else {
                
            }
        }
    }
    
    func createRequestForOpenInvoicesList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber,
                                 "ClientNo": contact?.ClientId,
                                 "Language": crmInfo?.Language],
                    "RequestInfo": ["ClientId": DataHolder.sharedInstance.selectedContact?.ClientId]]
        
        return dict
    }
    
    func getOpenInvoicesList() {
        ApiManager.sharedInstance.openInvoicesList(params: createRequestForOpenInvoicesList()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let openInvoicesList = responseData["OpenAccountsList"] as? [[String:Any]] ?? []
                let decoder = JSONDecoder()
                
                self.totalOpenInvoices = responseData["OpenAccountsCount"] as? Int ?? 0
                for openInvoiceJSON in openInvoicesList {
                    let json = Utilities.sharedInstance.jsonToData(json: openInvoiceJSON)
                    do {
                        let openInvoice = try decoder.decode(HistoryOpenInvoice.self, from: json!)
                        self.openInvoices.append(openInvoice)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                self.tableView.reloadData()
            } else {
                
            }
        }
    }
    
    func createRequestForInvoicesList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        let userInfoDict = ["ShopNumber": crmInfo?.ShopNumber ?? 0,
                            "ClientNo": contact?.ClientId ?? 0,
                            "LoginNo": userInfo?.LoginNo ?? 0,
                            "EmployeeId": employee?.EmployeeId ?? 0,
                            "Language": crmInfo?.Language ?? "EN",
                            "CartNo": DataHolder.sharedInstance.existingCartId ?? 0] as [String:Any]
        let requestInfoDict = ["ClientId": DataHolder.sharedInstance.selectedContact?.ClientId ?? 0,
                               "OrderBy": 0,
                               "Skip": invoicesList.count,
                               "Take": 30] as [String:Any]
        
        let dict = ["UserInfo": userInfoDict, "RequestInfo": requestInfoDict]
        
        return dict
    }
    
    func getInvoicesList() {
        ApiManager.sharedInstance.invoicesList(params: createRequestForInvoicesList()) { success, responseObject, statusCode in
            if success {
                
                
            } else {
                
            }
        }
    }
    
    func createRequestForBackLogList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber,
                                 "ClientNo": contact?.ClientId,
                                 "LoginNo": userInfo?.LoginNo,
                                 "EmployeeId": employee?.EmployeeId,
                                 "Language": crmInfo?.Language ?? "EN",
                                 "CartNo": DataHolder.sharedInstance.existingCartId],
                    "RequestInfo": ["ClientId": DataHolder.sharedInstance.selectedContact?.ClientId,
                                    "OrderBy": 0,
                                    "Skip": backLogList.count,
                                    "Take": 30]]
        
        return dict
    }
    
    func getBackLogList() {
        ApiManager.sharedInstance.backLogList(params: createRequestForBackLogList()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let backlogListInfo = responseData["BacklogListInfo"] as? [String:Any] ?? [:]
                let backlogList = responseData["BacklogList"] as? [[String:Any]] ?? []
                let decoder = JSONDecoder()
                
                self.totalBacklogs = backlogListInfo["Total"] as? Int ?? 0
                for backlogJSON in backlogList {
                    let json = Utilities.sharedInstance.jsonToData(json: backlogJSON)
                    do {
                        let log = try decoder.decode(Backlog.self, from: json!)
                        self.backLogList.append(log)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                self.tableView.reloadData()
            } else {
                
            }
        }
    }
}
