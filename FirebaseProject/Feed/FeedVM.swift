//
//  FeedVM.swift
//  FirebaseProject
//
//  Created by Omer Keskin on 26.07.2024.
//

import Foundation
import Firebase
import FirebaseFirestore
import FirebaseStorage


class FeedVM{
    

    weak var feedVC : FeedVC?
    var posts: [Post] = []
    

    func fetchPosts() {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").order(by: "date", descending: true).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            } else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    self.posts.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        if let imageUrl = document.get("imageURL") as? String,
                           let postedBy = document.get("postedBy") as? String {
                            let post = Post(imageURL: imageUrl, postedBy: postedBy, documentId: document.documentID)
                            self.posts.append(post)
                        }
                    }
                    
                    self.feedVC?.collectionView.reloadData()
                }
            }
        }
    }
    
    func fetchComments(for postId: String, completion: @escaping ([Comment]) -> Void) {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").document(postId).collection("Comments").order(by: "date", descending: false).addSnapshotListener { (snapshot, error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
                completion([])
            } else {
                var comments: [Comment] = []
                
                if snapshot?.isEmpty != true && snapshot != nil {
                    for document in snapshot!.documents {
                        if let commentText = document.get("commentText") as? String,
                           let commentedBy = document.get("commentedBy") as? String {
                            let comment = Comment(commentText: commentText, commentedBy: commentedBy, documentId: document.documentID)
                            comments.append(comment)
                        }
                    }
                }
                
                completion(comments)
            }
        }
    }
    
    func addComment(to postId: String, commentText: String) {
        let firestoreDB = Firestore.firestore()
        let commentData = ["commentText": commentText, "commentedBy": Auth.auth().currentUser!.email!, "date": FieldValue.serverTimestamp()] as [String: Any]
        
        firestoreDB.collection("Posts").document(postId).collection("Comments").addDocument(data: commentData) { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func deleteComment(from postId: String, commentId: String) {
        let firestoreDB = Firestore.firestore()
        firestoreDB.collection("Posts").document(postId).collection("Comments").document(commentId).delete { (error) in
            if error != nil {
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    



    
}

