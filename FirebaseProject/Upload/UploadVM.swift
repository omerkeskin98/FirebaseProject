//
//  UploadVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//
import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage

class UploadVM {
    
    weak var uploadVC: UploadVC?
    
    @objc func uploadButtonTapped(_ sender: Any) {
        let storage = Storage.storage()
        let storageRef = storage.reference()
        let mediaFolder = storageRef.child("media")
        
        if let data = uploadVC?.uploadImageView.image?.jpegData(compressionQuality: 1) {
            let uuid = UUID().uuidString
            let imageRef = mediaFolder.child("\(uuid).jpg")
            imageRef.putData(data, metadata: nil) { (metadata, error) in
                if let error = error {
                    self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
                } else {
                    imageRef.downloadURL { (url, error) in
                        if let error = error {
                            self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
                        } else if let imageUrl = url?.absoluteString {
                            // DATABASE
                            let firestoreDB = Firestore.firestore()
                            let firestorePost = [
                                "imageURL": imageUrl,
                                "postedBy": Auth.auth().currentUser!.email!,
                                "date": FieldValue.serverTimestamp(),
                                "likes": 0
                            ] as [String: Any]
                            
                            firestoreDB.collection("Posts").addDocument(data: firestorePost) { error in
                                if let error = error {
                                    self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
                                } else {
                                    self.alertFunc(alertTitle: "Success", alertMessage: "Upload is successful!")
                                    self.uploadVC?.uploadImageView.image = UIImage(named: "uploadIcon")
                                    
                                    // Set the download URL in DownloadVC
                                    if let tabBarVC = self.uploadVC?.tabBarController as? TabBarVC,
                                       let downloadVC = tabBarVC.viewControllers?.compactMap({ $0 as? DownloadVC }).first {
                                        downloadVC.viewModel.downloadURL = imageUrl
                                        downloadVC.downloadURLLabel.text = imageUrl
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        warning.addAction(okButton)
        uploadVC?.present(warning, animated: true, completion: nil)
    }
    
    func setupKeyboardDismissal(view: UIView) {
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
    }
    
    @objc func hideKeyboard() {
        uploadVC?.view.endEditing(true)
    }
}
