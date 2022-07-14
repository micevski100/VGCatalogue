//
//  OrdersViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 21.4.22.
//

import UIKit

class OrdersViewController: UIViewController {
    var ordersTableView: UITableView!
    var clientHolderView: CustomView!
    var contactHolderView: CustomView!
    var clientNameLabel: CustomLabel!
    var contactNameLabel: CustomLabel!
    var clientLocationImageView: UIImageView!
    var clientLocationLabel: UILabel!
    var clientPhoneImageView: UIImageView!
    var clientPhoneLabel: UILabel!
    var contactLocationImageView: UIImageView!
    var contactLocationLabel: UILabel!
    var contactPhoneImageView: UIImageView!
    var contactPhoneLabel: UILabel!
    var ordersHolderHeaderView: CustomView!
    var acceptOrderButton: UIButton!
    var orderList = [Product]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getOrders()
        deliveryList()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "Orders"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        clientHolderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        
        contactHolderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        
        clientNameLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedClient?.FullName ?? "", font: Theme.sharedInstance.fontBold(size: 20))
        
        contactNameLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedContact?.FullName ?? "", font: Theme.sharedInstance.fontBold(size: 20))
        
        clientLocationImageView = UIImageView()
        clientLocationImageView.image = UIImage(systemName: "location.fill")
         
        clientLocationLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedClient?.Address ?? "No client address", font: Theme.sharedInstance.fontExtraLight(size: 15))
        if clientLocationLabel.text == "" {
            clientLocationLabel.text = "No client address"
        }
        
        clientPhoneImageView = UIImageView()
        clientPhoneImageView.image = UIImage(systemName: "phone.fill")
        
        clientPhoneLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedClient?.PhoneNumber ?? "No client phone number", font: Theme.sharedInstance.fontExtraLight(size: 15))
        if clientPhoneLabel.text == "" {
            clientPhoneLabel.text = "No client phone number"
        }
        
        contactLocationImageView = UIImageView()
        contactLocationImageView.image = UIImage(systemName: "location.fill")
        
        contactLocationLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedContact?.Address ?? "No contact address", font: Theme.sharedInstance.fontExtraLight(size: 15))
        if contactLocationLabel.text == "" {
            contactLocationLabel.text = "No contact address"
        }
        
        
        contactPhoneImageView = UIImageView()
        contactPhoneImageView.image = UIImage(systemName: "phone.fill")
        
        contactPhoneLabel = CustomLabel(frame: CGRect.zero, text: DataHolder.sharedInstance.selectedContact?.PhoneNumber ?? "No contact phone number", font: Theme.sharedInstance.fontExtraLight(size: 15))
        if contactPhoneLabel.text == "" {
            contactPhoneLabel.text = "No contact phone number"
        }
        
        acceptOrderButton = CustomButton(frame: CGRect.zero, title: "Accept Order (0.00 CHF)", backgroundColor: Theme.sharedInstance.themeBlueColor(), imageName: nil, tintColor: nil)
        
        ordersTableView = UITableView()
//        ordersTableView.tableHeaderView = OrdersHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 12))
        ordersTableView.register(OrdersTableViewCell.self, forCellReuseIdentifier: "cell")
        ordersTableView.delegate = self
        ordersTableView.dataSource = self
        ordersTableView.backgroundColor = .brown
        
        self.view.addSubview(clientHolderView)
        self.view.addSubview(contactHolderView)
        self.view.addSubview(clientNameLabel)
        self.view.addSubview(contactNameLabel)
        self.view.addSubview(clientLocationImageView)
        self.view.addSubview(clientPhoneImageView)
        self.view.addSubview(contactLocationImageView)
        self.view.addSubview(contactPhoneImageView)
        self.view.addSubview(clientLocationLabel)
        self.view.addSubview(clientPhoneLabel)
        self.view.addSubview(contactLocationLabel)
        self.view.addSubview(contactPhoneLabel)
//        self.view.addSubview(totalPriceHolderView)
        self.view.addSubview(acceptOrderButton)
