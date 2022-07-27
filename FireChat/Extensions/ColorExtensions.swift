//
//  ColorExtensions.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import Foundation
import SwiftUI

extension Color {
    static let fire = Color.red.opacity(0.7)
    
    static func statusColor(status: String) -> Color {
        switch status {
        case "online":
            return Color.green
        case "offline":
            return Color.gray
        case "busy":
            return Color.red
        default:
            return Color.white
        }
   
    }
}
extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}
