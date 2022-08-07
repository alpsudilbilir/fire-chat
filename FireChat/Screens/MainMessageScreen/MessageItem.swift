//
//  MessageItem.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct MessageItem: View {
    @EnvironmentObject var mainVm : MainMessagesViewModel
    let didSelectUser: (User?) -> ()
    
    init(didSelectUser: @escaping (User?) -> () ) {
        self.didSelectUser = didSelectUser
    }

    
    var body: some View {
        ScrollView {
            if mainVm.recentMessages.isEmpty {
                VStack(spacing: 40) {
                    Spacer()
                    Text("Your message box is empty\nSend message to someone")
                        .bold()
                        .font(.title2)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.fire)
                        .cornerRadius(50)

                    Button {
                        mainVm.showNewMessageScreen.toggle()
                    } label: {
                        VStack {
                            Image(systemName: "plus.message.fill")
                                .resizable()
                                .frame(width: 150, height: 150)
                        }
                    }
                    Spacer()
                }
            } else {
                ForEach(mainVm.recentMessages, id:\.id) { recentMessage in
                        Button {
                            let user = User(uid: mainVm.currentUser?.uid == recentMessage.fromId ? recentMessage.toId : recentMessage.fromId, email: recentMessage.email, password: "", imageUrl: recentMessage.imageUrl)
                                didSelectUser(user)
                        } label: {
                                VStack {
                                    HStack {
                                        WebImage(url: URL(string: recentMessage.imageUrl) )
                                            .resizable()
                                            .scaledToFill()
                                            .frame(width: 64, height: 64)
                                            .cornerRadius(64)
                                            .clipped()
                                            .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                                        VStack(alignment: .leading, spacing: 3) {
                                            Text(recentMessage.username)
                                                .font(.title3)
                                                .fontWeight(.semibold)
                                            Text(recentMessage.message)
                                                .font(.caption)
                                                .multilineTextAlignment(.leading)
                                                .lineLimit(2)
                                            Spacer()
                                        }
                                        Spacer()
                                        Text(recentMessage.timeAgo)
                                            .font(.system(size: 12))
                                    }
                                    .padding()
                                    
                                    Divider()
                                        .frame(maxWidth: .infinity, maxHeight: 1.5)
                                        .overlay(.red)
                                        .padding(.horizontal)
                                }
                                .onAppear {
                                    mainVm.recentMessages.count
                                }
                        }
                        
                        .contextMenu(menuItems: {
                            Button {
                                    mainVm.deleteRecentMessages(selectedMessage: recentMessage)
                            } label: {
                                HStack {
                                    Text("Delete messages")
                                    Spacer()
                                    Image(systemName: "trash")
                                }
                            }

                        })
                    .foregroundColor(.primary)
                }

            }
             
        }
        .onAppear {
            mainVm.fetchRecentMessages()
        }
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(didSelectUser: { _ in
            
        })
    }
}
