//
//  AboutThisAppViewController.swift
//  VGCatalogue
//
//  Created by Aleksandar Micevski on 9.3.22.
//

import UIKit

class AboutThisAppViewController: UIViewController {
    
    var logoImageView: UIImageView!
    var descriptionTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        setupViews()
        setupConstraints()
    }
    
    func setupViews() {
        self.view.backgroundColor = .white
        self.navigationController?.navigationBar.backgroundColor = .white
        self.title = "About This App"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationController?.navigationBar.isTranslucent = false
        
        logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "noImageAvailable")
        logoImageView.contentMode = .scaleAspectFit
        
        descriptionTextView = UITextView()
        descriptionTextView.font = Theme.sharedInstance.fontRegular(size: 20)
        descriptionTextView.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        descriptionTextView.isSelectable = true
        descriptionTextView.isEditable = false
        
        self.view.addSubview(logoImageView)
        self.view.addSubview(descriptionTextView)
    }
    
    func setupConstraints() {
        logoImageView.snp.makeConstraints { make in
            make.top.equalTo(self.view).offset(20)
            make.height.equalTo(self.view).dividedBy(4)
            make.centerX.equalTo(self.view.snp.centerX)
        }
        
        descriptionTextView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).offset(20)
            make.left.equalTo(logoImageView.snp.left)
            make.right.equalTo(logoImageView.snp.right)
            make.height.equalTo(self.view).dividedBy(4)
        }
    }
}
