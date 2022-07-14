//
//  OrdersTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 26.4.22.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    var productIDLabel: CustomLabel!
    var productNameLabel: CustomLabel!
    var productQTYTextField: UITextField!
    var productPriceLabel: CustomLabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        productIDLabel = CustomLabel(frame: CGRect.zero, text: "Product ID", font: Theme.sharedInstance.fontRegular(size: 15))
        
        productNameLabel = CustomLabel(frame: CGRect.zero, text: "Product Name", font: Theme.sharedInstance.fontRegular(size: 15))
        
        productQTYTextField = UITextField()
        productQTYTextField.font = Theme.sharedInstance.fontRegular(size: 15)
        
        productPriceLabel = CustomLabel(frame: CGRect.zero, text: "Product Price", font: Theme.sharedInstance.fontRegular(size: 15))
        
        self.contentView.addSubview(productIDLabel)
        self.contentView.addSubview(productNameLabel)
        self.contentView.addSubview(productQTYTextField)
        self.contentView.addSubview(productPriceLabel)
    }
    
    func setupConstraints() {
        productIDLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.contentView)
            make.width.equalTo(self.contentView).multipliedBy(0.2)
//            make.width.equalTo((self.contentView.frame.size.width - 20) * 0.2)
            make.left.equalTo(self.contentView)
        }
        
        productNameLabel.snp.makeConstraints { make in
            make.left.equalTo(self.productIDLabel.snp.right)
//            make.width.equalTo((self.contentView.frame.size.width - 20) * 0.5)
            make.width.equalTo(self.contentView).multipliedBy(0.5)
            make.centerY.equalTo(self.contentView)
        }
        
        productQTYTextField.snp.makeConstraints { make in
            make.left.equalTo(self.productNameLabel.snp.right)
            make.centerY.equalTo(self.contentView)
//            make.width.equalTo((self.contentView.frame.size.width - 20) * 0.15)
            make.width.equalTo(self.contentView).multipliedBy(0.15)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(self.productQTYTextField.snp.right)
//            make.width.equalTo((self.contentView.frame.size.width - 20) * 0.15)
            make.width.equalTo(self.contentView).multipliedBy(0.15)
            make.centerY.equalTo(self.contentView)
        }
    }
    
    func setupCell(product: Product) {
        productIDLabel.text = product.Product ?? "No product code"
        productNameLabel.text = product.Descr ?? "No product name"
        productQTYTextField.text = "\(product.Qty ?? 0)"
        if let productPrice = product.Total {
            productPriceLabel.text = "\(productPrice)"
        } else {
            productPriceLabel.text = "No product price"
        }
    }
}
