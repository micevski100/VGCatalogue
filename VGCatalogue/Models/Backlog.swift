//
//  Backlog.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 26.5.22.
//

import Foundation

struct Backlog: Codable {
    var DocTotal: Double?
    var IsNew: Bool?
    var DocStatusFlag: Int?
    var DocStatusName: String?
    var DocDeliveryClient: Int?
    var BottlesCount: Int?
    var DocId: Int?
    var DocInvoiceClient: Int?
    var DocOrderId: Int?
    var DocTotalTax: Double?
    var DocDeliveryDate: String?
    var DocDate: String?
    var DocStatus: Int?
    var ShopNumber: Int?
    var DocCurrency: String?
    
    //    var DocYourRef: String?
    //    var DocOurRef: String?
}
