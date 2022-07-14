//
//  ProductsViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 19.4.22.
//

import UIKit

class ProductsViewController: UIViewController {

    var productsCollectionView: UICollectionView!
    var totalProducts = 0
    var productList = [Product]()
    var imageInfo: ImageInfo!
    var shoppingCartButton: BadgedButtonItem!
    var historyButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
        getProductList()
        NotificationCenter.default.addObserver(self, selector: #selector(menuToggled), name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.productsCollectionView.collectionViewLayout.invalidateLayout()
        getExistingCartId()
        
    }

    
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "Products"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        historyButton = UIBarButtonItem(image: UIImage(systemName: "clock.arrow.2.circlepath"), style: .plain, target: self, action: #selector(historyButtonTapped))
        historyButton.tintColor = .black
        shoppingCartButton = BadgedButtonItem(with: UIImage(systemName: "cart.fill"))
        shoppingCartButton.badgeTextColor = .white
        shoppingCartButton.badgeTintColor = .red
        shoppingCartButton.position = .right
        shoppingCartButton.hasBorder = true
        shoppingCartButton.borderColor = .red
        shoppingCartButton.badgeSize = .small
        shoppingCartButton.badgeAnimation = true
        shoppingCartButton.setBadge(with: 1)
        shoppingCartButton.tapAction = {
            let vc = OrdersViewController2()
            self.navigationController?.pushViewController(vc, animated: true)
        }


        
        navigationItem.rightBarButtonItems = [shoppingCartButton, historyButton]
        
        let searchBar = UISearchController()
        searchBar.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchBar
        
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 5
        layout.minimumLineSpacing = 5
        
        productsCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        productsCollectionView.backgroundColor = .clear
        productsCollectionView.delegate = self
        productsCollectionView.dataSource = self
        productsCollectionView.register(ProductsCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        
        self.view.addSubview(productsCollectionView)
    }
    
    func setupConstraints() {
        productsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.right.bottom.equalTo(self.view).inset(10)
            make.bottom.equalTo(self.view)
        }
    }
    
    @objc func menuToggled() {
        self.productsCollectionView.collectionViewLayout.invalidateLayout()
    }
}


extension ProductsViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard searchController.searchBar.text != nil else {
            return
        }
        
    }
}


extension ProductsViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return productList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = productsCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductsCollectionViewCell
        cell.setupCell(product: productList[indexPath.row], imageInfo: imageInfo, forGeneralCatalog: false)
        
        if indexPath.row == productList.count - 1 {
            if totalProducts > productList.count {
                getProductList()
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = ProductDetailsViewController()
        vc.product = productList[indexPath.row]
        vc.imageInfo = imageInfo
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if DataHolder.sharedInstance.menuExpanded {
            if UIScreen.main.bounds.height <= 810 {
                return CGSize(width: (self.view.frame.size.width - 40) / 2, height: self.view.frame.size.height / 1.5)
            } else {
                return CGSize(width: (self.view.frame.size.width - 40) / 3, height: self.view.frame.size.height / 1.8)
            }
        } else {
            if UIScreen.main.bounds.height <= 810 {
                return CGSize(width: (self.view.frame.size.width - 40) / 3, height: self.view.frame.size.height / 1.5)
            } else {
                return CGSize(width: (self.view.frame.size.width - 40) / 4, height: self.view.frame.size.height / 1.8)
            }
        }
    }
}


//MARK: - API COMMUNICATION
extension ProductsViewController {
    func createRequestForExistingCartId() -> [String:Any] {
        // UserInfo {ShopNumber, ClientNo,LoginNo,EmployeeId,Language,CartNo}
        // RequestInfo {DeliveryClientId,DeviceGuid?,EmployeeId}
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber ?? 0,
                                 "ClientNo": contact?.ClientId,
                                 "LoginNo": userInfo?.LoginNo,
                                 "EmployeeId": employee?.EmployeeId],
                    "RequestInfo": ["DeliveryClientId": contact?.ClientId,
                                    "EmployeeId": employee?.EmployeeId]]
        
        return dict
    }
    
    func getExistingCartId() {
        ApiManager.sharedInstance.getExistingCartId(params: createRequestForExistingCartId()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                DataHolder.sharedInstance.existingCartId = responseData["ExistingCartId"] as? Int ?? 0
            } else {
                
            }
        }
    }
    
    func createRequestForProductList() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let clientID = DataHolder.sharedInstance.selectedClient?.ClientId
        
        let dict = ["UserInfo": ["ShopNumber": crmInfo?.ShopNumber ?? 0, "Language": crmInfo?.Language ?? ""], "RequestInfo": ["Skip": productList.count, "Take": 30, "OrderBy": 6, "SearchString": navigationItem.searchController?.searchBar.text ?? "", "ClientId": clientID ?? 0]]
        
        return dict
    }
    
    func getProductList() {
        ApiManager.sharedInstance.productList(params: createRequestForProductList()) { success, responseObject, statusCode in
            if success {
                let responseData = responseObject?["ResponseData"] as? [String:Any] ?? [:]
                let productListInfo = responseData["ProductListInfo"] as? [String:Any] ?? [:]
                let productList = responseData["ProductList"] as? [[String:Any]] ?? []
                self.totalProducts = productListInfo["Total"] as? Int ?? 0
                let decoder = JSONDecoder()
                
                let imageInfoJSON = responseData["ImagesInfo"]
                let json = Utilities.sharedInstance.jsonToData(json: imageInfoJSON ?? [:])
                do {
                    self.imageInfo = try decoder.decode(ImageInfo.self, from: json!)
                } catch {
                    print(error.localizedDescription)
                }
                
                
                for productJson in productList {
                    let json = Utilities.sharedInstance.jsonToData(json: productJson)
                    do {
                        let client = try decoder.decode(Product.self, from: json!)
                        self.productList.append(client)
                    } catch {
                        print(error.localizedDescription)
                    }
                }
                
                self.productsCollectionView.reloadData()
            } else {
                
                
            }
        }
    }
}


extension ProductsViewController {
    
    @objc func historyButtonTapped() {
        let vc = HistoryViewController()
        self.navigationController?.pushViewController(vc, animated: true)
    }
}
