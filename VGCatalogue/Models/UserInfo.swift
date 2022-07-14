//
//  UserInfo.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 13.5.22.
//

import Foundation

struct UserInfo: Codable {
    let IsNew: Bool?
    let Email: String?
    let CartArticlesNo: Int?
    let ClientNo: Int?
    let LoginNo: Int?
    let EmployeeId: Int?
    let AccessLevel: Int?
    let Language: String?
    let CartNo: Int?
    let CartItemsNo: Int?
    let ShopNumber: Int?
    let SellerId: Int?
}
