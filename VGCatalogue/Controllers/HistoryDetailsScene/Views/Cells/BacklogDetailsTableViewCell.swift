//
//  BacklogDetailsTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 31.5.22.
//

import UIKit

class BacklogDetailsTableViewCell: UITableViewCell {
    
    var holderView: CustomView!
    var nameLabel: CustomLabel!
    var descriptionLabel: CustomLabel!
    var quantityLabel: CustomLabel!
    var quantityValueLabel: CustomLabel!
    var priceLabel: CustomLabel!
    var priceValueLabel: CustomLabel!
    var unitLabel: CustomLabel!
    var unitValueLabel: CustomLabel!
    var statusLabel: CustomLabel!
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.selectionStyle = .none
        
        holderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        
        nameLabel = CustomLabel(frame: CGRect.zero, text: "Name", font: Theme.sharedInstance.fontRegular(size: 20))
        
        descriptionLabel = CustomLabel(frame: CGRect.zero, text: "Description", font: Theme.sharedInstance.fontRegular(size: 20))
        
        quantityLabel = CustomLabel(frame: CGRect.zero, text: "Quantity", font: Theme.sharedInstance.fontRegular(size: 20))
        
        quantityValueLabel = CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        priceLabel = CustomLabel(frame: CGRect.zero, text: "Price", font: Theme.sharedInstance.fontRegular(size: 20))
        
        priceValueLabel = CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        unitLabel = CustomLabel(frame: CGRect.zero, text: "Unit", font: Theme.sharedInstance.fontRegular(size: 20))
        
        unitValueLabel = CustomLabel(frame: CGRect.zero, text: "0 x Pack*0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        statusLabel = CustomLabel(frame: CGRect.zero, text: "Status", font: Theme.sharedInstance.fontRegular(size: 20))
        
        holderView.addSubview(quantityLabel)
        holderView.addSubview(quantityValueLabel)
        holderView.addSubview(priceLabel)
        holderView.addSubview(priceValueLabel)
        holderView.addSubview(unitLabel)
        holderView.addSubview(unitValueLabel)
        holderView.addSubview(statusLabel)
        holderView.addSubview(nameLabel)
        holderView.addSubview(descriptionLabel)
        
        self.contentView.addSubview(holderView)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(10)
        }
        
        statusLabel.snp.makeConstraints { make in
            make.bottom.equalTo(holderView).offset(-10)
            make.left.equalTo(holderView).offset(10)
        }
        
        quantityValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(statusLabel.snp.top).offset(-20)
            make.centerX.equalTo(quantityLabel.snp.centerX)
        }
        
        quantityLabel.snp.makeConstraints { make in
            make.bottom.equalTo(quantityValueLabel.snp.top).offset(-10)
            make.left.equalTo(holderView).offset(self.contentView.frame.size.width / 3)
        }
        
        priceValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(quantityValueLabel)
            make.left.equalTo(self.contentView.snp.centerX)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceValueLabel.snp.top).offset(-10)
            make.left.equalTo(self.contentView.snp.centerX)
        }
        
        unitValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(quantityValueLabel)
            make.centerX.equalTo(unitLabel)
        }
        
        unitLabel.snp.makeConstraints { make in
            make.bottom.equalTo(priceValueLabel.snp.top).offset(-10)
            make.right.equalTo(self.contentView).offset(-self.contentView.frame.size.width / 3)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.equalTo(holderView).offset(10)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(10)
            make.left.equalTo(holderView).offset(10)
        }
    }
    
    func setupCell(product: Product) {
        nameLabel.text = product.Product ?? "No product name"
        descriptionLabel.text = product.Descr ?? "No product description"
        quantityValueLabel.text = "\(product.Qty)"
        priceValueLabel.text = "\(product.BasePrice)"
        unitValueLabel.text = "\(product.UnitCode)"
    }
}
