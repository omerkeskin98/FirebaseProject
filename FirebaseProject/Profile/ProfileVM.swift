//
//  ProfileVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import Firebase
import FirebaseRemoteConfig
import FirebaseCrashlytics

class ProfileVM {
    
    weak var profileVC: ProfileVC?
    private var remoteConfig: RemoteConfig
    
    init() {
        remoteConfig = RemoteConfig.remoteConfig()
        let settings = RemoteConfigSettings()
        settings.minimumFetchInterval = 0
        remoteConfig.configSettings = settings


        if let defaultsPath = Bundle.main.path(forResource: "RemoteConfigDefaults", ofType: "plist"),
           let defaults = NSDictionary(contentsOfFile: defaultsPath) as? [String: NSObject] {
            remoteConfig.setDefaults(defaults)
        }

        fetchRemoteConfig()
    }
    
    @objc func logoutButtonTapped() {
        do {
            try Auth.auth().signOut()
            navigateToRegisterPage()
        } catch let signOutError as NSError {
            print("Error signing out: %@", signOutError)
            alertFunc(alertTitle: "Logout Error", alertMessage: signOutError.localizedDescription)
        }
    }
    
    @objc func crashButtonTapped(_ sender: AnyObject) {
        fatalError("Test crash to verify Firebase Crashlytics setup.")
        
    }
    
    private func navigateToRegisterPage() {
        guard let window = UIApplication.shared.windows.first else {
            return
        }

        let signupVC = SignUpPageVC()
        let navigationController = UINavigationController(rootViewController: signupVC)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
    }
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        warning.addAction(okButton)
        profileVC!.present(warning, animated: true, completion: nil)
    }
    
    private func fetchRemoteConfig() {
        remoteConfig.fetch { [weak self] status, error in
            if status == .success {
                self?.remoteConfig.activate { changed, error in
                    self?.applyRemoteConfigValues()
                }
            } else {
                print("Failed to fetch remote config: \(String(describing: error?.localizedDescription))")
            }
        }
    }
    
    private func applyRemoteConfigValues() {
        guard let profileVC = profileVC else { return }

        let stringValue = remoteConfig["stringValue"].boolValue
        let numberValue = remoteConfig["numberValue"].boolValue
        let imageHidden = remoteConfig["imageHidden"].boolValue

        DispatchQueue.main.async {
            profileVC.stringLabel.isHidden = stringValue
            profileVC.numberLabel.isHidden = numberValue
            profileVC.profileImageView.isHidden = imageHidden
        }
    }
}
