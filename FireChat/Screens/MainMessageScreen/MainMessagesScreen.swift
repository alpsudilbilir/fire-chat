//
//  MainMessages.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct MainMessagesScreen: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
    var body: some View {
        VStack {
            CustomNavBar()
            MessageItem { user in
                viewModel.userThatWillBeMessaged = user
                print(user!.email + "Setted to userthatwillbemessaged.")
                viewModel.isNavigationLinkActive.toggle()
            }
            if let user = viewModel.userThatWillBeMessaged {
                NavigationLink("", isActive: $viewModel.isNavigationLinkActive) {
                    ChatScreen(user: user)
                }
            }
        }
        .environmentObject(viewModel)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $viewModel.isUserLoggedOut, onDismiss: nil) {
            LoginRegisterScreen()
                .environmentObject(viewModel)
        }
    }
}
struct MainMessages_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesScreen()
            .environmentObject(MainMessagesViewModel())
    }
}
