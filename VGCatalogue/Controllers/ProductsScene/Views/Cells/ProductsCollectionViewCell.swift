//
//  ProductsCollectionViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 13.4.22.
//

import UIKit
import Kingfisher

class ProductsCollectionViewCell: UICollectionViewCell {
    
    var holderView: UIView!
    var priceLabel: UILabel!
    var priceValueLabel: UILabel!
    var packagingLabel: UILabel!
    var packagingValueLabel: UILabel!
    var barCodeImage: UIImageView!
    var barCodeLabel: UILabel!
    var descriptionLabel: UILabel!
    var productImage: UIImageView!
    var productNameLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.contentView.backgroundColor = .white
        
        holderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        
        
        priceLabel = CustomLabel(frame: CGRect.zero, text: "Price:", font: Theme.sharedInstance.fontRegular(size: 20))

        priceValueLabel = CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        packagingLabel = CustomLabel(frame: CGRect.zero, text: "Packaging:", font: Theme.sharedInstance.fontRegular(size: 20))
        
        packagingValueLabel = CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        barCodeLabel = CustomLabel(frame: CGRect.zero, text: "", font: Theme.sharedInstance.fontRegular(size: 20))
        
        descriptionLabel = CustomLabel(frame: CGRect.zero, text: "", font: Theme.sharedInstance.fontRegular(size: 20))
        descriptionLabel.numberOfLines = 2
        descriptionLabel.lineBreakMode = .byWordWrapping
        
        productNameLabel = CustomLabel(frame: CGRect.zero, text: "", font: Theme.sharedInstance.fontRegular(size: 20))
        
        barCodeImage = UIImageView()
        
        productImage = UIImageView()
        productImage.contentMode = .scaleAspectFit
        
        
        self.contentView.addSubview(holderView)
        self.contentView.addSubview(priceLabel)
        self.contentView.addSubview(priceValueLabel)
        self.contentView.addSubview(packagingLabel)
        self.contentView.addSubview(packagingValueLabel)
        self.contentView.addSubview(barCodeImage)
        self.contentView.addSubview(barCodeLabel)
        self.contentView.addSubview(descriptionLabel)
        self.contentView.addSubview(productImage)
        self.contentView.addSubview(productNameLabel)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self).inset(10)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(holderView).offset(-5)
            make.left.equalTo(holderView).offset(10)
            make.height.equalTo(25)
        }
        
        priceValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(holderView).offset(-5)
            make.height.equalTo(25)
            make.right.equalTo(holderView.snp.right).offset(-10)
        }
        
        packagingLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceLabel.snp.top).offset(-5)
            make.height.equalTo(25)
            make.left.equalTo(holderView).offset(10)
        }
        
        packagingValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceLabel.snp.top).offset(-5)
            make.height.equalTo(25)
            make.right.equalTo(holderView).offset(-10)
        }
        
        barCodeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(packagingLabel.snp.top).offset(-5)
            make.height.equalTo(25)
            make.centerX.equalTo(self.contentView)
        }
        
        barCodeImage.snp.makeConstraints { make in
            make.bottom.equalTo(barCodeLabel.snp.top)
            make.height.equalTo(self.contentView.frame.size.height / 6)
            make.left.right.equalTo(holderView).inset(20)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.bottom.equalTo(barCodeImage.snp.top).offset(-5)
            make.left.right.equalTo(holderView).inset(5)
            make.height.equalTo(25)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.bottom.equalTo(descriptionLabel.snp.top).offset(-10)
            make.centerX.equalTo(holderView)
            make.height.equalTo(25)
        }
        
        productImage.snp.makeConstraints { make in
            make.top.left.right.equalTo(holderView).inset(20)
            make.bottom.equalTo(productNameLabel.snp.top).offset(-20)
        }
    }
    
    func setupCell(product: Product, imageInfo: ImageInfo, forGeneralCatalog: Bool) {
        if (forGeneralCatalog) {
            priceValueLabel.text = product.BasePrice! + " " + product.PriceCurrency!
            packagingValueLabel.text = product.UnitCode
            barCodeLabel.text = product.BarCode!
            productNameLabel.text = product.ProductCode!
            
            if product.BarCode! != "" {
                barCodeImage.image = generateBarcode(from: product.BarCode!)
            } else {
                barCodeImage.isHidden = true
                barCodeLabel.isHidden = true
                descriptionLabel.snp.remakeConstraints { make in
                    make.bottom.equalTo(packagingLabel.snp.top).offset(-10)
                    make.left.right.equalTo(holderView).inset(5)
                    make.height.equalTo(25)
                }
            }
            
            var imageName = product.ImageNameCalculated
            if imageName == nil || imageName == "" {
                imageName = product.ImageName
            }
            
            if let imageName = imageName {
                var path = imageInfo.ImgPathNormal! + imageName
                path = path.replacingOccurrences(of: " ", with: "%20")
                
                if path.contains(".jpg") || path.contains(".JPG") || path.contains(".jpeg") || path.contains(".png") {
                    productImage.kf.setImage(with: URL(string: path))
                } else {
                    productImage.image = UIImage(named: "noImageAvailable")
                }
            }
            
            
            descriptionLabel.text = product.Description
        } else {
            priceValueLabel.text = product.BasePrice! + " " + product.PriceCurrency!
            packagingValueLabel.text = product.UnitCode
            barCodeLabel.text = product.BarCode!
            productNameLabel.text = product.ProductCode!
            
            if product.BarCode! != "" {
                barCodeImage.image = generateBarcode(from: product.BarCode!)
            } else {
                // this was commented out
                barCodeImage.isHidden = true
                barCodeLabel.isHidden = true
                descriptionLabel.snp.remakeConstraints { make in
                    make.bottom.equalTo(packagingLabel.snp.top).offset(-10)
                    make.left.right.equalTo(holderView).inset(5)
                    make.height.equalTo(25)
                }
            }
            
            var imageName = product.ImageNameCalculated
            if imageName == nil || imageName == "" {
                imageName = product.ImageName
            }
            
            if let imageName = imageName {
                var path = imageInfo.ImgPathNormal! + imageName
                path = path.replacingOccurrences(of: " ", with: "%20")
                print(path)
                if path.contains(".jpg") || path.contains(".JPG") || path.contains(".jpeg") || path.contains(".png") {
                    productImage.kf.setImage(with: URL(string: path))
                } else {
                    productImage.image = UIImage(named: "noImageAvailable")
                }
            }
            
            
            descriptionLabel.text = product.Description
        }
    }
    
    func generateBarcode(from string: String) -> UIImage? {
        let data = string.data(using: String.Encoding.ascii)

        if let filter = CIFilter(name: "CICode128BarcodeGenerator") {
            filter.setValue(data, forKey: "inputMessage")
            let transform = CGAffineTransform(scaleX: 3, y: 3)

            if let output = filter.outputImage?.transformed(by: transform) {
                return UIImage(ciImage: output)
            }
        }

        return nil
    }
}
