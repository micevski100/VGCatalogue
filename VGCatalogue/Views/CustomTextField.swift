//
//  CustomTextField.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 21.2.22.
//

import UIKit

class CustomTextField: UITextField {
    
    var isSecureEntry: Bool!
    var imageName: String!
    var button: UIButton!
    
    init(frame: CGRect, isSecureEntry: Bool, imageName: String, font: UIFont) {
        super.init(frame: frame)
        self.isSecureEntry = isSecureEntry
        self.imageName = imageName
        self.font = font
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTextField() {
        button = Utilities.sharedInstance.createButton(title: "", imageName: self.imageName, color: .systemGray)
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        self.borderStyle = .none
        self.isSecureTextEntry = isSecureEntry
        self.rightViewMode = .always
        self.rightView = button
        self.autocorrectionType = .no
    }
    
    @objc func buttonTapped() {
        if imageName == "xmark.circle.fill" {
            self.text = ""
        } else if imageName == "eye" {
            isSecureEntry = !isSecureEntry
            self.isSecureTextEntry = isSecureEntry
            
            if isSecureTextEntry {
                button.setImage(UIImage(systemName: "eye"), for: .normal)
            } else {
                button.setImage(UIImage(systemName: "eye.slash"), for: .normal)
            }
        }
    }
}
