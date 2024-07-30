//
//  UploadVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//
import Foundation
import UIKit
import SnapKit

class UploadVC : UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    let viewModel : UploadVM
    
    let uploadImageView : UIImageView = {
        let image = UIImageView()
        image.image = UIImage(named: "uploadIcon")
        image.layer.borderWidth = 0.5
        image.isUserInteractionEnabled = true
        return image
    }()
    
    let uploadButton: UIButton = {
        let button = UIButton()
        button.setTitle("Upload", for: .normal)
        button.backgroundColor = .orange
        button.titleLabel?.font = .systemFont(ofSize: 20, weight: .semibold)
        button.layer.cornerRadius = 7
        button.isEnabled = false
        button.alpha = 0.5
        return button
    }()
    
    init() {
        self.viewModel = UploadVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.uploadVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupConstraints()
        viewModel.setupKeyboardDismissal(view: self.view)
        
        uploadButton.addTarget(viewModel, action: #selector(viewModel.uploadButtonTapped), for: .touchUpInside)
        
        let selectImageGesture = UITapGestureRecognizer(target: self, action: #selector(selectImageFromLibrary))
        uploadImageView.addGestureRecognizer(selectImageGesture)
    }
    
    func setupConstraints() {
        view.addSubview(uploadImageView)
        uploadImageView.snp.makeConstraints { make in
            make.top.equalTo(view.snp.top).offset(80)
            make.bottom.equalTo(view.snp.bottom).offset(-400)
            make.trailing.equalTo(view.snp.trailing).offset(-40)
            make.leading.equalTo(view.snp.leading).offset(40)
        }
        
        view.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(uploadImageView.snp.bottom).offset(150)
            make.width.equalTo(120)
            make.height.equalTo(50)
        }
    }
    
    @objc func selectImageFromLibrary() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        uploadImageView.image = info[.editedImage] as? UIImage
        uploadButton.isEnabled = true
        uploadButton.alpha = 1.0
        self.dismiss(animated: true, completion: nil)
    }
}
