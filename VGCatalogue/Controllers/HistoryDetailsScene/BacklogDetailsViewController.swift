//
//  BacklogDetailsViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 30.5.22.
//

import UIKit

class BacklogDetailsViewController: UIViewController {
    
    var backLog: Backlog!
    var tableView: UITableView!
    var productList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getBacklogDetails()
    }
    
    func setupViews() {
        tableView = UITableView()
        tableView.register(BacklogDetailsTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.delegate = self
        tableView.dataSource = self

        self.view.addSubview(tableView)
    }
    
    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.edges.equalTo(self.view).inset(20)
        }
    }
}

extension BacklogDetailsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! BacklogDetailsTableViewCell
        
        cell.setupCell(product: productList[indexPath.row])

        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return (self.view.frame.size.height - 40) / 4
    }
}

//MARK: API-COMMUNICATION
extension BacklogDetailsViewController {
    func createRequestForBacklogDetails() -> [String:Any] {
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
        
        let dict = ["UserInfo": userInfoDict,
                    "RequestInfo": ["ClientID": backLog.DocInvoiceClient,
                                    "DocId": backLog.DocId]]
        
        return dict
    }
    
    func getBacklogDetails() {
        ApiManager.sharedInstance.backLogDetails(params: createRequestForBacklogDetails()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let productList = responseData["BacklogDetailsList"] as? [[String:Any]] ?? []
                let decoder = JSONDecoder()
                
                for productJson in productList {
                    let json = Utilities.sharedInstance.jsonToData(json: productJson)
                    do {
                        let client = try decoder.decode(Product.self, from: json!)
                        self.productList.append(client)
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
