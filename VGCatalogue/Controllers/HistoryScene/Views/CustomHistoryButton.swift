//
//  CustomHistoryButton.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 6.5.22.
//

import Foundation
import UIKit

class CustomHistoryButton: UIButton {
    
    
    init(frame: CGRect, title: String?, tag: Int) {
        super.init(frame: CGRect.zero)
        self.tag = tag
        self.configuration = .plain()
        self.setTitle(title, for: .normal)
        self.tintColor = .black
        self.titleLabel?.textAlignment = .center
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}
