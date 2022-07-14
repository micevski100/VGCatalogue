//
//  ClientsListCollectionViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 10.3.22.
//

import UIKit

class ClientsListCollectionViewCell: UICollectionViewCell {
    
    var titleLabel: UILabel!
    var clientSecondNameLabel: UILabel!
    var clientAddressLabel: UILabel!
    var holderView: UIView!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.titleLabel.text = ""
        self.clientSecondNameLabel.text = ""
        self.clientAddressLabel.text = ""
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - SETUP VIEWS
    func setupViews() {
        titleLabel = CustomLabel(frame: CGRect.zero, text: "My Clients", font: Theme.sharedInstance.fontBold(size: 15))
        titleLabel.numberOfLines = 0
        titleLabel.lineBreakMode = .byWordWrapping
        
        clientSecondNameLabel = CustomLabel(frame: CGRect.zero, text: "Client Second Name", font: Theme.sharedInstance.fontExtraLight(size: 15))
        clientSecondNameLabel.numberOfLines = 0
        clientSecondNameLabel.lineBreakMode = .byWordWrapping
        
        clientAddressLabel = CustomLabel(frame: CGRect.zero, text: "Client Address", font: Theme.sharedInstance.fontExtraLight(size: 15))
        clientAddressLabel.numberOfLines = 0
        clientAddressLabel.lineBreakMode = .byWordWrapping
        
        holderView = CustomView(frame: CGRect.zero, backgroundColor: .white, cornerRadius: 10)
        
        holderView.addSubview(titleLabel)
        holderView.addSubview(clientSecondNameLabel)
        holderView.addSubview(clientAddressLabel)
        self.contentView.addSubview(holderView)
    }
    
    //MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(10)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(holderView).offset(20)
            make.left.right.equalTo(holderView).inset(10)
        }
        
        clientSecondNameLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalTo(holderView).inset(10)
        }
        
        clientAddressLabel.snp.makeConstraints { make in
            make.top.equalTo(clientSecondNameLabel.snp.bottom).offset(10)
            make.left.right.equalTo(holderView).inset(10)
        }
    }
    
    func setupCell(client: Client) {
        titleLabel.text = client.CompanyName
        clientSecondNameLabel.text = client.FullName
        clientAddressLabel.text = client.Address
    }
    
    func setupContactCell(contact: ClientContact) {
        titleLabel.text = contact.FullName
        clientSecondNameLabel.isHidden = true
        clientAddressLabel.isHidden = true
    }
}
