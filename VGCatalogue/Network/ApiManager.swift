//
//  ApiManager.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 24.2.22.
//

import Foundation
import Alamofire

typealias CompletitionCallBack = ((_ success: Bool, _ responseObject: [String:Any]?,_ statusCode : Int?)-> ())?

class ApiManager {

    static let sharedInstance = ApiManager()

//MARK: - MAIN FUNCTIONS
    private func executeRequest(request : URLRequestConvertible, completitionCallback : CompletitionCallBack) {
        AF.request(request).responseJSON { (response) in
            switch response.result {
                case .success(let value):
                let json = value as? [String:Any]
                var statusCode = 200
                if let res = response.response {
                    statusCode = res.statusCode
                    if statusCode == 200 {
                        completitionCallback!(true,json,statusCode)
                    } else {
                        completitionCallback!(false,json,statusCode)
                    }
                }
            case .failure(_):
                if let res = response.response {
                    let statusCode = res.statusCode
                    completitionCallback!(false,nil,statusCode)
                } else {
                    completitionCallback!(false,nil,nil)
                }
            }
        }
    }

//MARK: - ERP LOGIN
    func erpLogin(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ERPLogin(params)) { (success, responseData, statusCode) in
            completition!(success,responseData, statusCode)
        }
    }
    
//MARK: - EMPLOYEE LOGIN
    func employeeLogin(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.EmployeeLogin(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - CLIENT LIST
    func getClientList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ClientList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - CLIENT CONTACTS
    func getClientContacts(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ClientContacts(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - ADD CLIENT
    func addClient(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.AddClient(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - ADD CONTACT
    func addContact(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.AddContact(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - PRODUCT LIST
    func productList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ProductList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - EXISTING CART ID
    func getExistingCartId(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ExistingCartId(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
//MARK: - ADD TO CART
    func addToCart(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.AddToCart(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }

//MARK: - LIST ORDERS
    func listOrders(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.ListOrders(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func deliveryList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.DeliveryList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func backLogList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.BackLogList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func invoicesList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.InvoicesList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func openInvoicesList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.OpenInvoicesList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func historyProductsList(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.HistoryProductsList(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
    
    func backLogDetails(params: [String:Any], completition: CompletitionCallBack) {
        executeRequest(request: Router.BacklogDetails(params)) { success, responseObject, statusCode in
            completition!(success, responseObject, statusCode)
        }
    }
}




