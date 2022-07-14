//
//  ClientInfoViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 29.3.22.
//

import UIKit

class ContactsViewController: UIViewController {
    
    var client: Client!
    var clientContactsCollectionView: UICollectionView!
    var totalContacts: Int = 0
    var contactList = [ClientContact]()
    var filteredData = [ClientContact]()

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getClientContacts()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = client.CompanyName ?? client.CompanyName2 ?? ""
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "plus.circle"), style: .plain, target: self, action: #selector(addContactButtonTapped))
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        clientContactsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        clientContactsCollectionView.backgroundColor = .clear
        clientContactsCollectionView.delegate = self
        clientContactsCollectionView.dataSource = self
        clientContactsCollectionView.register(ClientsListCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(clientContactsCollectionView)
    }
    
    func setupConstraints() {
        clientContactsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalTo(self.view).inset(10)
        }
    }
}

//MARK: - COLLECTIONVIEW DELEGATES
extension ContactsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.filteredData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ClientsListCollectionViewCell
        cell.setupContactCell(contact: filteredData[indexPath.row])
        
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        DataHolder.sharedInstance.selectedContact = contactList[indexPath.row]
        
        let clientProductsVC = ProductsViewController()
        self.navigationController?.pushViewController(clientProductsVC, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DataHolder.sharedInstance.menuExpanded {
            return CGSize(width: (self.view.frame.size.width - 30) / 3, height: self.view.frame.size.height / 3.7)
        } else {
            return CGSize(width: (self.view.frame.size.width - 40) / 4, height: self.view.frame.size.height / 3.7)
        }
    }
}

//MARK: - SEARCHBAR DELEGATES
extension ContactsViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText == "" {
            filteredData = contactList
            clientContactsCollectionView.reloadData()
        } else {
            filteredData = [ClientContact]()
            for contact in contactList {    
                if let contactName = contact.FullName {
                    if contactName.contains(searchText) {
                        filteredData.append(contact)
                    }
                }
            }
            clientContactsCollectionView.reloadData()
        }
        
    }
}

//MARK: - OBJC FUNCS
extension ContactsViewController {
    @objc func addContactButtonTapped() {
        let vc = AddContactViewController()
        vc.delegate = self
        vc.client = client
        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - API COMMUNICATION
extension ContactsViewController {
    func createRequestForClientContacts() -> [String:Any] {
        let dict = ["UserInfo": ["ShopNumber": client.ShopNumber ?? 0, "Language": client.Language ?? ""], "RequestInfo": ["Skip": 0, "Take": 30, "ClientId": client.ClientId ?? 0, "OrderBy": 0]]
        
        return dict
    }
    
    func getClientContacts() {
        ApiManager.sharedInstance.getClientContacts(params: createRequestForClientContacts()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let contactList = responseData["ContactList"] as? [[String:Any]] ?? []
                let contactListInfo = responseData["ContactListInfo"] as? [String:Any] ?? [:]
                let decoder = JSONDecoder()
                
                self.totalContacts = contactListInfo["Total"] as? Int ?? 0
                
                for contactJson in contactList {
                    let json = Utilities.sharedInstance.jsonToData(json: contactJson)
                    do {
                        let contact = try decoder.decode(ClientContact.self, from: json!)
                        self.contactList.append(contact)
                        self.filteredData.append(contact)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                self.clientContactsCollectionView.reloadData()
            } else {
                
            }
        }
    }
}

//MARK: - ADD CONTACT DELEGATES
extension ContactsViewController: AddContactProtocol {
    func reloadData() {
        contactList = [ClientContact]()
        filteredData = [ClientContact]()
        getClientContacts()
    }
}


//extension ContactsViewController: UISplitViewControllerDelegate {
//    func splitViewController(_ svc: UISplitViewController, willHide column: UISplitViewController.Column) {
//        DispatchQueue.main.async {
//            DataHolder.sharedInstance.toggleMenuExpanded()
//            self.clientContactsCollectionView.collectionViewLayout.invalidateLayout()
//        }
//    }
//
//    func splitViewController(_ svc: UISplitViewController, willShow column: UISplitViewController.Column) {
//        DispatchQueue.main.async {
//            DataHolder.sharedInstance.toggleMenuExpanded()
//            self.clientContactsCollectionView.collectionViewLayout.invalidateLayout()
//        }
//    }
//}
