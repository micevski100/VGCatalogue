//
//  OpenInvoicesTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 10.5.22.
//

import UIKit

class OpenInvoicesTableViewCell: UITableViewCell {
    
    var holderView: CustomView!
    var invoiceLabel: CustomLabel!
    var totalLabel: CustomLabel!
    var totalValueLabel: CustomLabel!
    var openInvoiceLabel: CustomLabel!
    var openInvoiceValueLabel: CustomLabel!
    var creditLimitLabel: CustomLabel!
    var creditLimitValueLabel: CustomLabel!
    var creditAuthLabel: CustomLabel!
    var creditAuthValueLabel: CustomLabel!
    
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
        
        invoiceLabel = CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        totalLabel =  CustomLabel(frame: CGRect.zero, text: "Total", font: Theme.sharedInstance.fontRegular(size: 20))
        
        totalValueLabel =  CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        openInvoiceLabel =  CustomLabel(frame: CGRect.zero, text: "Open Invoice", font: Theme.sharedInstance.fontRegular(size: 20))
        
        openInvoiceValueLabel =  CustomLabel(frame: CGRect.zero, text: "0", font: Theme.sharedInstance.fontRegular(size: 20))
        
        creditLimitLabel = CustomLabel(frame: CGRect.zero, text: "Credit limit", font: Theme.sharedInstance.fontRegular(size: 20))
        
        creditLimitValueLabel =  CustomLabel(frame: CGRect.zero, text: "NO", font: Theme.sharedInstance.fontRegular(size: 20))
        
        creditAuthLabel =  CustomLabel(frame: CGRect.zero, text: "Credit auth", font: Theme.sharedInstance.fontRegular(size: 20))
        
        creditAuthValueLabel =  CustomLabel(frame: CGRect.zero, text: "NO", font: Theme.sharedInstance.fontRegular(size: 20))
        
        holderView.addSubview(invoiceLabel)
        holderView.addSubview(totalLabel)
        holderView.addSubview(totalValueLabel)
        holderView.addSubview(openInvoiceLabel)
        holderView.addSubview(openInvoiceValueLabel)
        holderView.addSubview(creditLimitLabel)
        holderView.addSubview(creditAuthLabel)
        holderView.addSubview(creditLimitValueLabel)
        holderView.addSubview(creditAuthValueLabel)
        
        self.contentView.addSubview(holderView)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(10)
        }
        
        creditAuthLabel.snp.makeConstraints { make in
            make.left.bottom.equalTo(holderView).inset(20)
        }
        
        creditAuthValueLabel.snp.makeConstraints { make in
            make.right.bottom.equalTo(holderView).inset(20)
        }
        
        creditLimitLabel.snp.makeConstraints { make in
            make.left.equalTo(holderView).offset(20)
            make.bottom.equalTo(creditAuthLabel.snp.top).offset(-20)
        }
        
        creditLimitValueLabel.snp.makeConstraints { make in
            make.right.equalTo(holderView).offset(-20)
            make.bottom.equalTo(creditLimitLabel)
        }
        
        openInvoiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(creditLimitLabel.snp.top).offset(-20)
            make.left.equalTo(holderView).offset(20)
        }
        
        openInvoiceValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(openInvoiceLabel)
            make.right.equalTo(holderView).offset(-20)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.bottom.equalTo(openInvoiceLabel.snp.top).offset(-20)
            make.left.equalTo(holderView).offset(20)
        }
        
        totalValueLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalLabel)
            make.right.equalTo(holderView).offset(-20)
        }
        
        invoiceLabel.snp.makeConstraints { make in
            make.bottom.equalTo(totalLabel.snp.top).offset(-20)
            make.left.equalTo(holderView).offset(20)
        }
    }
    
    func hideCreditLabels() {
        creditAuthLabel.isHidden = true
        creditAuthValueLabel.isHidden = true
        creditLimitLabel.isHidden = true
        creditLimitValueLabel.isHidden = true
    }
    
    func showCreditLabels() {
        creditAuthLabel.isHidden = false
        creditAuthValueLabel.isHidden = false
        creditLimitLabel.isHidden = false
        creditAuthValueLabel.isHidden = false
    }
    
    func setupCell(openInvoice: HistoryOpenInvoice) {
        
        totalValueLabel.text = "\(openInvoice.DocTotal ?? 0) \(openInvoice.DocCurrency ?? "")"
        openInvoiceValueLabel.text = "\(openInvoice.DocOpen ?? 0) \(openInvoice.DocCurrency ?? "")"
        
        if openInvoice.DocSource == "OI" {
            invoiceLabel.text = "\(openInvoice.DocCount ?? 0) Open invoices"
            hideCreditLabels()
        } else if openInvoice.DocSource == "IIP" {
            invoiceLabel.text = "\(openInvoice.DocCount ?? 0) Invoice in progress"
            hideCreditLabels()
        } else if openInvoice.DocSource == "OIP" {
            invoiceLabel.text = "\(openInvoice.DocCount ?? 0) Order in progress"
            hideCreditLabels()
        } else {
            showCreditLabels()
            invoiceLabel.text = "\(openInvoice.DocCount ?? 0) Grand total"
            creditAuthValueLabel.text = openInvoice.CreditAuthorization == 0 ? "NO" : "YES"
            creditLimitValueLabel.text = openInvoice.CreditLimit == 0 ? "NO" : "YES"
        }
    }
}
