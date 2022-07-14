//
//  Utilities.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 22.2.22.
//

import Foundation
import UIKit

class Utilities {
    static let sharedInstance = Utilities()
    
    //MARK: - Get Max Length
    func getMaxLength() -> CGFloat {
        let bounds = UIScreen.main.bounds
        let maxLength = max(bounds.width, bounds.height)
     
        return maxLength
    }
    
    func createHolderView(color: UIColor, cornerRadius: CGFloat) -> UIView {
        let holderView = UIView()
        holderView.backgroundColor = color
        holderView.layer.cornerRadius = cornerRadius
        holderView.layer.masksToBounds = true
        
        return holderView
    }
    
    func createBackgroundImage(imageName: String) -> UIImageView {
        let backgroundImageView = UIImageView()
        backgroundImageView.image = UIImage(named: imageName)
        backgroundImageView.layer.masksToBounds = false
        backgroundImageView.clipsToBounds = true
        
        return backgroundImageView
    }
    
    func createLabel(text: String, textColor: UIColor) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        
        return label
    }
    
    func createButton(title: String, imageName: String, color: UIColor ) -> UIButton {
        let button = UIButton()
        
        if title != "" {
            // create button with title
            button.setTitle(title, for: .normal)
            button.layer.backgroundColor = color.cgColor
            button.layer.cornerRadius = 10
        } else {
            // create button with image
            button.setImage(UIImage(systemName: imageName), for: .normal)
            button.tintColor = color
        }
        
        return button
    }
    
    func hexStringToUIColor (hex:String) -> UIColor {
        var cString:String = hex.trimmingCharacters(in: .whitespacesAndNewlines).uppercased()

        if (cString.hasPrefix("#")) {
            cString.remove(at: cString.startIndex)
        }

        if ((cString.count) != 6) {
            return UIColor.gray
        }

        var rgbValue:UInt64 = 0
        Scanner(string: cString).scanHexInt64(&rgbValue)

        return UIColor(
            red: CGFloat((rgbValue & 0xFF0000) >> 16) / 255.0,
            green: CGFloat((rgbValue & 0x00FF00) >> 8) / 255.0,
            blue: CGFloat(rgbValue & 0x0000FF) / 255.0,
            alpha: CGFloat(1.0)
        )
    }
    
    
    
    func jsonToData(json: Any) -> Data? {
          do {
              return try JSONSerialization.data(withJSONObject: json, options: JSONSerialization.WritingOptions.prettyPrinted)
          } catch let myJSONError {
              print(myJSONError)
          }
          return nil;

      }
    
}
