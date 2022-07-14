//
//  Constants.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 24.2.22.
//

import Foundation

struct Constants {
    
    struct Network {
        static let baseERPURL = "http://erpdev.vgasp.ch/api/v01"
        static let erpHeader = ["Content-Type": "application/json","x-provider": "erp"]
        
        static let baseEployeeLoginURL = "http://crmdev.vgasp.ch/api/v01"
        static let crmHeader = ["Content-Type": "application/json","x-provider": "crm"]
        
        static let headers = ["Content-Type": "application/json","x-provider": "crm", "Authorization": UserPersistance.sharedInstance.getAccessToken()] as? [String : String] 
        
        struct EndPoints {
            static let erplogin = "/erp/vgerp/nosubsection/vgerp/login"
            static let employeelogin = "/crm/cotfer/nosection/employee/login"
            static let clientList = "/crm/cotfer/nosection/client/list"
            static let contactListByClient = "/crm/cotfer/nosection/contact/list_byclient"
            static let addClient = "/crm/cotfer/nosection/client/add"
            static let addContact = "/crm/cotfer/nosection/contact/add"
            static let productList = "/crm/cotfer/nosection/product/list"
            static let existingCartId = "/crm/cotfer/nosection/cart/existingcartid"
            static let addToCart = "/crm/cotfer/nosection/cartdetails/add"
            static let ordersList = "/crm/cotfer/nosection/cartdetails/list"
            static let deliveryList = "/crm/cotfer/nosection/client/deliverylist"
            static let backLogList = "/crm/rvgContacts/nosection/backlog/list"
            static let invoicesList = "/crm/rvgContacts/nosection/History/list"
            static let openInvoicesList = "/crm/rvgContacts/nosection/OpenAccount/list"
            static let historyProductsList = "/crm/rvgContacts/nosection/History/products"
            static let backlogDetails = "/crm/rvgContacts/nosection/backlog/details"
        }

    }
}
