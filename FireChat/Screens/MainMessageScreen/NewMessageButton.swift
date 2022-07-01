//
//  NewMessageButton.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct NewMessageButton: View {
    @State var showNewMessageScreen = false
    var body: some View {
        Button(action: {
                showNewMessageScreen.toggle()
            
        }, label: {
            Text("+ New Message")
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, maxHeight: 44)
                .background(Color.fire)
                .foregroundColor(.white)
                .cornerRadius(25)
                .shadow(radius: 15)
                .padding(.horizontal)
        })
        .fullScreenCover(isPresented: $showNewMessageScreen) {
            NewMessageScreen()
        }
    }
}

struct NewMessageButton_Previews: PreviewProvider {
    static var previews: some View {
        NewMessageButton()
    }
}
