//
//  ChatScreenViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 8.07.2022.
//

import Foundation
import Firebase
import UIKit


class ChatScreenViewModel: ObservableObject {
    @Published var messageText: String = ""
    @Published var messages = [ChatMessage]()
    @Published var placeholder = "Message"
    @Published var isSendButtonDisabled = false
    @Published var disableSendButtonIfPhotoIsLoading = false
    @Published var userStatus: String = ""
    var imageUrl: URL?
    var recipientUser: User?
    var snapshotListener: ListenerRegistration?
    init(user: User?) {
        self.recipientUser = user
        self.isSendButtonDisabled = messageText.isEmpty
    }
    
    func checkSendButton() -> Bool {
        if disableSendButtonIfPhotoIsLoading {
            return true
        }
        else if isSendButtonDisabled {
            return true
        } else {
            return false
        }
    }
    func fetchUserStatus(uid: String) {
        var status: String = ""
        FireBaseManager.shared.firestore.collection("users").document(uid).getDocument { snapshot, err in
            if let err = err {
                print("Failed to get status")
                return
            }
            guard let data = snapshot?.data() else {
                print("No status data found")
                return
            }
            let status = data["status"] as? String ?? ""
            self.userStatus = status
        }
    }
    func saveChatImageToStorage(image: UIImage?) {
        disableSendButtonIfPhotoIsLoading = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
        guard let recipientUserId = self.recipientUser?.uid else {
            print("Unable to get recipient user id.")
            return
        }
        let identifier = UUID()
        let ref = FireBaseManager.shared.storage.reference(withPath: uid + "/" +  recipientUserId + "/image/" + "\(identifier)")
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
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
                self.imageUrl = url
                self.disableSendButtonIfPhotoIsLoading = false
            }
        }
    }
    func fetchMessages() {
        guard let fromId = FireBaseManager.shared.auth.currentUser?.uid else { return } //Sending User
        guard let toId = recipientUser?.uid else { return } //Receiving User
        snapshotListener?.remove()
        messages.removeAll()
        snapshotListener = FireBaseManager.shared.firestore
            .collection("messages")
            .document(fromId)
            .collection(toId)
            .order(by: "timestamp")
            .addSnapshotListener { querySnapshot, err in
                if let err = err {
                    print("Failed to listen messages. \(err)")
                    return
                }
                querySnapshot?.documentChanges.forEach({ change in
                    if change.type == .added {
                        let data = change.document.data()
                        if let message = try? change.document.data(as: ChatMessage.self) {
                            self.messages.append(message)
                        }
                    } else if change.type == .removed {
                        let data = change.document.data()
                        if let message = try? change.document.data(as: ChatMessage.self) {
                            self.messages = self.messages.filter( { $0.id != message.id})
                        }
                    }
                })
            }
        print("Messages successfully fetched.")
    }
    func deleteMessageFromUser(message: ChatMessage) {
        //message.toId == uid ? message.fromId : message.toId
        guard let uid = FireBaseManager.shared.currentUser?.uid else { return }

        guard let messageId = message.id else {
            print("No message id found")
            return }
        print(messageId)
        FireBaseManager.shared.firestore
            .collection("messages")
            .document(uid)
            .collection(message.toId == uid ? message.fromId : message.toId)
            .document(messageId)
            .delete { err in
                if let err = err {
                    print("Failed to delete message")
                }
                print("Message successfully deleted.")
            }
    }

    func handleSend(imageUrl: URL?)  {
        guard let fromId = FireBaseManager.shared.auth.currentUser?.uid else { return } //Sending User
        guard let toId = recipientUser?.uid else { return } //Receiving User
        let document = FireBaseManager.shared.firestore.collection("messages").document(fromId).collection(toId).document()
        //Sending User Message stored in Firestore
        let messageData = ["fromId": fromId, "toId": toId, "message": self.messageText, "timestamp": Timestamp(), "imageUrl": imageUrl?.absoluteString ] as [String : Any]
        document.setData(messageData) { err in
            if let err = err {
                print("Failed to save message into Firestore: \(err)")
                return
            }
            print("Successfully saved current user sending message!")
        }
        saveMessageForMainScreen()
        let receivedMessageDocument = FireBaseManager.shared.firestore.collection("messages").document(toId).collection(fromId).document()
        receivedMessageDocument.setData(messageData) { err in
            if let err = err {
                print("Failed to save message into Firestore: \(err)")
                return
            }
            print("Successfully saved received message as well.")
        }
        self.messageText = ""
    }
    func saveMessageForMainScreen() {
        guard let fromId = FireBaseManager.shared.auth.currentUser?.uid else { return }
        guard let toId = self.recipientUser?.uid else { return }
        /*----------------------------------------------------------
         Save for current user
         ----------------------------------------------------------*/
        let document = FireBaseManager.shared.firestore
            .collection("recent_messages")
            .document(fromId)
            .collection("recentMessages")
            .document(toId)
        let data  = [
            "timestamp": Timestamp(),
            "message" : self.messageText,
            "fromId" : fromId,
            "toId" : toId,
            "imageUrl" : recipientUser?.imageUrl ?? "",
            "email" : recipientUser?.email,
            "status": recipientUser?.status
        ] as [String : Any]
        document.setData(data) { err in
            if let err = err {
                print("Failed to save recent messages \(err)")
                return
            }
            print("Successfully saved recent_messages.")
        }
        /*----------------------------------------------------------
         Save for recipient user
         ----------------------------------------------------------*/
        guard let currentUser = FireBaseManager.shared.currentUser else { return }
        
        let recipientRecentMessageDictionary = [
            "timestamp" : Timestamp(),
            "message": self.messageText,
            "fromId": currentUser.uid,
            "toId" : toId,
            "imageUrl" : currentUser.imageUrl ?? "",
            "email": currentUser.email,
            "status": currentUser.status
        ] as [String : Any]
        
        FireBaseManager.shared.firestore
            .collection("recent_messages")
            .document(toId)
            .collection("recentMessages")
            .document(currentUser.uid)
            .setData(recipientRecentMessageDictionary) { error in
                if let error = error {
                    print("Failed to save recipient recent message: \(error)")
                    return
                }
                print("Successfully saved recent_messages for recipient as well.")
            }
    }
}
