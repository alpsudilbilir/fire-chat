//
//  FireChatApp.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI
import Firebase

@main
//TODO: Delete recent mesages
//TODO: Fix the bug. (When chat message deleted view is not refreshing.)
//--------------------
struct FireChatApp: App {
    @Environment(\.colorScheme) var colorScheme
    @StateObject var mainMessagesVm =  MainMessagesViewModel()
    @StateObject var profileVm = ProfileScreenViewModel()
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme( profileVm.isDarkModeOn  ? .dark : .light)
                .environmentObject(mainMessagesVm)
                .environmentObject(profileVm)
        }
    }
}
