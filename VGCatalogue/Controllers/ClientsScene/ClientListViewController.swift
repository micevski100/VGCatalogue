//
//  ClientListViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 8.3.22.
//

import UIKit

class ClientListViewController: UIViewController {

    var collectionView: UICollectionView!
    var clientList = [Client]()
    var totalClients: Int = 0
    var activityIndicator = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getClientList()
        NotificationCenter.default.addObserver(self, selector: #selector(menuToggled), name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
    }
    
//MARK: - SETUP VIEWS
    func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "My Clients"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        let searchBar = UISearchController()
        searchBar.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchBar
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ClientsListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(collectionView)
        self.view.addSubview(activityIndicator)
    }
    
//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        collectionView.snp.makeConstraints { make in
            //make.top.equalTo(searchBar.snp.bottom).offset(20)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalTo(self.view).inset(10)
        }
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalTo(self.view)
        }
    }
    
    @objc func menuToggled() {
        self.collectionView.collectionViewLayout.invalidateLayout()
    }
    
}

//MARK: - SEARCHBAR DELEGATES
extension ClientListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else {
            return
        }
        
        clientList = [Client]()
        getClientList()
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension ClientListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.deselectItem(at: indexPath, animated: true)
        
        let clientInfoVC = ContactsViewController()
        clientInfoVC.client = clientList[indexPath.row]
        
        DataHolder.sharedInstance.selectedClient = clientList[indexPath.row]
        
        self.navigationController?.pushViewController(clientInfoVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return clientList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClientsListCollectionViewCell
        
        if clientList.count > indexPath.row {
            cell.setupCell(client: clientList[indexPath.row])
        }

        if indexPath.row == clientList.count - 1 {
            if totalClients > clientList.count {
                getClientList()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DataHolder.sharedInstance.menuExpanded {
            return CGSize(width: (self.view.frame.size.width - 30) / 3, height: self.view.frame.size.height / 3.7)
        } else {
            return CGSize(width: (self.view.frame.size.width - 40) / 4, height: self.view.frame.size.height / 3.7)
        }
    }
}

//MARK: - API COMMUNICATION
extension ClientListViewController {
    func createRequestForClientList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let employeeInfo = UserPersistance.sharedInstance.getEmployee()
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber ?? 0, "Language": employeeInfo?.Language ?? ""], "RequestInfo": ["Skip": clientList.count, "Take": 30, "EmployeeId": employeeInfo?.EmployeeId ?? 0, "OrderBy": 1, "SearchString": navigationItem.searchController?.searchBar.text ?? ""]]
        
        
        
        return dict
    }
    
    func getClientList() {
        activityIndicator.startAnimating()
        ApiManager.sharedInstance.getClientList(params: createRequestForClientList()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let clientListInfo = responseData["ClientListInfo"] as? [String:Any] ?? [:]
                let clientList = responseData["ClientList"] as? [[String:Any]] ?? []
                let decoder = JSONDecoder()
                
                self.totalClients = clientListInfo["Total"] as? Int ?? 0
                for clientJson in clientList {
                    let json = Utilities.sharedInstance.jsonToData(json: clientJson)
                    do {
                        let client = try decoder.decode(Client.self, from: json!)
                        self.clientList.append(client)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                self.activityIndicator.stopAnimating()
                self.collectionView.reloadData()
            } else {
                
            }
        }
    }
}

