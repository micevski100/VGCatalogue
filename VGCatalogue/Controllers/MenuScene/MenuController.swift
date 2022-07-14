//
//  MenuController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 1.3.22.
//

import UIKit

class MenuController: UIViewController {
    
    var split: UISplitViewController!
    var menuTableViewVC: UITableViewController!
    var detailsVC: UIViewController!
    var selectedMenuCell: IndexPath!
    var cellPlaceHolders = [
     ["Clients List", "clients-list-icon_inactive", "clients-list-icon_active"],
     ["Add Client", "add-client-icon_inactive", "add-client-icon_active"],
     ["General Catalog", "general-catalog-icon_inactive", "general-catalog-icon_active"],
     ["About this app", "about-this-app-icon_inactive", "about-this-app-icon_active"],
     ["Settings", "settings-icon_inactive", "settings-icon_active"],
     ["Log Out", "sign-out-icon_inactive", "sign-out-icon_active"]
    ]
    
//MARK: - VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        
        split = UISplitViewController(style: .doubleColumn)
        split.view.backgroundColor = .white
        self.addChild(split)
        self.view.addSubview(split.view)
        split.view.frame = self.view.bounds
        split.view.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        split.didMove(toParent: self)
        split.presentsWithGesture = true
        split.preferredPrimaryColumnWidthFraction = 0.3
        split.delegate = self
        
        menuTableViewVC = UITableViewController(style: .plain)
        menuTableViewVC.tableView.delegate = self
        menuTableViewVC.tableView.dataSource = self
        menuTableViewVC.tableView.register(MenuTableViewCell.self, forCellReuseIdentifier: "cell")
        menuTableViewVC.tableView.separatorStyle = .none
        menuTableViewVC.tableView.selectRow(at: IndexPath(row: 0, section: 0), animated: false, scrollPosition: .none)
        let cell = menuTableViewVC.tableView.cellForRow(at: IndexPath(row: 0, section: 0)) as! MenuTableViewCell
        cell.cellImageView.image = UIImage(named: cellPlaceHolders[0][2])
        selectedMenuCell = IndexPath(row: 0, section: 0)
        
        detailsVC = UINavigationController(rootViewController: ClientListViewController())
        
        split.setViewController(menuTableViewVC, for: .primary)
        split.setViewController(detailsVC, for: .secondary)
    }
}

//MARK: - HELPER FUNCTIONS
extension MenuController {
    func displayMenuOptionForIndexPath(indexPath: IndexPath) {
        if indexPath.row == 0 {
            let vc = UINavigationController(rootViewController: ClientListViewController())
            split.showDetailViewController(vc, sender: self)
        } else if indexPath.row == 1 {
            let vc = UINavigationController(rootViewController: AddClientViewController())
            split.showDetailViewController(vc, sender: self)
        } else if indexPath.row == cellPlaceHolders.count - 1 {
            showLogOutAlertAction()
        } else if indexPath.row == 2 {
            let vc = UINavigationController(rootViewController: GeneralCatalogViewController())
            split.showDetailViewController(vc, sender: self)
        } else if indexPath.row == 3 {
            let vc = UINavigationController(rootViewController: AboutThisAppViewController())
            split.showDetailViewController(vc, sender: self)
        }
    }
    
    func showLogOutAlertAction() {
        let alert = UIAlertController(title: "Are you sure you want to log out?".localized(), message: "", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Yes".localized(), style: UIAlertAction.Style.default, handler: { UIAlertAction in
            UserPersistance.sharedInstance.setuserLoggedIn(loggedIn: false)
            
            let loginVC = LoginViewController()
            loginVC.modalPresentationStyle = .fullScreen
            self.present(loginVC, animated: true)
        }))
        alert.addAction(UIAlertAction(title: "No".localized(), style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

//MARK: - TABLEVIEW DELEGATES
extension MenuController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellPlaceHolders.count
   }
   
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MenuTableViewCell
        cell.setupCell(cellTitle: cellPlaceHolders[indexPath.row][0].localized(), imageName: cellPlaceHolders[indexPath.row][1])
       
       return cell
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
       return UITableView.automaticDimension
   }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // toggle previous selected cell
        var cell = tableView.cellForRow(at: selectedMenuCell) as! MenuTableViewCell
        cell.cellImageView.image = UIImage(named: cellPlaceHolders[selectedMenuCell.row][1])
        
        // toggle current selected cell
        cell = tableView.cellForRow(at: indexPath) as! MenuTableViewCell
        cell.cellImageView.image = UIImage(named: cellPlaceHolders[indexPath.row][2])

        selectedMenuCell = indexPath
        
        // display menu options
        displayMenuOptionForIndexPath(indexPath: indexPath)
   }
}

extension MenuController: UISplitViewControllerDelegate {
    func splitViewController(_ svc: UISplitViewController, willHide column: UISplitViewController.Column) {
        DispatchQueue.main.async {
            DataHolder.sharedInstance.toggleMenuExpanded()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
        }
    }
    
    func splitViewController(_ svc: UISplitViewController, willShow column: UISplitViewController.Column) {
        DispatchQueue.main.async {
            DataHolder.sharedInstance.toggleMenuExpanded()
            NotificationCenter.default.post(name: NSNotification.Name(rawValue: "MenuToggleNotification"), object: nil)
        }
    }
}
