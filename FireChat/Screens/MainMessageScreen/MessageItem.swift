//
//  MessageItem.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI

struct MessageItem: View {
    var body: some View {
        ScrollView {
            ForEach(0..<10, id:\.self) { number in
                HStack {
                    Image(systemName: "person.fill")
                        .resizable()
                        .foregroundColor(.fire)
                        .padding(8)
                        .frame(width: 44, height: 44)
                        .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                    VStack(alignment: .leading) {
                        Text("Username")
                            .fontWeight(.bold)
                        Text("Message sent to user")
                            .font(.caption)
                    }
                    Spacer()
                    Text("22d")
                        .font(.system(size: 14))
                        .bold()
                }
                .padding()
                Divider()
            }
        }
    }
}

struct MessageItem_Previews: PreviewProvider {
    static var previews: some View {
        MessageItem()
    }
}
