//
//  ClientContact.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 30.3.22.
//

import Foundation

struct ClientContact: Codable {
    var LastName: String?
    var City: String?
    var Civility: String?
    var FaxNumber: String?
    var Email: String?
    var Position: String?
    var Web: String?
    var MobileNumber: String?
    var Info: String?
    var IsNew: Bool?
    var FirstName: String?
    var Language: String?
    var FullName: String?
    var ShopNumber: Int?
    var Address: String?
    var PhoneNumber: String?
    var Zip: String?
    var ClientId: Int?
    var ContactId: Int?
}
