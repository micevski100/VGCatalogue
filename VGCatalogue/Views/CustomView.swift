//
//  HolderView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 8.3.22.
//

import Foundation
import UIKit

class CustomView: UIView {
    
    // change name to customview
    
    // add shadow
    required init(frame: CGRect, backgroundColor: UIColor, cornerRadius: CGFloat) {
        super.init(frame: CGRect.zero)
        self.backgroundColor = backgroundColor
        self.layer.cornerRadius = cornerRadius
        self.layer.borderColor = UIColor.black.cgColor
        self.layer.shadowColor = UIColor.systemGray.cgColor
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowRadius = 10
        self.layer.shadowOffset = CGSize.zero
        self.layer.shadowOpacity = 0.5
        self.layer.masksToBounds = false
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
