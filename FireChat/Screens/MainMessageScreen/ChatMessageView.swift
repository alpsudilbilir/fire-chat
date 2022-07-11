//
//  ChatMessageView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 11.07.2022.
//

import SwiftUI

struct ChatMessageView: View {
    let message: ChatMessage
    @Environment(\.colorScheme) var colorScheme

    var body: some View {
        VStack {
            if message.fromId == FireBaseManager.shared.auth.currentUser?.uid {
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
                HStack {
                    HStack {
                        Text(message.message)
                            .foregroundColor(colorScheme == .dark ? .white :
                                    .black)
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
