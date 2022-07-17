//
//  MessageItem.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct MessageItem: View {
    @ObservedObject var viewModel = MainMessagesViewModel()
    let didSelectUser: (User?) -> ()
    
    init(didSelectUser: @escaping (User?) -> () ) {
        self.didSelectUser = didSelectUser
        viewModel.fetchRecentMessages()
    }

    
    var body: some View {
        ScrollView {
            ForEach(viewModel.recentMessages, id:\.id) { recentMessage in
                Button {
                    let user = User(uid: viewModel.currentUser?.uid == recentMessage.fromId ? recentMessage.toId : recentMessage.fromId, email: recentMessage.email, password: "", imageUrl: recentMessage.imageUrl)
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
                            VStack(alignment: .leading, spacing: 5) {
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
                }
                .foregroundColor(.primary)
            }


        }
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem(didSelectUser: { _ in
            
        })
    }
}
