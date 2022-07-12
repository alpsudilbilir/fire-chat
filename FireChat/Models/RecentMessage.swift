//
//  RecentMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 12.07.2022.
//

import Foundation
import Firebase
struct RecentMessage: Identifiable {
    
    var id: String { documentId }
    let documentId: String
    
    let message: String
    let email: String
    let fromId, toId: String
    let imageUrl: String
    let timestamp: Timestamp
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.message = data["message"] as? String ?? ""
        self.email = data["email"] as? String ?? ""
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.imageUrl = data["imageUrl"] as? String ?? ""
        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
    }    
}
