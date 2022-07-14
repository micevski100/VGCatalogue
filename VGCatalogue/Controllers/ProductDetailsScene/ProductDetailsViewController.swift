//
//  ProductDetailsViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 5.5.22.
//

import UIKit

class ProductDetailsViewController: UIViewController {
    
    var product: Product!
    var imageInfo: ImageInfo!
    var productImageView: UIImageView!
    var descriptionLabel: CustomLabel!
    var descriptionValueLabel: CustomLabel!
    var productNumberLabel: CustomLabel!
    var productNumberValueLabel: CustomLabel!
    var qtyLabel: CustomLabel!
    var qtyValueButton: UIButton!
    var priceLabel: CustomLabel!
    var priceValueLabel: CustomLabel!
    var packagingLabel: CustomLabel!
    var packagingValueLabel: CustomLabel!
    var addToOrderButton: CustomButton!
    var qtyIncrementButton: UIButton!
    var qtyDecrementButton: UIButton!
    var qty: Int = 1
    

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        productImageView = UIImageView()
        productImageView.contentMode = .scaleAspectFit
        var imageName = product.ImageNameCalculated
        if imageName == nil || imageName == "" {
            imageName = product.ImageName
        }
        
        if let imageName = imageName {
            var path = imageInfo.ImgPathNormal! + imageName
            path = path.replacingOccurrences(of: " ", with: "%20")

            if path.contains(".jpg") || path.contains(".JPG") || path.contains(".jpeg") || path.contains(".png") {
                productImageView.kf.setImage(with: URL(string: path))
            } else {
                productImageView.image = UIImage(named: "noImageAvailable")
            }
        }
        
        addToOrderButton = CustomButton(frame: CGRect.zero, title: "Add to order", backgroundColor: Theme.sharedInstance.themeBlueColor(), imageName: nil, tintColor: nil)
        addToOrderButton.addTarget(self, action: #selector(addToOrderButtonTapped), for: .touchUpInside)
        
        descriptionLabel = CustomLabel(frame: CGRect.zero, text: "Description:", font: Theme.sharedInstance.fontBold(size: 20))
        
        descriptionValueLabel = CustomLabel(frame: CGRect.zero, text: product.Description ?? "No description", font: Theme.sharedInstance.fontRegular(size: 20))
        
        productNumberLabel = CustomLabel(frame: CGRect.zero, text: "Product Number:", font: Theme.sharedInstance.fontBold(size: 20))
        
        productNumberValueLabel = CustomLabel(frame: CGRect.zero, text: product.ProductCode ?? "No product number", font: Theme.sharedInstance.fontBold(size: 20))
        
        qtyLabel = CustomLabel(frame: CGRect.zero, text: "Qty:", font: Theme.sharedInstance.fontBold(size: 20))
        
        qtyValueButton = UIButton()
        qtyValueButton.setTitle("1", for: .normal)
        qtyValueButton.configuration = .bordered()
        
        qtyIncrementButton = UIButton()
        qtyIncrementButton.setImage(UIImage(systemName: "plus"), for: .normal)
        qtyIncrementButton.configuration = .bordered()
        qtyIncrementButton.addTarget(self, action: #selector(qtyIncrementTapped), for: .touchUpInside)
        
        qtyDecrementButton = UIButton()
        qtyDecrementButton.setImage(UIImage(systemName: "minus"), for: .normal)
        qtyDecrementButton.configuration = .bordered()
        qtyDecrementButton.addTarget(self, action: #selector(qtyDecrementTapped), for: .touchUpInside)
        
        
        priceLabel = CustomLabel(frame: CGRect.zero, text: "Price:", font: Theme.sharedInstance.fontBold(size: 20))
        
        priceValueLabel = CustomLabel(frame: CGRect.zero, text: "\(product.Price ?? 0)", font: Theme.sharedInstance.fontRegular(size: 20))
        
        
        self.view.addSubview(productImageView)
        self.view.addSubview(addToOrderButton)
        self.view.addSubview(descriptionLabel)
        self.view.addSubview(descriptionValueLabel)
        self.view.addSubview(productNumberLabel)
        self.view.addSubview(productNumberValueLabel)
        self.view.addSubview(qtyLabel)
        self.view.addSubview(qtyValueButton)
        self.view.addSubview(qtyIncrementButton)
        self.view.addSubview(qtyDecrementButton)
        self.view.addSubview(priceLabel)
        self.view.addSubview(priceValueLabel)
    }
    
    func setupConstraints() {
        productImageView.snp.makeConstraints { make in
            make.top.left.equalTo(self.view).offset(20)
            make.right.equalTo(self.view.snp.centerX).offset(-20)
            make.bottom.equalTo(addToOrderButton.snp.top).offset(-20)
        }
        
        addToOrderButton.snp.makeConstraints { make in
            make.left.right.equalTo(self.view).inset(self.view.frame.size.width / 18)
            make.bottom.equalTo(self.view).offset(-self.view.frame.size.height / 18)
            make.height.equalTo(50)
        }
        
        descriptionLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.view)
            make.left.equalTo(productImageView.snp.right).offset(20)
        }
        
        descriptionValueLabel.snp.makeConstraints { make in
            make.centerY.equalTo(self.view.snp.centerY)
            make.left.equalTo(descriptionLabel.snp.right).offset(20)
        }
        
        productNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(productImageView.snp.right).offset(20)
        }
        
