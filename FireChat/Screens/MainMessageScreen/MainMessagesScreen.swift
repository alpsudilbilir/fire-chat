//
//  MainMessages.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct MainMessagesScreen: View {
    @EnvironmentObject var profileVm: ProfileScreenViewModel
    @EnvironmentObject var mainVm: MainMessagesViewModel
    var body: some View {
        VStack {
            CustomNavBar()
            MessageItem { user in
                mainVm.userThatWillBeMessaged = user
                print(user!.email + "Setted to userthatwillbemessaged.")
                mainVm.isNavigationLinkActive.toggle()
            }
            if let user = mainVm.userThatWillBeMessaged {
                NavigationLink("", isActive: $mainVm.isNavigationLinkActive) {
                    ChatScreen(user: user)
                        .environmentObject(profileVm)
                }
            }
        }
        .environmentObject(profileVm)
        .environmentObject(mainVm)
        .navigationBarHidden(true)
        .fullScreenCover(isPresented: $mainVm.isUserLoggedOut, onDismiss: nil) {
            LoginRegisterScreen()
                .environmentObject(mainVm)
                .onDisappear {
                    mainVm.fetchRecentMessages()
                }
        }
    }
}
struct MainMessages_Previews: PreviewProvider {
    static var previews: some View {
        MainMessagesScreen()
            .environmentObject(MainMessagesViewModel())
    }
}
