//
//  ResetPasswordVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import Firebase

class ResetPasswordVM{
    
    weak var resetPasswordVC : ResetPasswordVC?
    
    
    
    @objc func resetButtonTapped() {
        guard let email = resetPasswordVC?.emailTF.text, !email.isEmpty else {
            alertFunc(alertTitle: "Reset Password Error", alertMessage: "Please enter your email")
            return
        }
        
        Auth.auth().sendPasswordReset(withEmail: email) { error in
            if let error = error {
                self.alertFunc(alertTitle: "Reset Password Error", alertMessage: error.localizedDescription)
            } else {
                self.alertFunc(alertTitle: "Reset Password", alertMessage: "A password reset link has been sent to your email")
            }
        }
    }
    
    
    func setupKeyboardDismissal(view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        resetPasswordVC?.view.endEditing(true)
    }
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self!.resetPasswordVC?.dismiss(animated: true)
        }
        warning.addAction(okButton)
        resetPasswordVC?.present(warning, animated: true, completion: nil)
    }
    
    
    
}
