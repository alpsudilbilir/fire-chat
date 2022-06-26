//
//  User.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import Foundation
import UIKit

struct User: Codable {
    var uid = UUID()
    var email: String = ""
    var password: String = ""
    var imageUrl: String?
}
