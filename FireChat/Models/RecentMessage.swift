//
//  RecentMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 12.07.2022.
//

import Foundation
import Firebase
import FirebaseFirestoreSwift
struct RecentMessage: Codable, Identifiable {

    @DocumentID var id: String?
    
    let message: String
    let email: String
    let fromId, toId: String
    let imageUrl: String
    let timestamp: Date
    
    var username: String {
        email.components(separatedBy: "@").first ?? email
    }
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }

    
//Decoding JSON can be used instead of using FirebaseFirestoreSwift package.
//    init(documentId: String, data: [String: Any]) {
//        self.documentId = documentId
//        self.message = data["message"] as? String ?? ""
//        self.email = data["email"] as? String ?? ""
//        self.fromId = data["fromId"] as? String ?? ""
//        self.toId = data["toId"] as? String ?? ""
//        self.imageUrl = data["imageUrl"] as? String ?? ""
//        self.timestamp = data["timestamp"] as? Timestamp ?? Timestamp(date: Date())
//    }
}
