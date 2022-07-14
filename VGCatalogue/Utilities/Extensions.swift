//
//  Extensions.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 23.2.22.
//

import Foundation


extension String {
    func localized() -> String {
        return NSLocalizedString(self, tableName: "Localizable", bundle: .main, value: self, comment: self)
    }
}


