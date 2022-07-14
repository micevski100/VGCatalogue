//
//  CustomButton.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 8.3.22.
//

import Foundation
import UIKit

class CustomButton: UIButton {
    
    init(frame: CGRect, title: String?, backgroundColor: UIColor?, imageName: String?, tintColor: UIColor?) {
        super.init(frame: CGRect.zero)
        
        if (title != nil && backgroundColor != nil) {
            self.setTitle(title, for: .normal)
            self.backgroundColor = backgroundColor
        } else {
            if (imageName != nil && tintColor != nil) {
                self.setBackgroundImage(UIImage(systemName: imageName!), for: .normal)
                self.tintColor = tintColor
            }
        }
        
        self.titleLabel?.font =  UIFont(name: "Tajawal-ExtraBold", size: 20)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
