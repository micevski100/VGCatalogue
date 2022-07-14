//
//  BackgroundImage.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 8.3.22.
//

import Foundation
import UIKit

class CustomImageView: UIImageView {
    
    required init(frame: CGRect, imageName: String, contentMode: ContentMode) {
        super.init(frame: CGRect.zero)
        self.image = UIImage(named: imageName)
        self.layer.masksToBounds = false
        self.clipsToBounds = true
        self.contentMode = contentMode
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
