//
//  DownloadVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 29.07.2024.
//

import Foundation
import UIKit
import Photos

class DownloadVM {
    
    weak var downloadVC: DownloadVC?
    var downloadURL: String?
    
    @objc func downloadImage() {
        guard let urlString = downloadURL, let url = URL(string: urlString) else {
            DispatchQueue.main.async {
                self.alertFunc(alertTitle: "Error", alertMessage: "Invalid URL")
            }
            return
        }
        
        print("Attempting to download image from URL: \(urlString)")
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error fetching data: \(error.localizedDescription)")
                DispatchQueue.main.async {
                    self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
                }
            } else if let data = data, let image = UIImage(data: data) {
                print("Image downloaded successfully. Attempting to save to library.")
                self.saveImageToLibrary(image: image)
            } else {
                print("Error: Data conversion error")
                DispatchQueue.main.async {
                    self.alertFunc(alertTitle: "Error", alertMessage: "Data conversion error")
                }
            }
        }
        task.resume()
    }
    
    private func saveImageToLibrary(image: UIImage) {
        PHPhotoLibrary.requestAuthorization { status in
            guard status == .authorized else {
                DispatchQueue.main.async {
                    self.alertFunc(alertTitle: "Error", alertMessage: "Photo Library access denied")
                }
                return
            }
            
            PHPhotoLibrary.shared().performChanges({
                let creationRequest = PHAssetCreationRequest.forAsset()
                creationRequest.addResource(with: .photo, data: image.pngData()!, options: nil)
            }) { success, error in
                DispatchQueue.main.async {
                    if success {
                        self.alertFunc(alertTitle: "Success", alertMessage: "Image saved to Photos")
                    } else if let error = error {
                        self.alertFunc(alertTitle: "Error", alertMessage: error.localizedDescription)
                    } else {
                        self.alertFunc(alertTitle: "Error", alertMessage: "Unknown error")
                    }
                }
            }
        }
    }
    
    private func alertFunc(alertTitle: String, alertMessage: String) {
        let warning = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: .alert)
        let okButton = UIAlertAction(title: "OK", style: .default, handler: nil)
        warning.addAction(okButton)
        DispatchQueue.main.async {
            self.downloadVC?.present(warning, animated: true, completion: nil)
        }
    }
}
