//
//  ChatMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 8.07.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct ChatMessage:Codable, Identifiable {
    @DocumentID var id: String?
    
    let fromId: String
    let toId: String
    let message: String
    let imageUrl: String?
    let timestamp: Date
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }
    
    var sentTime: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        return formatter.string(from: timestamp)
    }

}


