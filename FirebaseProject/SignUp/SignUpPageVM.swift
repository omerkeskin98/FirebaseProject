//
//  SignUpPageVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth

class SignUpPageVM {
    
    weak var viewController : UIViewController?
    weak var signupPageVC : SignUpPageVC?
    weak var verifyPageVC : VerifyPageVM?
    
    init(viewController: UIViewController?, signupPageVC: SignUpPageVC?) {
        self.viewController = viewController
        self.signupPageVC = signupPageVC
    }
    
    @objc func signInButtonTapped() {
    
        let loginPageVC = LoginPageVC()
        viewController?.navigationController?.pushViewController(loginPageVC, animated: true)
    }
    
    @objc func signUpButtonTapped() {
        guard let email = signupPageVC?.emailTF.text, !email.isEmpty,
              let password = signupPageVC?.passwordTF.text, !password.isEmpty else {
            alertFunc(alertTitle: "Sign Up Error", alertMessage: "Please enter your email and password")
            return
        }
        
        Auth.auth().createUser(withEmail: email, password: password) { (authData, error) in
            if let error = error {
                self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
            } else {
                let mailPageVC = VerifyPageVC()
                mailPageVC.modalPresentationStyle = .fullScreen
                self.viewController?.present(mailPageVC, animated: true, completion: nil)
            }
        }
    }
    
    func setupKeyboardDismissal(view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        viewController?.view.endEditing(true)
    }
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        warning.addAction(okButton)
        viewController?.present(warning, animated: true, completion: nil)
    }
}
