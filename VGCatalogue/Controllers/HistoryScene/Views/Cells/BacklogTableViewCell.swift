//
//  BacklogTableViewCell.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 9.5.22.
//

import UIKit

class BacklogTableViewCell: UITableViewCell {
    
    var holderView: CustomView!
    var orderLabel: CustomLabel!
    var dateLabel: CustomLabel!
    var deliveryLabel: CustomLabel!
    var orderValueLabel: CustomLabel!
    var dateValueLabel: CustomLabel!
    var deliveryValueLabel: CustomLabel!
    var bottomLine: UIView!
    var totalLabel: CustomLabel!
    var totalValueLabel: CustomLabel!
    
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
        
        orderLabel = CustomLabel(frame: CGRect.zero, text: "Order", font: Theme.sharedInstance.fontRegular(size: 20))
        orderValueLabel = CustomLabel(frame: CGRect.zero, text: "123456778", font: Theme.sharedInstance.fontRegular(size: 20))

        dateLabel = CustomLabel(frame: CGRect.zero, text: "Date", font: Theme.sharedInstance.fontRegular(size: 20))
        dateValueLabel = CustomLabel(frame: CGRect.zero, text: "23-03-2022", font: Theme.sharedInstance.fontRegular(size: 20))
        
        deliveryLabel = CustomLabel(frame: CGRect.zero, text: "Delivery", font: Theme.sharedInstance.fontRegular(size: 20))
        deliveryValueLabel = CustomLabel(frame: CGRect.zero, text: "24-03-2022", font: Theme.sharedInstance.fontRegular(size: 20))
        
        bottomLine = UIView()
        bottomLine.backgroundColor = .systemGray
        
        
        totalLabel = CustomLabel(frame: CGRect.zero, text: "Total", font: Theme.sharedInstance.fontRegular(size: 20))
        
        totalValueLabel = CustomLabel(frame: CGRect.zero, text: "106.40 CHF", font: Theme.sharedInstance.fontRegular(size: 20))
        
        self.contentView.addSubview(holderView)
        self.contentView.addSubview(orderLabel)
        self.contentView.addSubview(orderValueLabel)
        self.contentView.addSubview(dateLabel)
        self.contentView.addSubview(dateValueLabel)
        self.contentView.addSubview(deliveryLabel)
        self.contentView.addSubview(deliveryValueLabel)
        self.contentView.addSubview(bottomLine)
        self.contentView.addSubview(totalLabel)
        self.contentView.addSubview(totalValueLabel)
    }
    
    func setupConstraints() {
        holderView.snp.makeConstraints { make in
            make.edges.equalTo(self.contentView).inset(10)
        }
        
        orderLabel.snp.makeConstraints { make in
            make.top.left.equalTo(holderView).offset(20)
        }
        
        orderValueLabel.snp.makeConstraints { make in
            make.top.equalTo(holderView).offset(20)
            make.right.equalTo(holderView.snp.right).offset(-20)
        }
        
        dateLabel.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(10)
            make.left.equalTo(holderView).offset(20)
        }
        
        dateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(orderLabel.snp.bottom).offset(10)
            make.right.equalTo(holderView.snp.right).offset(-20)
        }
        
        deliveryLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.left.equalTo(holderView).offset(20)
        }
        
        deliveryValueLabel.snp.makeConstraints { make in
            make.top.equalTo(dateLabel.snp.bottom).offset(10)
            make.right.equalTo(holderView.snp.right).offset(-20)
        }
        
        bottomLine.snp.makeConstraints { make in
            make.top.equalTo(deliveryLabel.snp.bottom).offset(10)
            make.left.right.equalTo(holderView).inset(20)
            make.height.equalTo(1)
        }
        
        totalLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(10)
            make.left.equalTo(holderView).offset(20)
        }
        
        totalValueLabel.snp.makeConstraints { make in
            make.top.equalTo(bottomLine.snp.bottom).offset(10)
            make.right.equalTo(holderView.snp.right).offset(-20)
        }
    }
    
    func setupCell(backlog: Backlog) {
        orderValueLabel.text = "\(backlog.DocId ?? 0)"
        dateValueLabel.text = backlog.DocDate ?? ""
        deliveryValueLabel.text = backlog.DocDeliveryDate ?? ""
        totalValueLabel.text = "\(backlog.DocTotal ?? 0)" + " " + (backlog.DocCurrency ?? "")
    }
}
