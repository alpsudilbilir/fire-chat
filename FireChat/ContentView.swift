//
//  ContentView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 4.07.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
    @EnvironmentObject var vm: ProfileScreenViewModel
    var body: some View {
        TabView {
            NavigationView{
                MainMessagesScreen()
                    .environmentObject(viewModel)
                    .environmentObject(vm)
            }
            .tabItem{
                Text("Messages")
                Image(systemName: "message.fill")
            }
            NavigationView{
                ProfileScreen()
                    .animation(Animation.default)
                    .transition(.move(edge: .bottom))
                    .accentColor(Color.fire)
                    .environmentObject(viewModel)
                    .environmentObject(vm)
            }
            .tabItem {
                Text("Profile")
                Image(systemName: "person")
            }
        }
        .accentColor(Color.fire)
    }
}

struct ContentViewPreviews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(MainMessagesViewModel())
    }
}
