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
    @StateObject var vm = ProfileScreenViewModel()
    @Environment(\.colorScheme) var colorScheme
    init() {
        FirebaseApp.configure()
    }
    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme( vm.isDarkModeOff  ? .light : .dark)
                .environmentObject(viewModel)
                .environmentObject(vm)
        }

        
    }
}
