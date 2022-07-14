//
//  LoginHeaderView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 21.2.22.
//

import UIKit

class LoginHeaderView: UIView {
    
    var titleLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//MARK: - SETUP VIEWS
    func setupViews() {
        titleLabel = CustomLabel(frame: CGRect.zero, text: "VisualGest Catalog", font: Theme.sharedInstance.fontBold(size: 30))
        
        self.addSubview(titleLabel)
    }
    
//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(self).offset(40)
            make.centerX.equalTo(self)
        }
    }
}
