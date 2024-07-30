//
//  MailPageVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//

import UIKit
import SnapKit

class VerifyPageVC: UIViewController {
    
    let viewModel: VerifyPageVM

    let verifyLabel: UILabel = {
        let label = UILabel()
        label.text = "Click to verify"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 25, weight: .regular)
        label.textColor = .black
        return label
    }()
    
    
    let verifyButton: UIButton = {
        let button = UIButton()
        button.setTitle("Send verification mail", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .medium)
        button.layer.cornerRadius = 7
        return button
    }()
    
    init() {
        self.viewModel = VerifyPageVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.verifyPageVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        verifyButton.addTarget(viewModel, action: #selector(viewModel.verifyButtonTapped), for: .touchUpInside)
    }
    
    func setupConstraints() {
        view.addSubview(verifyLabel)
        verifyLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(250)
        }
        

        view.addSubview(verifyButton)
        verifyButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(verifyLabel.snp.bottom).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-90)
            make.leading.equalTo(view.snp.leading).offset(90)
            make.height.equalTo(40)
        }
        
    }

}
