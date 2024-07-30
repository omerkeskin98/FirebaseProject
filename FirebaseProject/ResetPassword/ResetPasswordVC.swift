//
//  ResetPasswordVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import UIKit
import SnapKit


class ResetPasswordVC : UIViewController{
    
    let viewModel : ResetPasswordVM
    
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Please enter your email to reset password"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    let emailTF: UITextField = {
        let textfield = UITextField()
        textfield.placeholder = "Email"
        textfield.keyboardType = .emailAddress
        textfield.clearButtonMode = .always
        textfield.borderStyle = .roundedRect
        return textfield
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset password", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .regular)
        button.layer.cornerRadius = 7
        return button
    }()
    
    
    init() {
        self.viewModel = ResetPasswordVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.resetPasswordVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        
        viewModel.setupKeyboardDismissal(view: self.view)
        resetButton.addTarget(viewModel, action: #selector(viewModel.resetButtonTapped), for: .touchUpInside)
        
        
        
    }
    
    
    
    func setupConstraints() {
        view.addSubview(mainLabel)
        mainLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(250)
        }
        
        view.addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(mainLabel.snp.bottom).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        view.addSubview(resetButton)
        resetButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTF.snp.bottom).offset(50)
            make.height.equalTo(50)
            make.trailing.equalTo(view.snp.trailing).offset(-120)
            make.leading.equalTo(view.snp.leading).offset(120)
        }
    }
    
    
}
