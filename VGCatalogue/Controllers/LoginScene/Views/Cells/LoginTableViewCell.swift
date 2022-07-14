//
//  LoginTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 21.2.22.
//

import UIKit

class LoginTableViewCell: UITableViewCell {
    
    var cellTitle: UILabel!
    var textField: CustomTextField!
    var bottomLine: UIView!
    
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
        self.selectionStyle = .none
        
        cellTitle = CustomLabel(frame: CGRect.zero, text: "", font: Theme.sharedInstance.fontExtraLight(size: 20))
        textField = CustomTextField(frame: CGRect(x: 0, y: 0, width: self.contentView.frame.size.width, height: 30), isSecureEntry: false, imageName: "xmark.circle.fill", font: Theme.sharedInstance.fontRegular(size: 20))
        
        bottomLine = UIView()
        bottomLine.backgroundColor = .systemGray
        
        self.contentView.addSubview(cellTitle)
        self.contentView.addSubview(textField)
        self.contentView.addSubview(bottomLine)
    }
    
//MARK: - SETUP CONSTRAINTS
    func setupConstraints() {
        cellTitle.snp.makeConstraints { make in
            make.top.equalTo(self.contentView).offset(10)
            make.left.equalTo(self.contentView).offset(10)
            make.bottom.equalTo(textField.snp.top).offset(-10)
        }
        
        textField.snp.makeConstraints { make in
            make.bottom.equalTo(contentView).offset(-20)
            make.left.right.equalTo(contentView).inset(10)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(textField.snp.bottom).offset(5)
            make.left.right.equalTo(contentView).inset(10)
            make.height.equalTo(1)
        }
    }
    
//MARK: - SETUP CELL
    func setupCell(cellTitle: String, cellText: String?, isSecureEntry: Bool, imageName: String) {
        self.cellTitle.text = cellTitle
        self.textField.isSecureEntry = isSecureEntry
        self.textField.imageName = imageName
        self.textField.setupTextField()
        
        if let text = cellText {
            self.textField.text = text
        }
    }
}
