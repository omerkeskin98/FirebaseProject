//
//  ProfileVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import UIKit
import SnapKit
import FirebaseCrashlytics

class ProfileVC : UIViewController{
    
    let viewModel : ProfileVM
    
    let logoutButton: UIButton = {
        let button = UIButton()
        button.setTitle("Logout", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.layer.cornerRadius = 7
        return button
    }()
    
    let crashButton: UIButton = {
        let button = UIButton()
        button.setTitle("Crash App", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 25, weight: .medium)
        button.layer.cornerRadius = 7
        return button
    }()
    
    let stringLabel: UILabel = {
        let label = UILabel()
        label.text = "Firebase Remote Config"
        label.font = .systemFont(ofSize: 18)
        label.isHidden = false
        return label
    }()

    let numberLabel: UILabel = {
        let label = UILabel()
        label.text = "0"
        label.font = .systemFont(ofSize: 18)
        label.isHidden = false
        return label
    }()

    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "person.circle")
        imageView.isHidden = false
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    init() {
        self.viewModel = ProfileVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.profileVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        logoutButton.addTarget(viewModel, action: #selector(viewModel.logoutButtonTapped), for: .touchUpInside)
        crashButton.addTarget(viewModel, action: #selector(viewModel.crashButtonTapped(_:)), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
        
        view.addSubview(crashButton)
        crashButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoutButton.snp.bottom).offset(150)
            make.width.equalTo(150)
            make.height.equalTo(50)
        }
        
        
        view.addSubview(stringLabel)
        stringLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).offset(20)
            make.centerX.equalToSuperview()
        }

        view.addSubview(numberLabel)
        numberLabel.snp.makeConstraints { make in
            make.top.equalTo(stringLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
        }

        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.top.equalTo(numberLabel.snp.bottom).offset(20)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(100)
        }
    }
}
