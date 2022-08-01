//
//  ChatMessageView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 11.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI
struct MessageCell: View {
    @EnvironmentObject var vm : ProfileScreenViewModel
    @ObservedObject var mainVm = MainMessagesViewModel()
    @Environment(\.colorScheme) var colorScheme
    let user: User
    let message: ChatMessage
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
                            .frame(width: 300, height: 300)
                            .scaledToFit()
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
                    .contextMenu(menuItems: {
                        Button {
                            mainVm.saveToFavoriteMessages(message: message, user: user)
                        } label: {
                            HStack {
                                Text("Add to favorites")
                                Spacer()
                                Image(systemName: "heart")
                            }
                        }
                    })
                }
                .padding(.horizontal)
                .padding(.top, 8)
            } else {
                if  message.imageUrl != nil {
                    HStack {
                        WebImage(url: URL(string: message.imageUrl!))
                            .resizable()
                            .frame(width: 300, height: 300)
                            .scaledToFit()
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
                    .background(colorScheme == .dark ? .gray.opacity(0.3)  : .gray.opacity(0.1))
                    .cornerRadius(10)
                    .frame(alignment: .leading)
                    .contextMenu(menuItems: {
                        Button {
                            mainVm.saveToFavoriteMessages(message: message, user: user)
                        } label: {
                            HStack {
                                Text("Add to favorites")
                                Spacer()
                                Image(systemName: "heart")
                            }
                        }
                        
                    })

                    Spacer()
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
        }
    }
}
