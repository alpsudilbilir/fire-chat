//
//  RecentMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 12.07.2022.
//

//1
//service cloud.firestore {
//2
//  match /databases/{database}/documents {
//3
//    match /{document=**} {
//4
//      allow read, write: if true;
//5
//    }
//6
//  }
//7
//}


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
}
