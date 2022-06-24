//
//  FireBaseAuth.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.06.2022.
//

import Foundation
import Firebase

class FireBaseManager {

    func createNewAccount(email: String, password: String) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                return
            }
            print("Successfully created user: \(result?.user.uid ?? "")")
        }
    }
    
    func loginUser(email: String, password: String) {
        Auth.auth().signIn(withEmail: email, password: password) { res, err in
            if let err = err {
                print("Failed to login.")
                return
            }
            print("Succesfully logged in.")
        }
    }
}
