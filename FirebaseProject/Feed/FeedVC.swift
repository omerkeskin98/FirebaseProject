//
//  MainPageVC.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 25.07.2024.
//

import Foundation
import UIKit
import Firebase
import FirebaseFirestore
import FirebaseStorage
import SnapKit

class FeedVC : UIViewController, UICollectionViewDelegate, UICollectionViewDataSource{
    
    var collectionView: UICollectionView!
    let viewModel : FeedVM
    
    let welcomeLabel : UILabel = {
       let label = UILabel()
        label.text = "Welcome!"
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 30, weight: .semibold)
        label.textColor = .black
        return label
    }()
    

    
   
    init() {
        self.viewModel = FeedVM()
        super.init(nibName: nil, bundle: nil)
        self.viewModel.feedVC = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        
        setupConstraints()
        
        setupCollectionView()
        viewModel.feedVC = self
        viewModel.fetchPosts()


    }
    
    
    
    func setupConstraints() {
        
        
        view.addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(view.snp.top).offset(250)
        }
    }
    
    
    func setupCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: view.frame.size.width, height: 500)
        
        collectionView = UICollectionView(frame: self.view.frame, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(FeedCell.self, forCellWithReuseIdentifier: "FeedCell")
        collectionView.backgroundColor = .white
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(view)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.posts.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "FeedCell", for: indexPath) as! FeedCell
        let post = viewModel.posts[indexPath.row]
        
        cell.configure(with: post)
        cell.commentButton.tag = indexPath.row
        cell.commentButton.addTarget(self, action: #selector(commentButtonTapped(_:)), for: .touchUpInside)
        
        return cell
    }
    
    @objc func commentButtonTapped(_ sender: UIButton) {
        let post = viewModel.posts[sender.tag]
        let commentVC = CommentViewController(post: post)
        commentVC.modalPresentationStyle = .popover
        present(commentVC, animated: true, completion: nil)
    }


    
}

extension FeedVC: UIPopoverPresentationControllerDelegate {
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
}

