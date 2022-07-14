//
//  OrdersViewController2.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 23.5.22.
//

import UIKit

class OrdersViewController2: UIViewController {
    
    var clientInfoView: InfoView!
    var contactInfoView: InfoView!
    var acceptOrderButton: CustomButton!
    var ordersTableView: UITableView!
    var orderList = [Product]()
    var ordersHeaderView: OrdersHeaderView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getOrders()
//        deliveryList()
        NotificationCenter.default.addObserver(self, selector: #selector(menuToggled), name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
    }
    
    func setupViews() {
        clientInfoView = InfoView(frame: CGRect.zero)
        clientInfoView.setupView(name: DataHolder.sharedInstance.selectedClient?.FullName,
                                 phone: DataHolder.sharedInstance.selectedClient?.PhoneNumber,
                                 location: DataHolder.sharedInstance.selectedClient?.Address)
        
        contactInfoView = InfoView(frame: CGRect.zero)
        contactInfoView.setupView(name: DataHolder.sharedInstance.selectedContact?.FullName,
                                  phone: DataHolder.sharedInstance.selectedContact?.PhoneNumber,
                                  location: DataHolder.sharedInstance.selectedContact?.Address)
        
        acceptOrderButton = CustomButton(frame: CGRect.zero, title: "Accept Order (0.00 CHF)", backgroundColor: Theme.sharedInstance.themeBlueColor(), imageName: nil, tintColor: nil)
        
        ordersTableView = UITableView()
        ordersTableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: "cell")
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        
        
        
        self.view.addSubview(clientInfoView)
        self.view.addSubview(contactInfoView)
        self.view.addSubview(acceptOrderButton)
        self.view.addSubview(ordersTableView)
    }
    
    func setupConstraints() {
        clientInfoView.snp.makeConstraints { make in
            make.top.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view.snp.centerX).offset(-20)
            
            if UIScreen.main.bounds.height <= 810 {
                make.height.equalTo(self.view.frame.size.height / 5)
            } else {
                make.height.equalTo(self.view.frame.size.height / 6)
            }
        }
        
        contactInfoView.snp.makeConstraints { make in
            make.top.right.equalTo(self.view).inset(20)
            make.left.equalTo(self.view.snp.centerX).offset(20)
            if UIScreen.main.bounds.height <= 810 {
                make.height.equalTo(self.view.frame.size.height / 5)
            } else {
                make.height.equalTo(self.view.frame.size.height / 6)
            }
        }
        
        acceptOrderButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(self.view.frame.size.width / 18)
            make.bottom.equalTo(self.view).offset(-self.view.frame.size.height / 18)
            make.height.equalTo(50)
        }
        
        ordersTableView.snp.makeConstraints { make in
            make.top.equalTo(clientInfoView.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.bottom.equalTo(acceptOrderButton.snp.top).offset(-20)
        }
    }
    
    @objc func menuToggled() {
        self.ordersTableView.reloadData()
    }
}

//MARK: - TABLEVIEW DELEGATES
extension OrdersViewController2: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "cell") as! OrdersTableViewCell
        let product = orderList[indexPath.row]
        cell.setupCell(product: product)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        ordersHeaderView = OrdersHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 12))
        
        return ordersHeaderView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.height / 12
    }
}

//MARK: - API COMMUNICATION
extension OrdersViewController2 {
//    func createRequestForDeliveryList() -> [String:Any] {
//        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
//        let userInfo = UserPersistance.sharedInstance.getUserInfo()
//        let employee = UserPersistance.sharedInstance.getEmployee()
//        let contact = DataHolder.sharedInstance.selectedContact
//
//        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber,
//                                 "ClientNo": contact?.ClientId,
//                                 "LoginNo": userInfo?.LoginNo,
//                                 "EmployeeId": employee?.EmployeeId,
//                                 "Language": crmInfo?.Language,
//                                 "CartNo": DataHolder.sharedInstance.existingCartId],
//                    "RequestInfo": ["EmployeeId": employee?.EmployeeId, "ClientId": contact?.ClientId]]
//
//        return dict
//    }
//
//    func deliveryList() {
//        ApiManager.sharedInstance.deliveryList(params: createRequestForDeliveryList()) { success, responseObject, statusCode in
//            if success {
//
//            } else {
//
//            }
//        }
//    }
    
    func createRequestForGetOrders() -> [String:Any] {
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
                    "RequestInfo": ["EmployeeId": employee?.EmployeeId]]
        
        return dict
    }
    
    func getOrders() {
        ApiManager.sharedInstance.listOrders(params: createRequestForGetOrders()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let cartDetails = responseData["CartDetails"] as? [[String:Any]] ?? []
                let decoder = JSONDecoder()
                print(cartDetails)
                for orderJson in cartDetails {
                    let json = Utilities.sharedInstance.jsonToData(json: orderJson)
                    do {
                        let order = try decoder.decode(Product.self, from: json!)
                        self.orderList.append(order)
                        self.ordersTableView.reloadData()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            } else {
                
            }
        }
    }
}
