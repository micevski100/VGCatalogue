//
//  ImageInfo.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 18.4.22.
//

import Foundation

class ImageInfo: Codable {
    var ShopNumber: Int?
    var ImgPathNormal: String?
    var ImgPathMax: String?
    var IsNew: Bool?
    var ImgPathMin: String?
    var ImgPathOriginal: String?
    var ImgExtension: String?
}
