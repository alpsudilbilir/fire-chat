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
}
extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}
