//
//  CommentViewController.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 29.07.2024.
//


import UIKit
import SnapKit

class CommentViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var post: Post
    var comments: [Comment] = []
    var commentTextField: UITextField!
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 90
        return tableView
    }()
    
    private let noCommentsLabel: UILabel = {
        let label = UILabel()
        label.text = "No comments yet"
        label.textAlignment = .center
        label.textColor = .gray
        label.isHidden = true
        return label
    }()
    
    init(post: Post) {
        self.post = post
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        setupTableView()
        setupCommentInput()
        setupNoCommentsLabel()
        
        fetchComments()
    }
    
    func setupTableView() {
        view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        tableView.snp.makeConstraints { make in
            make.top.leading.trailing.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
        }
    }
    
    func setupNoCommentsLabel() {
        view.addSubview(noCommentsLabel)
        noCommentsLabel.snp.makeConstraints { make in
            make.center.equalTo(view)
        }
    }
    
    func setupCommentInput() {
        commentTextField = UITextField()
        commentTextField.placeholder = "Add a comment..."
        commentTextField.borderStyle = .roundedRect
        commentTextField.translatesAutoresizingMaskIntoConstraints = false

        let sendButton = UIButton(type: .system)
        sendButton.setTitle("Send", for: .normal)
        sendButton.addTarget(self, action: #selector(sendButtonTapped), for: .touchUpInside)
        sendButton.translatesAutoresizingMaskIntoConstraints = false

        let commentInputView = UIView()
        commentInputView.addSubview(commentTextField)
        commentInputView.addSubview(sendButton)
        
        view.addSubview(commentInputView)
        
        commentInputView.snp.makeConstraints { make in
            make.left.right.equalTo(view)
            make.bottom.equalTo(view.snp.bottom).offset(-50)
            make.height.equalTo(50)
        }
        
        commentTextField.snp.makeConstraints { make in
            make.left.equalTo(commentInputView).offset(8)
            make.centerY.equalTo(commentInputView)
            make.right.equalTo(sendButton.snp.left).offset(-8)
            make.height.equalTo(30)
        }
        
        sendButton.snp.makeConstraints { make in
            make.right.equalTo(commentInputView).offset(-8)
            make.centerY.equalTo(commentInputView)
            make.width.equalTo(60)
            make.height.equalTo(30)
        }
    }
    
    @objc func sendButtonTapped() {
        guard let text = commentTextField.text, !text.isEmpty else { return }
        
        FeedVM().addComment(to: post.documentId, commentText: text)
        commentTextField.text = ""
        fetchComments()
    }
    
    func fetchComments() {
        FeedVM().fetchComments(for: post.documentId) { comments in
            self.comments = comments
            self.tableView.reloadData()
            self.updateNoCommentsLabelVisibility()
        }
    }
    
    func updateNoCommentsLabelVisibility() {
        noCommentsLabel.isHidden = !comments.isEmpty
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return comments.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "CommentCell", for: indexPath) as! CommentTableViewCell
        cell.configure(with: comments[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let comment = comments[indexPath.row]
            FeedVM().deleteComment(from: post.documentId, commentId: comment.documentId)
            fetchComments()
        }
    }
}
