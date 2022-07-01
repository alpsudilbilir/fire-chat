//
//  ChatScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 2.07.2022.
//

import SwiftUI

struct ChatScreen: View {
    let user: User
    
    var body: some View {
        ScrollView {
            ForEach(0..<100) { message in
                Text("Fake messages here")
            }
        }
        .navigationTitle("\(user.email)")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        ChatScreen(user: User())
    }
}
