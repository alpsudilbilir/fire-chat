//
//  ChatMessageView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 11.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct ChatMessageScreen: View {
    @EnvironmentObject var vm : ProfileScreenViewModel
    @Environment(\.colorScheme) var colorScheme

    let message: ChatMessage
    @State var showMessageDialog = false
    @State var selectedImage: Image?
    @State var selectedMessage: String?
    
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
                            .onLongPressGesture {
                                    showMessageDialog.toggle()
                            }
                    }
                }
                HStack {
                    Spacer()
                    HStack {
                        Text(message.message)
                            .foregroundColor(.white)
                            .onLongPressGesture {
                                showMessageDialog.toggle()
                                selectedMessage = message.message
                            }
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
                            .onLongPressGesture {
                                showMessageDialog.toggle()
                            }
                        Spacer()
                    }
                }
                HStack {
                    HStack {
                        Text(message.message)
                            .foregroundColor(colorScheme == .dark ? .white : .black)
                            .onLongPressGesture {
                                showMessageDialog.toggle()
                                selectedMessage = message.message

                            }
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
        .confirmationDialog("", isPresented: $showMessageDialog) {
            Button(role: .none) {
                vm.favoriteMessages.insert(selectedMessage!, at: 0)
            } label: {
                Text("Add to favorites")
            }

        }
    }
}
