//
//  FireChatApp.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI
import Firebase

@main
//TODO: Saving user status to firestore
//TODO: Saving favorite messages to user defaults (if it doesn't work try firestore)
//TODO: Save favorite images to user defaults.
//TODO: Fix changin profile image bug. (Changing profile photo is making all sent photos same with profile image)
//--------------------
struct FireChatApp: App {
    @StateObject var viewModel =  MainMessagesViewModel()
    @StateObject var vm = ProfileScreenViewModel()
    @Environment(\.colorScheme) var colorScheme
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme( vm.isDarkModeOn  ? .dark : .light)
                .environmentObject(viewModel)
                .environmentObject(vm)
        }

        
    }
}
