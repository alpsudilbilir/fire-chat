//
//  ViewExtensions.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 7.08.2022.
//

import Foundation
import SwiftUI

extension View {
    func hasScrollEnabled(_ value: Bool) -> some View {
        self.onAppear {
            UITableView.appearance().isScrollEnabled = value
        }
    }
}
