//
//  OrdersHeaderView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 26.4.22.
//

import UIKit

class OrdersHeaderView: UIView {
    
    var bottomLine: UIView!
    var productIDLabel: CustomLabel!
    var productNameLabel: CustomLabel!
    var productQTYLabel: CustomLabel!
    var productPriceLabel: CustomLabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.backgroundColor = .white
        bottomLine = UIView()
        bottomLine.backgroundColor = .systemGray
        
        productIDLabel = CustomLabel(frame: CGRect.zero, text: "Product ID", font: Theme.sharedInstance.fontRegular(size: 15))
        productNameLabel = CustomLabel(frame: CGRect.zero, text: "Product Name", font: Theme.sharedInstance.fontRegular(size: 15))
        productQTYLabel = CustomLabel(frame: CGRect.zero, text: "QTY", font: Theme.sharedInstance.fontRegular(size: 15))
        
        productPriceLabel = CustomLabel(frame: CGRect.zero, text: "Price", font: Theme.sharedInstance.fontRegular(size: 15))
        
        self.addSubview(bottomLine)
        self.addSubview(productIDLabel)
        self.addSubview(productNameLabel)
        self.addSubview(productQTYLabel)
        self.addSubview(productPriceLabel)
    }
    
    func setupConstraints() {
        bottomLine.snp.makeConstraints { make in
            make.bottom.equalTo(self).offset(-10)
            make.left.right.equalTo(self).inset(10)
            make.height.equalTo(1)
        }
        
        productIDLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self)
            make.left.equalTo(self).offset(20)
            make.width.equalTo((self.frame.size.width - 20) * 0.2)
        }
        
        
        productNameLabel.snp.makeConstraints { make in
            make.left.equalTo(productIDLabel.snp.right)
            make.width.equalTo((self.frame.size.width - 20) * 0.5)
            make.centerY.equalTo(self)
            
        }
        
        productQTYLabel.snp.makeConstraints { make in
            make.left.equalTo(productNameLabel.snp.right)
            make.width.equalTo((self.frame.size.width - 20) * 0.15)
            make.centerY.equalTo(self)
        }
        
        productPriceLabel.snp.makeConstraints { make in
            make.left.equalTo(productQTYLabel.snp.right)
            make.width.equalTo((self.frame.size.width - 20) * 0.15)
            make.centerY.equalTo(self)
        }
    }
}
