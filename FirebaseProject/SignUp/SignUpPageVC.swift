//
//  ViewController.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//


import UIKit
import SnapKit

class SignUpPageVC: UIViewController {
    
    let viewModel: SignUpPageVM
    
    let createAccount: UILabel = {
       let label = UILabel()
        label.text = "Create Account"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
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
    
    let passwordTF: UITextField = {
       let textfield = UITextField()
        textfield.placeholder = "Password"
        textfield.keyboardType = .default
        textfield.borderStyle = .roundedRect
        textfield.isSecureTextEntry = true
        return textfield
    }()
    
    lazy var eyeButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(systemName: "eye"), for: .normal)
        button.setImage(UIImage(systemName: "eye.slash"), for: .selected)
        button.tintColor = .black
        button.addTarget(self, action: #selector(togglePasswordVisibility(_:)), for: .touchUpInside)
        return button
    }()
    
    let signUpButton: UIButton = {
       let button = UIButton()
        button.setTitle("Register", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .semibold)
        button.layer.cornerRadius = 7
        return button
    }()
    
    let signInButton: UIButton = {
       let button = UIButton()
        button.setTitle("Have you registered before?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    init() {
        self.viewModel = SignUpPageVM(viewController: nil, signupPageVC: nil)
        super.init(nibName: nil, bundle: nil)
        self.viewModel.viewController = self
        self.viewModel.signupPageVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        passwordTF.rightView = eyeButton
        passwordTF.rightViewMode = .always
        
        viewModel.setupKeyboardDismissal(view: self.view)
        
        signInButton.addTarget(viewModel, action: #selector(viewModel.signInButtonTapped), for: .touchUpInside)
        signUpButton.addTarget(viewModel, action: #selector(viewModel.signUpButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(createAccount)
        createAccount.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(250)
        }
        
        view.addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(createAccount.snp.bottom).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.leading.equalTo(view.snp.leading).offset(60)
        }
        
        view.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTF.snp.bottom).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.leading.equalTo(view.snp.leading).offset(60)
        }
        
        view.addSubview(signUpButton)
        signUpButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.top.equalTo(signUpButton.snp.bottom).offset(50)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
            make.leading.equalTo(view.snp.leading).offset(30)
        }
    }
    
    @objc func togglePasswordVisibility(_ sender: UIButton) {
        sender.isSelected.toggle()
        passwordTF.isSecureTextEntry.toggle()

        if let existingText = passwordTF.text, passwordTF.isSecureTextEntry {
            passwordTF.deleteBackward()
            passwordTF.insertText(existingText)
        }
    }
}
