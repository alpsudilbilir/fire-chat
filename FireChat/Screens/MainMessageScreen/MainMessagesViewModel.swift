//
//  MainMessagesViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import Foundation
import Firebase

class MainMessagesViewModel: ObservableObject {
    @Published var user: User?
    init() {
        fetchCurrentUser()
    }
    private func fetchCurrentUser() {
        guard let uid =  FireBaseManager.shared.auth.currentUser?.uid else { return }
        
        FireBaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, err in
            if let err = err {
                print("Failed to fetch current user \(err)")
                return
            }
            guard let data = snapshot?.data() else {
                print("No data found.")
                return
    
            }
            print(data)
            let uid = data["uid"] as? String ?? ""
            let email = data["email"] as? String ?? ""
            let imageUrl = data["imageUrl"] as? String ?? ""
            self.user = User(uid: uid, email: email, imageUrl: imageUrl)
        }
    }
}
