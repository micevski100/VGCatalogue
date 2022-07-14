//
//  DataHolder.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 19.4.22.
//

import Foundation

class DataHolder {
    static let sharedInstance = DataHolder()
    var selectedClient: Client?
    var selectedContact: ClientContact?
    var existingCartId: Int?
    var menuExpanded: Bool = true
    
    func toggleMenuExpanded() {
        menuExpanded = !menuExpanded
    }
}
