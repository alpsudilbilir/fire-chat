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
}
