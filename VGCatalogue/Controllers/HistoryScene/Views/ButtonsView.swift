//
//  ButtonsView.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 9.5.22.
//

import UIKit

protocol ButtonsViewProtocol {
    func buttonSelected(tag: Int)
}

class ButtonsView: UIView {

    var delegate: ButtonsViewProtocol?
    var backLogButton: CustomHistoryButton!
    var invoicesButton: CustomHistoryButton!
    var openInvoicesButton: CustomHistoryButton!
    var byProductButton: CustomHistoryButton!
    var bottomLine: UIView!
    
    required override init(frame: CGRect) {
        super.init(frame: CGRect.zero)
        setupViews()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        backLogButton = CustomHistoryButton(frame: CGRect.zero, title: "Backlog", tag: 1)
        backLogButton.addTarget(self, action: #selector(backLogButtonTapped), for: .touchUpInside)
        
        invoicesButton = CustomHistoryButton(frame: CGRect.zero, title: "Invoices", tag: 2)
        invoicesButton.addTarget(self, action: #selector(invoicesButtonTapped), for: .touchUpInside)
        
        openInvoicesButton = CustomHistoryButton(frame: CGRect.zero, title: "Open Invoices", tag: 3)
        openInvoicesButton.addTarget(self, action: #selector(openInvoicesButtonTapped), for: .touchUpInside)
        
        byProductButton = CustomHistoryButton(frame: CGRect.zero, title: "By Product", tag: 4)
        byProductButton.addTarget(self, action: #selector(byProductButtonTapped), for: .touchUpInside)
        
        bottomLine = UIView()
        bottomLine.backgroundColor = .black
        
        self.addSubview(backLogButton)
        self.addSubview(invoicesButton)
        self.addSubview(openInvoicesButton)
        self.addSubview(byProductButton)
        self.addSubview(bottomLine)
    }
    
    func setupConstraints() {
        backLogButton.snp.makeConstraints { make in
            make.top.left.equalTo(self)
            make.width.equalTo(self).dividedBy(4)
            make.height.equalTo(50)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(backLogButton.snp.bottom)
            make.left.right.equalTo(backLogButton)
            make.height.equalTo(1)
        }
        
        invoicesButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(backLogButton.snp.right)
            make.width.height.equalTo(backLogButton)
        }
        
        openInvoicesButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(invoicesButton.snp.right)
            make.width.height.equalTo(backLogButton)
        }
        
        byProductButton.snp.makeConstraints { make in
            make.top.equalTo(self)
            make.left.equalTo(openInvoicesButton.snp.right)
            make.width.height.equalTo(backLogButton)
        }
    }

    
    @objc func backLogButtonTapped() {
        bottomLine.snp.remakeConstraints { make in
            make.top.equalTo(backLogButton.snp.bottom)
            make.left.equalTo(backLogButton.snp.left)
            make.right.equalTo(backLogButton.snp.right)
            make.height.equalTo(1)
        }
        
        delegate?.buttonSelected(tag: backLogButton.tag)
        
    }
    
    @objc func invoicesButtonTapped() {
        bottomLine.snp.remakeConstraints { make in
            make.top.equalTo(invoicesButton.snp.bottom)
            make.left.equalTo(invoicesButton.snp.left)
            make.right.equalTo(invoicesButton.snp.right)
            make.height.equalTo(1)
        }
        
        delegate?.buttonSelected(tag: invoicesButton.tag)
    }
    
    @objc func openInvoicesButtonTapped() {
        bottomLine.snp.remakeConstraints { make in
            make.top.equalTo(openInvoicesButton.snp.bottom)
            make.left.equalTo(openInvoicesButton.snp.left)
            make.right.equalTo(openInvoicesButton.snp.right)
            make.height.equalTo(1)
        }
        
        delegate?.buttonSelected(tag: openInvoicesButton.tag)
    }
    
    @objc func byProductButtonTapped() {
        bottomLine.snp.remakeConstraints { make in
            make.top.equalTo(byProductButton.snp.bottom)
            make.left.equalTo(byProductButton.snp.left)
            make.right.equalTo(byProductButton.snp.right)
            make.height.equalTo(1)
        }
        
        delegate?.buttonSelected(tag: byProductButton.tag)
    }
}
