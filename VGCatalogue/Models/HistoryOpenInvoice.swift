//
//  HistoryOpenInvoice.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 26.5.22.
//

import Foundation

struct HistoryOpenInvoice: Codable {
    var DocTotal: Double?
    var InvoiceClientNo: Int?
    var IsNew: Bool?
    var ShopNumber: Int?
    var Id: Int?
    var DocOpen: Double?
    var CreditAuthorization: Int?
    var CreditLimit: Int?
    var StatusFlag: Int?
    var DocCount: Int?
    var DocSource: String?
    var DocCurrency: String?
}
