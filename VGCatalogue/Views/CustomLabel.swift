//
//  CustomLabel.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 8.3.22.
//

import Foundation
import UIKit

class CustomLabel: UILabel {
    
    // text, text color, font
    required init(frame: CGRect, text: String, font: UIFont) {
        super.init(frame: CGRect.zero)
        
        self.text = text
        self.font = font
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
