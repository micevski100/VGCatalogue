//
//  ClientContactsCollectionViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 29.3.22.
//

import UIKit

class ClientContactsCollectionViewCell: UICollectionViewCell {
    
    var holderView: UIView!
    var contactNameLabel: UILabel!
    var clientAddressLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        
        holderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        holderView.layer.borderColor = UIColor.black.cgColor
        holderView.layer.shadowColor = UIColor.systemGray.cgColor
        holderView.layer.shadowOffset = CGSize.zero
        holderView.layer.shadowRadius = 10
        holderView.layer.shadowOffset = CGSize.zero
        holderView.layer.shadowOpacity = 0.5
        holderView.layer.masksToBounds = false
        
        contactNameLabel = CustomLabel(frame: CGRect.zero, text: "Contact Name", font: Theme.sharedInstance.fontRegular(size: 15))
        contactNameLabel.numberOfLines = 0
        contactNameLabel.lineBreakMode = .byWordWrapping
        
        
        clientAddressLabel = CustomLabel(frame: CGRect.zero, text: "Client Address", font: Theme.sharedInstance.fontRegular(size: 15))
        
        self.contentView.addSubview(holderView)
        self.contentView.addSubview(contactNameLabel)
        self.contentView.addSubview(clientAddressLabel)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(10)
        }
        
        contactNameLabel.snp.makeConstraints { make in
            make.top.equalTo(holderView).offset(10)
            make.left.right.equalTo(holderView).offset(10)
        }
        
        clientAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(contactNameLabel.snp.bottom).offset(20)
            make.left.right.equalTo(holderView).inset(10)
        }
    }
    
    func setupCell(contact: ClientContact) {
        self.contactNameLabel.text = contact.FullName
        self.clientAddressLabel.text = contact.Address
    }
}
