//
//  CommentTableViewCell.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 29.07.2024.
//


import UIKit
import SnapKit

class CommentTableViewCell: UITableViewCell {
    
    let usernameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    let commentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        contentView.addSubview(usernameLabel)
        contentView.addSubview(commentLabel)
        
        usernameLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
        }
        
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(usernameLabel.snp.bottom).offset(4)
            make.leading.equalTo(contentView.snp.leading).offset(8)
            make.trailing.equalTo(contentView.snp.trailing).offset(-8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-8)
        }
    }
    
    func configure(with comment: Comment) {
        usernameLabel.text = comment.commentedBy
        commentLabel.text = comment.commentText
    }
}
