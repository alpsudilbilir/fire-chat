//
//  MainMessages.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct MainMessages: View {
    var body: some View {
        NavigationView {
            VStack {
                CustomNavBar()
                MessageItem()
            }
            .overlay(NewMessageButton(), alignment: .bottom)
            .navigationBarHidden(true)
        }
    }
}

struct MainMessages_Previews: PreviewProvider {
    static var previews: some View {
        MainMessages()
    }
}
