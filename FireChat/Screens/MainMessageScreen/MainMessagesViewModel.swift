//
//  MainMessagesViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import Foundation
import Firebase
import UIKit
import SwiftUI

class MainMessagesViewModel: ObservableObject {
    @Published var currentUser: User? // Current User
    @Published var userThatWillBeMessaged: User?
    @Published var isUserLoggedOut = false
    @Published var isNavigationLinkActive = false
    @Published var recentMessages = [RecentMessage]()
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = FireBaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    func loginUser(email: String, password: String) {
        FireBaseManager.shared.auth.signIn(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Failed to login. \(err)")
                return
            }
            self.fetchCurrentUser()
            print("Succesfully logged in.")
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                self.isUserLoggedOut = false
            }
        }
    }
    func signOut() {
        do {
            try FireBaseManager.shared.auth.signOut()
            print("Successfuly signed out")
        } catch {
            print("Failed to sign out!")
        }
        isUserLoggedOut = true
    }
    func createNewAccount(email: String, password: String, image: UIImage?) {
        if image == nil {
            print("You need to select an image")
            return
        }
        FireBaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                return
            }
            self.saveImageToStorage(email: email, password: password, image: image!)
            print("Successfully created user: \(result?.user.uid ?? "")")
        }
    }
    private func saveImageToStorage(email: String,password: String, image: UIImage) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = FireBaseManager.shared.storage.reference(withPath: uid)
        guard let imageData = image.jpegData(compressionQuality: 0.5) else { return }
        ref.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                print("Failed to load image. \(err)")
                return
            }
            ref.downloadURL { url, err in
                if let err = err {
                    print("Failed to retrieve download URL. \(err)")
                    return
                }
                print("Successfully stored image with url.")
                guard let url = url else { return }
                self.saveUserInfo(email: email, password: password, imageUrl: url)
            }
        }
    }
    private func saveUserInfo(email: String,password: String, imageUrl: URL) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let userData = ["email": email,"password": password , "uid": uid, "imageUrl": imageUrl.absoluteString]
        
        FireBaseManager.shared.firestore.collection("users").document(uid).setData(userData) { err in
            if let err = err {
                print("Failed to save user info. \(err)")
                return
            }
            print("Succesfully user data is stored!")
            self.fetchCurrentUser()
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                self.isUserLoggedOut = false
            }
        }
    }
    private func fetchCurrentUser() {
        guard let uid =  FireBaseManager.shared.auth.currentUser?.uid else { return }
        FireBaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, err in
            if let err = err {
                print("Failed to fetch current user \(err)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found.")
                return
            }
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let imageUrl = data["imageUrl"] as? String ?? ""
            self.currentUser = User(uid: uid, email: email, imageUrl: imageUrl)
           FireBaseManager.shared.currentUser = self.currentUser
        }
    }
    func fetchRecentMessages() {
        guard let uid = FireBaseManager.shared.auth.currentUser?.uid else { return }

        FireBaseManager.shared.firestore
            .collection("recent_messages")
            .document(uid)
            .collection("recentMessages")
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    print("Failed to fetch recent messages \(err).")
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    let docId = change.document.documentID
                    if let index = self.recentMessages.firstIndex(where: { recent in
                        return recent.documentId == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    //Delete if the recent message comes from user itself.
                        self.recentMessages.insert(.init(documentId: docId, data: change.document.data()), at: 0)
                })
            }
    }
}
