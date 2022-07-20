//
//  ChatMessageView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 11.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChatMessageScreen: View {
    let message: ChatMessage
    @Environment(\.colorScheme) var colorScheme
    
    var body: some View {
        VStack {
            if message.fromId == FireBaseManager.shared.auth.currentUser?.uid {
                if  message.imageUrl != nil {
                    HStack {
                        Spacer()
                        WebImage(url: URL(string: message.imageUrl!))
                            .resizable()
                            .frame(width: 250, height: 300)
                            .cornerRadius(25)
                            .padding(.horizontal)
                    }
                }
                HStack {
                    Spacer()
                    HStack {
                        Text(message.message)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.fire)
                    .cornerRadius(10)
                    .frame(alignment: .leading)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            } else {
                if  message.imageUrl != nil {
                    HStack {
                        WebImage(url: URL(string: message.imageUrl!))
                            .resizable()
                            .frame(width: 250, height: 300)
                            .cornerRadius(25)
                            .padding(.horizontal)
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Text(message.message)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                    }
                    .padding()
                    .background(colorScheme == .dark ? .ultraThinMaterial : .thin)
                    .cornerRadius(10)
                    .frame(alignment: .leading)
                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
    }
}
