//
//  CustomInputView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 18.3.22.
//

import UIKit

protocol CustomInputViewDelegate {
    func bottomButtonTapped()
    func textFieldChanged(textField: UITextField)
}

class CustomInputView: UIView {
    var delegate: CustomInputViewDelegate?
    var tableView: UITableView!
    var bottomButton: CustomButton!
    var isForLogin: Bool!
    var buttonText: String!
    var textFieldPlaceholders: [[String]]!
    
    required init(frame: CGRect, textFieldPlaceHolders: [[String]], buttonText: String, isForLogin: Bool) {
        super.init(frame: frame)
        self.textFieldPlaceholders = textFieldPlaceHolders
        self.buttonText = buttonText
        self.isForLogin = isForLogin
        
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        self.layer.cornerRadius = 10
        self.backgroundColor = .white
        self.layer.cornerRadius = 10
        self.layer.shadowColor = UIColor.black.cgColor
        self.layer.shadowRadius = 10
        self.layer.shadowOpacity = 0.20
        self.layer.masksToBounds = false
        
        tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.register(LoginTableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.showsVerticalScrollIndicator = false
        tableView.delegate = self
        tableView.dataSource = self
        
        if (isForLogin) {
            tableView.tableHeaderView = LoginHeaderView(frame: CGRect(x: 0, y: 0, width: self.frame.size.width, height: self.frame.size.height / 8))
        }

        // Login Button
        bottomButton = CustomButton(frame: CGRect.zero, title: buttonText.localized(), backgroundColor: Theme.sharedInstance.themeBlueColor(), imageName: nil, tintColor: nil)
        bottomButton.addTarget(self, action: #selector(bottomButtonTapped), for: .touchUpInside)
        
        // Add subviews
        self.addSubview(tableView)
        self.addSubview(bottomButton)
    }

    func setupConstraints() {
        tableView.snp.makeConstraints { make in
            make.top.equalTo(self).offset(20)
            if isForLogin {
                make.left.right.equalTo(self).inset(self.frame.size.width / 20)
            } else {
                make.left.right.equalTo(self).inset(20)
            }
            
            make.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
        
        bottomButton.snp.makeConstraints { make in
            if isForLogin {
                make.left.right.equalTo(self).inset(self.frame.size.width / 18)
                make.bottom.equalTo(self).offset(-self.frame.size.height / 18)
            } else {
                make.left.right.bottom.equalTo(self).inset(20)
            }
            
            make.height.equalTo(50)
        }
        
    }

}

//MARK: - KEYBOARD WILLSHOW AND WILL HIDE
extension CustomInputView {
    // keyboard will show
    func changeTableViewHeight(offset: CGFloat) {
        self.tableView.snp.remakeConstraints { make in
            make.top.equalTo(self).offset(20)
            if isForLogin {
                make.left.right.equalTo(self).inset(self.frame.size.width / 18)
            } else {
                make.left.right.equalTo(self).inset(20)
            }
            
            make.bottom.equalTo(self).offset(-offset)
        }
    }
    
    // keyboard will hide
    func reloadTableViewConstraints() {
        tableView.snp.remakeConstraints { make in
            make.top.equalTo(self).offset(20)
            if isForLogin {
                make.left.right.equalTo(self).inset(self.frame.size.width / 20)
            } else {
                make.left.right.equalTo(self).inset(20)
            }
            
            make.bottom.equalTo(bottomButton.snp.top).offset(-20)
        }
    }
}

//MARK: - TABLEVIEW DELEGATES
extension CustomInputView:  UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textFieldPlaceholders.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! LoginTableViewCell
        cell.textField.tag = indexPath.row
        cell.textField.delegate = self
        
        

        // setup cells
        if isForLogin && (indexPath.row == 3 || indexPath.row == 1) {
            cell.setupCell(cellTitle: textFieldPlaceholders[indexPath.row][0].localized(),
                           cellText: "",
                           isSecureEntry: true,
                           imageName: textFieldPlaceholders[indexPath.row][1])
        } else {
            cell.setupCell(cellTitle: textFieldPlaceholders[indexPath.row][0].localized(),
                           cellText: "",
                           isSecureEntry: false,
                           imageName: textFieldPlaceholders[indexPath.row][1])
        }
        
        // Return KeyType for keyboard
        if indexPath.row == textFieldPlaceholders.count - 1 {
            cell.textField.returnKeyType = .done
        }
        else {
            cell.textField.returnKeyType = .next
        }
        
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
}

//MARK: - TEXTFIELD DELEGATES
extension CustomInputView: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        delegate?.textFieldChanged(textField: textField)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField.tag + 1 < textFieldPlaceholders.count {
            tableView.scrollToRow(at: [0,textField.tag + 1], at: .middle, animated: true)
            let cell = tableView.cellForRow(at: [0,textField.tag + 1]) as? LoginTableViewCell
            cell?.textField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }

        return true
    }
}

//MARK: - OBJ FUNCS
extension CustomInputView {
    @objc func bottomButtonTapped() {
        delegate?.bottomButtonTapped()
    }
}
