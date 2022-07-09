//
//  NewMessageScreenViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 1.07.2022.
//

import Foundation


class NewMessageScreenViewModel: ObservableObject {
    @Published var users = [User]() // Users that will be showed to current user in new message screen.
    init() {
        fetchAllUsers()
    }
        private func fetchAllUsers() {
            FireBaseManager.shared.firestore.collection("users").getDocuments { snapshot, err in
                if let err = err {
                    print("Failed to fetch users. \(err)")
                    return
                }
                
                snapshot?.documents.forEach({ snapshot in
                    let data = snapshot.data()
                    let uid = data["uid"] as? String ?? ""
                    let email = data["email"] as? String ?? ""
                    let imageUrl = data["imageUrl"] as? String ?? ""
                    print(email)
                    self.users.append(User(uid: uid, email: email, password: "", imageUrl: imageUrl))
                    print("Users successfully fetched.")
                })
            }
        }
    }
