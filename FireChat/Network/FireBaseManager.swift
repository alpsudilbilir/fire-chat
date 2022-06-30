//
//  FireBaseAuth.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.06.2022.
//

import Foundation
import Firebase
import FirebaseStorage
import FirebaseFirestore

class FireBaseManager: NSObject {
    let auth: Auth
    let storage: Storage
    let firestore: Firestore

    static let shared = FireBaseManager()
    
    override init() {
        self.auth = Auth.auth()
        self.storage = Storage.storage()
        self.firestore = Firestore.firestore()
        super.init()
    }
}
