//
//  Theme.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 23.2.22.
//

import Foundation
import UIKit

class Theme {
    
    static let sharedInstance = Theme()
    
    func themeBlueColor() -> UIColor {
        return Utilities.sharedInstance.hexStringToUIColor(hex: "#2350F9")
    }
    
    func themeGrayColor() -> UIColor {
        return Utilities.sharedInstance.hexStringToUIColor(hex: "#A0A8B1")
    }
    
    func fontBlack(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-Black", size: size) ?? UIFont()
    }
    
    func fontBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-Bold", size: size) ?? UIFont()
    }
    
    func fontExtraBold(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-ExtraBold", size: size) ?? UIFont()
    }
    
    func fontExtraLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-ExtraLight", size: size) ?? UIFont()
    }
    
    func fontLight(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-Light", size: size) ?? UIFont()
    }
    
    func fontMedium(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-Medium", size: size) ?? UIFont()
    }
    
    func fontRegular(size: CGFloat) -> UIFont {
        return UIFont(name: "Tajawal-Regular", size: size) ?? UIFont()
    }
    
}
