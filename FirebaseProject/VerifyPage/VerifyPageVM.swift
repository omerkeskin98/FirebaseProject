//
//  MailPageVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseAuth

class VerifyPageVM{
    
    var verifyPageVC : VerifyPageVC?
    
    @objc func verifyButtonTapped() {
    
        guard let user = Auth.auth().currentUser else {
            alertFunc(alertTitle: "Error", alertMessage: "User not logged in")
            return
        }

        user.sendEmailVerification { [weak self] (error) in
            if let error = error {
                self?.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
            } else {
                self?.alertFunc(alertTitle: "Notification", alertMessage: "Verification mail has been sent, please check your mailbox")
            }
        }
    }
    
    
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
            self?.navigateToLoginPage()
        }
        warning.addAction(okButton)
        verifyPageVC?.present(warning, animated: true, completion: nil)
    }

    private func navigateToLoginPage() {
        // Ensure you have a reference to the current window
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        let loginVC = LoginPageVC()
        let navigationController = UINavigationController(rootViewController: loginVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
}
