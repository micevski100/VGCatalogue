//
//  MenuTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 9.3.22.
//

import UIKit

class MenuTableViewCell: UITableViewCell {
    
    var cellImageView: UIImageView!
    var cellTitleLabel: UILabel!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
        setupConstraints()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

//MARK: - SETUP VIEWS
    func setupViews() {
        let bgColorView = UIView()
        bgColorView.backgroundColor = Utilities.sharedInstance.hexStringToUIColor(hex: "#eaeefc")
        self.selectedBackgroundView = bgColorView
        
        cellTitleLabel = CustomLabel(frame: CGRect.zero, text: "", font: Theme.sharedInstance.fontExtraLight(size: 20))
        
        cellImageView = UIImageView()
        
        self.contentView.addSubview(cellTitleLabel)
        self.contentView.addSubview(cellImageView)
    }
    
    func setupCell(cellTitle: String, imageName: String) {
        cellTitleLabel.text = cellTitle
        cellImageView.image = UIImage(named: imageName)
    }
    
//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        cellImageView.snp.makeConstraints { make in
            make.left.equalTo(self.contentView).offset(20)
            make.centerY.equalTo(self.contentView)
        }
        
        cellTitleLabel.snp.makeConstraints { make in
            make.left.equalTo(cellImageView.snp.right).offset(20)
            make.centerY.equalTo(self.contentView)
        }
    }
}
