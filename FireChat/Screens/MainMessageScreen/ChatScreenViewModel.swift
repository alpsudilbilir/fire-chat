//
//  ChatScreenViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 8.07.2022.
//

import Foundation
import Firebase

class ChatScreenViewModel: ObservableObject {
    
    @Published var messageText: String = ""
    @Published var messages = [String]()
    @Published var placeholder = "Message"
    @Published var isSendButtonDisabled = false
    let user: User?
    
    init(user: User) {
        self.user = user
    }
    
    func handleSend(text: String)  {
        guard let fromId = FireBaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = user?.uid else { return }
        let document = FireBaseManager.shared.firestore.collection("messages").document(fromId).collection(toId).document()
        //Sending User Message stored in Firestore
        let messageData = ["fromId": fromId, "toId": toId, "message": self.messageText, "timestamp": Timestamp() ] as [String : Any]
        document.setData(messageData) { err in
            if let err = err {
                print("Failed to save message into Firestore: \(err)")
                return
            }
            print("Succesfully saved current user sending message!")
        }
        //Receiving user
        let receivedMessageDocument = FireBaseManager.shared.firestore.collection("messages").document(toId).collection(fromId).document()
        receivedMessageDocument.setData(messageData) { err in
            if let err = err {
                print("Failed to save message into Firestore: \(err)")
                return
            }
            print("Succesfully saved received message as well.")
            self.messageText = ""
        }

    }
    
}
