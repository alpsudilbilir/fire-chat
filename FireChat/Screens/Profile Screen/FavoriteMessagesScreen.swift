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

    var body: some View {
        ScrollView {
            LazyVStack {
                ForEach(0..<10, id: \.self) { number in
                    favoriteMessageCell
                }
            }
            
        }
        .listStyle(.plain)
        
      

    }
    private var favoriteMessageCell: some View {
        VStack {
            HStack {
                Image(systemName: "person.circle")
                    .font(.title)
                Text("pikachu")
                Spacer()
                Text("19.10.1997")
            }
            .padding(.horizontal)
            HStack {
                HStack {
                    Text("Bir Mesaj")
                        .foregroundColor(.white)
                }
                .padding()
                .background(Color.fire)
                .cornerRadius(10)
                .frame(alignment: .leading)
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

struct FavoriteMessagesScreen_Previews: PreviewProvider {
    static var previews: some View {
        FavoriteMessagesScreen()
    }
}
