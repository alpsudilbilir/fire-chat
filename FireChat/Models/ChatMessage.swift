//
//  ChatMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 8.07.2022.
//

import Foundation

struct ChatMessage: Identifiable {
    var id: String { documentId }
    
    let documentId: String
    let fromId: String
    let toId: String
    let message: String
    
    init(documentId: String, data: [String: Any]) {
        self.documentId = documentId
        self.fromId = data["fromId"] as? String ?? ""
        self.toId = data["toId"] as? String ?? ""
        self.message = data["message"] as? String ?? ""
    }
}
