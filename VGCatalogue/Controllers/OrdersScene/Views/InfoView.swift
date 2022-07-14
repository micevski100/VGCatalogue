//
//  ClientInfoView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 23.5.22.
//

import UIKit

class InfoView: UIView {
    
    var holderView: CustomView!
    var nameLabel: CustomLabel!
    var locationLabel: CustomLabel!
    var locationImageView: UIImageView!
    var phoneLabel: CustomLabel!
    var phoneImageView: UIImageView!
    
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
        
        nameLabel = CustomLabel(frame: CGRect.zero, text: "No name", font: Theme.sharedInstance.fontBold(size: 20))
        
        locationLabel = CustomLabel(frame: CGRect.zero, text: "No location", font: Theme.sharedInstance.fontBold(size: 20))
        
        phoneLabel = CustomLabel(frame: CGRect.zero, text: "No phone number", font: Theme.sharedInstance.fontBold(size: 20))
        
        locationImageView = UIImageView(image: UIImage(systemName: "location.fill"))
        phoneImageView = UIImageView(image: UIImage(systemName: "phone.fill"))
        
        holderView.addSubview(nameLabel)
        holderView.addSubview(locationLabel)
        holderView.addSubview(phoneLabel)
        holderView.addSubview(locationImageView)
        holderView.addSubview(phoneImageView)
        
        self.addSubview(holderView)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self)
        }
        
        nameLabel.snp.makeConstraints { make in
            make.top.left.right.equalTo(holderView).inset(20)
            make.height.equalTo(25)
        }
        
        phoneImageView.snp.makeConstraints { make in
            make.left.equalTo(holderView).offset(20)
            make.bottom.equalTo(holderView).offset(-20)
            make.width.height.equalTo(25)
        }
        
        phoneLabel.snp.makeConstraints { make in
            make.centerY.equalTo(phoneImageView)
            make.left.equalTo(phoneImageView.snp.right).offset(20)
            make.right.equalTo(holderView).offset(-20)
        }
        
        locationImageView.snp.makeConstraints { make in
            make.left.width.height.equalTo(phoneImageView)
            make.bottom.equalTo(phoneImageView.snp.top).offset(-20)
        }
        
        locationLabel.snp.makeConstraints { make in
            make.centerY.equalTo(locationImageView)
            make.left.equalTo(locationImageView.snp.right).offset(20)
            make.right.equalTo(phoneLabel)
        }
    }
    
    //TODO: SETUP VIEW WITH CONTACT, SETUP VIEW WITH CLIENT
    func setupView(name: String?, phone: String?, location: String?) {
        nameLabel.text = name ?? "No name"
        phoneLabel.text = phone ?? "no phone"
        locationLabel.text = location ?? "no location"
        
        if phoneLabel.text == "" {
            phoneLabel.text = "no phone"
        }
        
        if nameLabel.text == "" {
            nameLabel.text = "no name"
        }
    }
}
