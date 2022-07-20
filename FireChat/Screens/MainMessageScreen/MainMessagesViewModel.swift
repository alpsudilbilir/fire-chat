//
//  MainMessagesViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
import UIKit
import SwiftUI

class MainMessagesViewModel: ObservableObject {
    @Published var currentUser: User? // Current User
    @Published var userThatWillBeMessaged: User?
    @Published var isUserLoggedOut = false
    @Published var isNavigationLinkActive = false
    @Published var recentMessages = [RecentMessage]()
    @Published var isProgressContinues = false
    @Published var isPhotoLoading = false
    @Published var showLoginAlert = false
    @Published var showRegistirationAlert = false
    private var firestoreListeener: ListenerRegistration?
    
    init() {
        DispatchQueue.main.async {
            self.isUserLoggedOut = FireBaseManager.shared.auth.currentUser?.uid == nil
        }
        fetchCurrentUser()
    }
    func loginUser(email: String, password: String) {
        self.isProgressContinues = true
        FireBaseManager.shared.auth.signIn(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Failed to login. \(err)")
                self.showLoginAlert = true
                self.isProgressContinues = false
                return
            }
            self.fetchCurrentUser()
            print("Succesfully logged in.")
                self.isUserLoggedOut = false
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
        self.isProgressContinues = true
        if image == nil {
            print("You need to select an image")
            self.showRegistirationAlert = true
            self.isProgressContinues = false
            return
        }
        FireBaseManager.shared.auth.createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                self.showRegistirationAlert = true
                self.isProgressContinues = false
                return
            }
            self.saveImageToStorage(email: email, password: password, image: image!)
            print("Successfully created user: \(result?.user.uid ?? "")")
        }
    }
     func saveImageToStorage(email: String,password: String, image: UIImage) {
         self.isPhotoLoading = true
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
            self.isUserLoggedOut = false
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
        self.isPhotoLoading = false

    }
    func fetchRecentMessages() {
        guard let uid = FireBaseManager.shared.auth.currentUser?.uid else { return }
        firestoreListeener?.remove()
        firestoreListeener = FireBaseManager.shared.firestore
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
                        return recent.id == docId
                    }) {
                        self.recentMessages.remove(at: index)
                    }
                    if let recentMessage = try? change.document.data(as: RecentMessage.self) {
                        self.recentMessages.insert(recentMessage, at: 0)
                        
                    }
                })
            }
    }
    func deleteAccount() {
        guard let user = FireBaseManager.shared.auth.currentUser else { return }
        self.deleteDeletedAccountInfoFromFireStore()
        user.delete { err in
            if let err = err {
                print("Failed to delete account")
                return
            }
            print("Account successfully deleted.")
            self.isUserLoggedOut = true
        }
    }
    func deleteDeletedAccountInfoFromFireStore() {
        guard let uid = FireBaseManager.shared.auth.currentUser?.uid else { return }
        FireBaseManager.shared.firestore.collection("users").document(uid).delete { err in
            if let err = err {
                print("Failed to delete data from firestore")
                return
            }
            print("Account data successfully deleted from firestore.")
        }
    }
}
