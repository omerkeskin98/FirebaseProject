//
//  LoginPageVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class LoginPageVM {
    
    weak var loginPageVC: LoginPageVC?
    
    init() {}
    
    @objc func signInButtonTapped() {
        guard let email = loginPageVC?.emailTF.text, !email.isEmpty,
              let password = loginPageVC?.passwordTF.text, !password.isEmpty else {
            alertFunc(alertTitle: "Sign Up Error", alertMessage: "Please enter your email and password")
            return
        }
        
        Auth.auth().signIn(withEmail: email, password: password) { (authData, error) in
            if let error = error {
                self.alertFunc(alertTitle: "Sign in error", alertMessage: "Incorrect email or password")
            } else {
                let tabBarController = TabBarVC()
                tabBarController.modalPresentationStyle = .fullScreen
                self.loginPageVC?.present(tabBarController, animated: true, completion: nil)
            }
        }
    }
    
    
    
    @objc func backToRegisterButtonTapped() {
        loginPageVC?.navigationController?.popViewController(animated: true)
    }

    
    @objc func resetPasswordButtonTapped() {
       
        let passwordResetVC = ResetPasswordVC()
        passwordResetVC.modalPresentationStyle = .popover
        loginPageVC!.present(passwordResetVC, animated: true, completion: nil)
    }
    
    func setupKeyboardDismissal(view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        loginPageVC?.view.endEditing(true)
    }
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        warning.addAction(okButton)
        loginPageVC?.present(warning, animated: true, completion: nil)
    }
}
