//
//  ChatScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 2.07.2022.
//

import SwiftUI

struct ChatScreen: View {
    @State var user: User
    
    var body: some View {
        VStack {
            Text("Chat Here!")
        }
        .navigationTitle("\(user.email)")
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(user: User())
    }
}
