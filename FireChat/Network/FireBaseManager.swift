//
//  FireBaseAuth.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import UIKit

class FireBaseManager {

    func createNewAccount(email: String, password: String, image: UIImage) {
        Auth.auth().createUser(withEmail: email, password: password) { result, err in
            if let err = err {
                print("Failed to create user:", err)
                return
            }
            self.saveImageToStorage(image: image)
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
    
    func saveImageToStorage(image: UIImage) {
        //let filename = UUID().uuidString
        guard let uid = Auth.auth().currentUser?.uid else { return }
        let ref = Storage.storage().reference(withPath: uid)
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
            }
        }
        
    }
}
