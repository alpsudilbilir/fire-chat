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
    var body: some Scene {
        WindowGroup {
            StartScreen()
                .onAppear {
                    FirebaseApp.configure()
                }
        }
    }
}