        productNumberValueLabel.snp.makeConstraints { make in
            make.top.equalTo(descriptionLabel.snp.bottom).offset(10)
            make.left.equalTo(productNumberLabel.snp.right).offset(20)
        }
        
        qtyLabel.snp.makeConstraints { make in
            make.top.equalTo(productNumberLabel.snp.bottom).offset(10)
            make.left.equalTo(productImageView.snp.right).offset(20)
        }
        
        qtyValueButton.snp.makeConstraints { make in
            make.top.equalTo(productNumberLabel.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.left.equalTo(qtyLabel.snp.right).offset(20)
        }
        
        qtyIncrementButton.snp.makeConstraints { make in
            make.top.equalTo(productNumberLabel.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.left.equalTo(qtyValueButton.snp.right).offset(20)
        }
        
        qtyDecrementButton.snp.makeConstraints { make in
            make.top.equalTo(productNumberLabel.snp.bottom).offset(10)
            make.height.equalTo(25)
            make.left.equalTo(qtyIncrementButton.snp.right)
        }
        
        priceLabel.snp.makeConstraints { make in
            make.top.equalTo(qtyLabel.snp.bottom).offset(10)
            make.left.equalTo(productImageView.snp.right).offset(20)
        }
        
        priceValueLabel.snp.makeConstraints { make in
            make.top.equalTo(qtyLabel.snp.bottom).offset(10)
            make.left.equalTo(priceLabel.snp.right).offset(20)
        }
        
    }
}

extension ProductDetailsViewController {
    @objc func qtyIncrementTapped() {
        qty += 1
        qtyValueButton.setTitle("\(qty)", for: .normal)
    }
    
    @objc func qtyDecrementTapped() {
        qty -= 1
        
        if qty == 0 {
            qty = 1
        }
        
        qtyValueButton.setTitle("\(qty)", for: .normal)
    }
    
    @objc func addToOrderButtonTapped() {
        addToCart()
    }
}

//MARK: API COMMUNICATION
extension ProductDetailsViewController {
    func createRequestForAddToCart() -> [String:Any] {
        let crmInfo = UserPersistance.sharedInstance.getCrmInfo()
        let userInfo = UserPersistance.sharedInstance.getUserInfo()
        let employee = UserPersistance.sharedInstance.getEmployee()
        let contact = DataHolder.sharedInstance.selectedContact
        let client = DataHolder.sharedInstance.selectedClient
        let quantity = self.qty * (product.UnitQty ?? 0)
        let userInfoDict = ["ShopNumber": crmInfo?.ShopNumber ?? 0,
                        "ClientNo": contact?.ClientId ?? 0,
                        "LoginNo": userInfo?.LoginNo ?? 0,
                        "EmployeeId": employee?.EmployeeId ?? 0,
                        "Languague": userInfo?.Language ?? "EN",
                        "CartNo": userInfo?.CartNo ?? 0] as [String : Any]
        let requestInfoDict = ["CartId": DataHolder.sharedInstance.existingCartId ?? 0,
                           "ProductRef": product.ProductCode ?? "",
                           "DeliveryClientId": client?.ClientId ?? 0,
                           "ContactId": contact?.ContactId ?? 0,
                           "Qty": quantity,
                           "Descr": product.Description ?? "",
                           "UnitPrimaryPrice": product.Price ?? 0,
                           "EmployeeId": employee?.EmployeeId ?? 0] as [String : Any]
        
        let dict = ["UserInfo": userInfoDict, "RequestInfo": requestInfoDict]
        
        return dict
    }
    
    func addToCart() {
        ApiManager.sharedInstance.addToCart(params: createRequestForAddToCart()) { success, responseObject, statusCode in
            if success {
                
            } else {
                
            }
        }
    }
}
