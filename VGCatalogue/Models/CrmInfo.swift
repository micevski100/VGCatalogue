//
//  CrmInfo.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 28.2.22.
//

import Foundation

struct CrmInfo: Codable {
    let Db: Int?
    let DbPass: String?
    let DbUser: String?
    let Description: String?
    let IsNew: Bool?
    let Language: Int?
    let SBddName: String?
    let SDescription: String?
    let Server: String?
    let ShopNumber: Int?
    let WebSite: String?
}
