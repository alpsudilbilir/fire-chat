//
//  ContentView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 4.07.2022.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
    var body: some View {
        TabView {
            NavigationView{
                MainMessages()
                    .environmentObject(viewModel)

            }
            .tabItem{
                Text("Messages")
                Image(systemName: "message.fill")
            }
            
            
            NavigationView{
                Text("Settings")
                    .animation(Animation.default)
                    .transition(.move(edge: .bottom))
                    .navigationBarHidden(true)
                
            }
            .tabItem {
                Text("Settings")
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