//        self.view.addSubview(totalPriceLabel)
        self.view.addSubview(ordersTableView)
    }
    
    func setupConstraints() {
        clientHolderView.snp.makeConstraints { make in
            make.top.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view.snp.centerX).offset(-10)
            make.height.equalTo(self.view.frame.size.height / 4)
            if UIScreen.main.bounds.height <= 810 {
                make.height.equalTo(self.view.frame.size.height / 5)
            } else {
                make.height.equalTo(self.view.frame.size.height / 6)
            }
        }
        
        contactHolderView.snp.makeConstraints { make in
            make.top.right.equalTo(self.view).inset(20)
            make.left.equalTo(self.view.snp.centerX).offset(10)
            if UIScreen.main.bounds.height <= 810 {
                make.height.equalTo(self.view.frame.size.height / 5)
            } else {
                make.height.equalTo(self.view.frame.size.height / 6)
            }
        }
        
        clientNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(clientHolderView).inset(20)
            make.height.equalTo(25)
        }
        
        contactNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(contactHolderView).inset(20)
            make.height.equalTo(25)
        }
        
        clientPhoneImageView.snp.makeConstraints { make in
            make.left.bottom.equalTo(clientHolderView).inset(20)
            make.width.height.equalTo(25)
        }
        
        clientLocationImageView.snp.makeConstraints { make in
            make.left.equalTo(clientHolderView).offset(20)
            make.bottom.equalTo(clientPhoneImageView.snp.top).offset(-20)
            make.width.height.equalTo(25)
        }
        
        clientPhoneLabel.snp.makeConstraints { make in
            make.bottom.right.equalTo(clientHolderView).inset(18)
            make.left.equalTo(clientPhoneImageView.snp.right).offset(20)
            make.width.height.equalTo(25)
        }
        
        clientLocationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(clientPhoneImageView.snp.top).offset(-22)
            make.left.equalTo(clientLocationImageView.snp.right).offset(20)
            make.right.equalTo(clientHolderView).offset(-20)
        }
        
        contactPhoneImageView.snp.makeConstraints { make in
            make.left.bottom.equalTo(contactHolderView).inset(20)
            make.width.height.equalTo(25)
        }
        
        contactLocationImageView.snp.makeConstraints { make in
            make.left.equalTo(contactHolderView).offset(20)
            make.bottom.equalTo(contactPhoneImageView.snp.top).offset(-20)
            make.width.height.equalTo(25)
        }
        
        contactPhoneLabel.snp.makeConstraints { make in
            make.bottom.right.equalTo(contactHolderView).inset(18)
            make.left.equalTo(contactPhoneImageView.snp.right).offset(20)
            make.width.height.equalTo(25)
        }
        
        contactLocationLabel.snp.makeConstraints { make in
            make.bottom.equalTo(contactPhoneImageView.snp.top).offset(-22)
            make.left.equalTo(contactLocationImageView.snp.right).offset(20)
            make.right.equalTo(contactHolderView).offset(-20)
        }
        
        acceptOrderButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(self.view.frame.size.width / 18)
            make.bottom.equalTo(self.view).offset(-self.view.frame.size.height / 18)
            make.height.equalTo(50)
        }
        
//        ordersHolderHeaderView.snp.makeConstraints { make in
//            make.top.equalTo(clientHolderView.snp.bottom).offset(20)
//            make.bottom.equalTo(acceptOrderButton.snp.top).offset(-20)
//            make.left.right.equalTo(self.view).inset(20)
//        }
        
        ordersTableView.snp.makeConstraints { make in
            make.top.equalTo(clientHolderView.snp.bottom).offset(20)
            make.left.right.equalTo(self.view).inset(20)
            make.bottom.equalTo(acceptOrderButton.snp.top).offset(-20)
        }
    
    }
}


extension OrdersViewController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, willHide column: UISplitViewController.Column) {
        DispatchQueue.main.async {
            DataHolder.sharedInstance.toggleMenuExpanded()
            self.ordersTableView.reloadData()
            
        }
    }

    func splitViewController(_ svc: UISplitViewController, willShow column: UISplitViewController.Column) {
        DispatchQueue.main.async {
            DataHolder.sharedInstance.toggleMenuExpanded()
            self.ordersTableView.reloadData()
        }
    }
}

//MARK: - TABLEVIEW DELEGATES
extension OrdersViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return orderList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = ordersTableView.dequeueReusableCell(withIdentifier: "cell") as! OrdersTableViewCell
        let product = orderList[indexPath.row]
        cell.productIDLabel.text = product.Product ?? "No product code"
        cell.productNameLabel.text = product.Descr ?? "No product name"
        cell.productQTYTextField.text = "\(product.Qty ?? 0)"
        if let productPrice = product.Total {
            cell.productPriceLabel.text = "\(productPrice)"
        } else {
            cell.productPriceLabel.text = "No product price"
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = OrdersHeaderView(frame: CGRect(x: 0, y: 0, width: self.view.frame.size.width - 40, height: self.view.frame.size.height / 12))
        
        return headerView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.view.frame.size.height / 12
    }
}


//MARK: - API COMMUNICATION
extension OrdersViewController {
    
    func createRequestForDeliveryList() -> [String:Any] {
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
                    "RequestInfo": ["EmployeeId": employee?.EmployeeId, "ClientId": contact?.ClientId]]
        
        return dict
    }
    
    func deliveryList() {
        ApiManager.sharedInstance.deliveryList(params: createRequestForDeliveryList()) { success, responseObject, statusCode in
            if success {
                
            } else {
                
            }
        }
    }
    
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

