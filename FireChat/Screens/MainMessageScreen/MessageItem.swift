//
//  MessageItem.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI


struct MessageItem: View {
    @ObservedObject var mainMessagesViewModel = MainMessagesViewModel()
    
    init() {
        mainMessagesViewModel.fetchRecentMessages()
    }
    
    var body: some View {
        ScrollView {
            ForEach(mainMessagesViewModel.recentMessages, id:\.id) { recentMessage in
                NavigationLink  {
                    //TODO: This navigation is buggy. Fix it
                    ChatScreen(user: User(uid: recentMessage.toId, email: recentMessage.email, password: "", imageUrl: recentMessage.imageUrl))
                } label: {
                    VStack {
                        HStack {
                            WebImage(url: URL(string: recentMessage.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png") )
                                .resizable()
                                .scaledToFill()
                                .frame(width: 64, height: 64)
                                .cornerRadius(64)
                                .clipped()
                                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                        
                            VStack(alignment: .leading, spacing: 5) {
                                Text(recentMessage.email)
                                    .fontWeight(.bold)
                                Text(recentMessage.message)
                                    .font(.caption)
                                    .multilineTextAlignment(.leading)
                                    .lineLimit(2)
                                Spacer()
                            }
                            Spacer()
                            Text("\(recentMessage.timestamp.dateValue().formatted(.dateTime.hour().minute()))")
                                .font(.system(size: 14))
                        }
                        .padding()
                        Divider()
                            .frame(maxWidth: .infinity, maxHeight: 1.5)
                            .overlay(.red)
                    }
                   
                }
                .foregroundColor(.primary)
            }
        }
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem()
    }
}
