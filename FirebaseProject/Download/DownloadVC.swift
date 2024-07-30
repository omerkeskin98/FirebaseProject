//
//  DownloadVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 29.07.2024.
//


import UIKit
import SnapKit

class DownloadVC: UIViewController {
    
    let viewModel: DownloadVM
    
    let downloadURLLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    let downloadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Download Photo", for: .normal)
        button.backgroundColor = .blue
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 7
        return button
    }()
    
    init() {
        self.viewModel = DownloadVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.downloadVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupConstraints()
        
        downloadButton.addTarget(viewModel, action: #selector(viewModel.downloadImage), for: .touchUpInside)
        
        print("Download URL in viewDidLoad: \(viewModel.downloadURL ?? "No URL set")")
    }
    
    func setupConstraints() {
        view.addSubview(downloadURLLabel)
        downloadURLLabel.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(100)
            make.leading.equalTo(view.snp.leading).offset(20)
            make.trailing.equalTo(view.snp.trailing).offset(-20)
        }
        
        view.addSubview(downloadButton)
        downloadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(downloadURLLabel.snp.bottom).offset(50)
            make.width.equalTo(200)
            make.height.equalTo(50)
        }
    }
}
