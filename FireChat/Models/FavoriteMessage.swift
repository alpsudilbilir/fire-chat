//
//  FavoriteMessage.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import Foundation

struct FavoriteMessage: Codable {
    var uid: String // Will Be document
    var fromId: String // Will Be Docoument
    
    var from: String
    var message: String
    var timestamp: Date
    var imageUrl: String
    
    var username: String {
        from.components(separatedBy: "@").first ?? from
    }
}
