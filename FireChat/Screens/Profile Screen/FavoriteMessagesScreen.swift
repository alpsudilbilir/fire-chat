//
//  FavoriteMessagesScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 28.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct FavoriteMessagesScreen: View {
    @Environment(\.colorScheme) var colorScheme
    @ObservedObject var viewModel =  MainMessagesViewModel()
    
    init() {
        viewModel.fetchFavoriteMessages()
    }
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.favoriteChatMessages, id: \.id) { message in
                    VStack {
                        HStack(alignment: .top, spacing: 7) {
                            WebImage(url: URL(string: message.imageUrl!))
                                .resizable()
                                .frame(width: 55, height: 55)
                                .scaledToFill()
                                .cornerRadius(55)
                                .clipped()
                            VStack(alignment: .leading, spacing: 3) {
                                Text(message.from)
                                    .bold()
                                HStack {
                                    Text(message.message)
                                        .foregroundColor(.white)
                                        .padding(7)
                                        .background(Color.fire)
                                        .cornerRadius(10)
                                        .frame(alignment: .leading)
                                    Spacer()
                                }
                            }
                      
                            Spacer()
                            Text(message.timeAgo)
                                .font(.caption)
                        }
                      
                        Divider()
                    }.padding(.horizontal)
                }
            }
        }
        .listStyle(.plain)
        .navigationBarTitle("Favorite Messages")
        .navigationBarTitleDisplayMode(.inline)
    }
    
}

struct FavoriteMessagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMessagesScreen()
            .environmentObject(MainMessagesViewModel())
    }
}
