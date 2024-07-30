//
//  TabBar.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import UIKit

class TabBarVC: UITabBarController {
    
    
    
    let feedVC = FeedVC()
    let profileVC = ProfileVC()
    let uploadVC = UploadVC()
    let downloadVC = DownloadVC()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        customTabBarController()
       
        tabBar.isTranslucent = false
        tabBar.backgroundColor = .white
    }
    
    
    func customTabBarController() {
        
        let feedVC = feedVC
        feedVC.tabBarItem = UITabBarItem(title: "Feed", image: UIImage(systemName: "house"), selectedImage: UIImage(systemName: "house.fill"))
        
        let uploadVC = uploadVC
        uploadVC.tabBarItem = UITabBarItem(title: "Upload", image: UIImage(systemName: "u.circle"), selectedImage: UIImage(systemName: "u.circle.fill"))
        
        let downloadVC = downloadVC
        downloadVC.tabBarItem = UITabBarItem(title: "Download", image: UIImage(systemName: "d.circle"), selectedImage: UIImage(systemName: "d.circle.fill"))
        
        let profileVC = profileVC
        profileVC.tabBarItem = UITabBarItem(title: "Profile", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        
        self.viewControllers = [feedVC, uploadVC, downloadVC, profileVC]
        

    }
    
    func setupTabBarAppearance() {
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false
        let appearance = UITabBarItem.appearance()
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .normal)
        appearance.setTitleTextAttributes([.foregroundColor: UIColor.blue], for: .selected)
    }
    
}
