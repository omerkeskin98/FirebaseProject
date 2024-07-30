//
//  LoginPageVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//


import UIKit
import SnapKit

class LoginPageVC: UIViewController {
    
    let viewModel: LoginPageVM

    let signInLabel: UILabel = {
        let label = UILabel()
        label.text = "Please sign in"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .semibold)
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
    
    let signInButton: UIButton = {
        let button = UIButton()
        button.setTitle("Sign in", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.layer.cornerRadius = 7
        return button
    }()
    
    let backToRegisterButton: UIButton = {
       let button = UIButton()
        button.setTitle("Sign up with a new account", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    let resetPasswordButton: UIButton = {
       let button = UIButton()
        button.setTitle("Forgot password?", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .regular)
        button.setTitleColor(UIColor.systemBlue, for: .normal)
        return button
    }()
    
    init() {
        self.viewModel = LoginPageVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.loginPageVC = self
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
        backToRegisterButton.addTarget(viewModel, action: #selector(viewModel.backToRegisterButtonTapped), for: .touchUpInside)
        resetPasswordButton.addTarget(viewModel, action: #selector(viewModel.resetPasswordButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(signInLabel)
        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(250)
        }
        
        view.addSubview(emailTF)
        emailTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signInLabel.snp.bottom).offset(30)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.leading.equalTo(view.snp.leading).offset(60)
        }
        
        view.addSubview(passwordTF)
        passwordTF.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(emailTF.snp.bottom).offset(15)
            make.trailing.equalTo(view.snp.trailing).offset(-60)
            make.leading.equalTo(view.snp.leading).offset(60)
            make.height.equalTo(emailTF.snp.height)
        }
        
        view.addSubview(signInButton)
        signInButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passwordTF.snp.bottom).offset(20)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(backToRegisterButton)
        backToRegisterButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(view.snp.bottom).offset(-100)
            make.trailing.equalTo(view.snp.trailing).offset(-30)
            make.leading.equalTo(view.snp.leading).offset(30)
        }
        
        
        view.addSubview(resetPasswordButton)
        resetPasswordButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.snp.centerX)
            make.bottom.equalTo(backToRegisterButton.snp.top).offset(-20)
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
