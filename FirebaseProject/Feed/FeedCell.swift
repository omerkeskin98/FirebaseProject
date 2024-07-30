//
//  FeedCell.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 29.07.2024.
//

import UIKit
import SnapKit

class FeedCell: UICollectionViewCell {
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFit
        iv.clipsToBounds = true
        return iv
    }()
    
    let commentButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Comment", for: .normal)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubview(usernameLabel)
        addSubview(imageView)
        addSubview(commentButton)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(8)
        }
        
        imageView.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(10)
            make.left.right.equalToSuperview()
            make.height.equalTo(400)
        }
        
        commentButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(8)
            make.bottom.equalToSuperview().offset(-10)
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with post: Post) {
        usernameLabel.text = post.postedBy
        if let url = URL(string: post.imageURL) {
            imageView.loadImage(from: url)
        }
    }
}

extension UIImageView {
    func loadImage(from url: URL) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data, error == nil {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }.resume()
    }
}
