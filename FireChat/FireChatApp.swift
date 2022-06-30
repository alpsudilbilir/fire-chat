//
//  FireChatApp.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI
import Firebase

@main
struct FireChatApp: App {
    @StateObject var viewModel =  MainMessagesViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            MainMessages()
                .environmentObject(viewModel)
        }
    }
}
