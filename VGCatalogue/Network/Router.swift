//
//  Router.swift
//  KingFisherTest
//
//  Created by Aleksandar Micevski on 4.1.22.
//

import Foundation
import Alamofire

enum Router: URLRequestConvertible {
    
    case ERPLogin([String:Any])
    case EmployeeLogin([String:Any])
    case ClientList([String:Any])
    case ClientContacts([String:Any])
    case AddClient([String:Any])
    case AddContact([String:Any])
    case ProductList([String:Any])
    case ExistingCartId([String:Any])
    case AddToCart([String:Any])
    case ListOrders([String:Any])
    case DeliveryList([String:Any])
    case BackLogList([String:Any])
    case InvoicesList([String:Any])
    case OpenInvoicesList([String:Any])
    case HistoryProductsList([String:Any])
    case BacklogDetails([String:Any])
    
    var method: Alamofire.HTTPMethod {
        switch self {
        default:
            return .post
        }
    }
    
    var path: String {
        switch self {
        case .ERPLogin:
            return Constants.Network.EndPoints.erplogin
        case.EmployeeLogin:
            return Constants.Network.EndPoints.employeelogin
        case .ClientList:
            return Constants.Network.EndPoints.clientList
        case .ClientContacts:
            return Constants.Network.EndPoints.contactListByClient
        case .AddClient:
            return Constants.Network.EndPoints.addClient
        case .AddContact:
            return Constants.Network.EndPoints.addContact
        case .ProductList:
            return Constants.Network.EndPoints.productList
        case .ExistingCartId:
            return Constants.Network.EndPoints.existingCartId
        case .AddToCart:
            return Constants.Network.EndPoints.addToCart
        case .ListOrders:
            return Constants.Network.EndPoints.ordersList
        case .DeliveryList:
            return Constants.Network.EndPoints.deliveryList
        case .BackLogList:
            return Constants.Network.EndPoints.backLogList
        case .InvoicesList:
            return Constants.Network.EndPoints.invoicesList
        case .OpenInvoicesList:
            return Constants.Network.EndPoints.openInvoicesList
        case .HistoryProductsList:
            return Constants.Network.EndPoints.historyProductsList
        case .BacklogDetails:
            return Constants.Network.EndPoints.backlogDetails
        }
    }
    
    var parameters: [String:Any] {
        switch self {
        case .ERPLogin(let param):
            return param
        case .EmployeeLogin(let param):
            return param
        case .ClientList(let param):
            return param
        case .ClientContacts(let param):
            return param
        case .AddClient(let param):
            return param
        case .AddContact(let param):
            return param
        case .ProductList(let param):
            return param
        case .ExistingCartId(let param):
            return param
        case .AddToCart(let param):
            return param
        case .ListOrders(let param):
            return param
        case .DeliveryList(let param):
            return param
        case .BackLogList(let param):
            return param
        case .InvoicesList(let param):
            return param
        case .OpenInvoicesList(let param):
            return param
        case .HistoryProductsList(let param):
            return param
        case .BacklogDetails(let param):
            return param
        }
    }
    
    var header: [String:String] {
        switch self {
        case .ERPLogin:
            return Constants.Network.erpHeader
        case.EmployeeLogin:
            return Constants.Network.crmHeader
        default:
            return Constants.Network.headers ?? [:]
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        var urlRequest : URLRequest!
        let url: URL!
        
        switch(self) {
        case .ERPLogin:
            url = URL(string: Constants.Network.baseERPURL + path)
        default:
            url = URL(string: Constants.Network.baseEployeeLoginURL + path) 
        }
        
        urlRequest = URLRequest(url: url!)
        urlRequest.httpMethod = method.rawValue
        urlRequest.allHTTPHeaderFields = header
        
        if (method.rawValue != "GET") {
           urlRequest.httpBody =  try JSONSerialization.data(withJSONObject: self.parameters, options: .prettyPrinted)
       }

        return urlRequest
    }
}
