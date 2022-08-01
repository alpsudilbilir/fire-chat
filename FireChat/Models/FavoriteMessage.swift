//
//  FavoriteMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 1.08.2022.
//

import Foundation
import FirebaseFirestoreSwift

struct FavoriteMessage: Codable, Identifiable {
    @DocumentID var id: String?
    
    
    let from: String
    let message: String
    let timestamp: Date
    let imageUrl: String?
    
    var timeAgo: String {
        let formatter = RelativeDateTimeFormatter()
        formatter.unitsStyle = .abbreviated
        return formatter.localizedString(for: timestamp, relativeTo: Date())
    }

}
