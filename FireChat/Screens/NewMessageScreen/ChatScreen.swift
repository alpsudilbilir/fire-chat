//
//  ChatScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 2.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatScreen: View {
    let user: User
    @State var message: String = ""
    @State var messages = [String]()
    @State var placeholder = "Message"
    @State var isSendButtonDisabled = false
    
    var body: some View {
        
        VStack {
            messageView
            bottomBar
                .padding(.vertical)
        }
        .navigationTitle("\(user.email)")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                WebImage(url: URL(string: user.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 34, height: 34)
                    .cornerRadius(34)
                    .clipped()
                    .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
            }
        }
    }
    private var messageView: some View {
        ScrollView {
            ScrollViewReader { value in
            ForEach(messages, id: \.self) { message in
                HStack {
                    Spacer()
                    HStack {
                        Text(message)
                            .foregroundColor(.white)
                    }
                    .padding()
                    .background(Color.fire)
                    .cornerRadius(10)
                }
                .padding(.horizontal)
                .padding(.top, 8)
            }
            .onAppear {
                value.scrollTo(messages.last, anchor: .center)
            }
            }
        }
    }
    private var bottomBar: some View {
        HStack(spacing: 10) {
            Image(systemName: "photo.on.rectangle.angled")
                .font(.system(size: 32))
                .foregroundColor(.gray)
            TextEditor(text: $message)
                .frame(width: .infinity, height: 32, alignment: .center)
                .overlay {
                    HStack {
                        Text(placeholder)
                            .foregroundColor(.gray)
                        Spacer()
                    }
                }
                .onTapGesture {
                    placeholder = ""
                   
                    
                }
            Button {
                if !message.isEmpty {
                    messages.append(message)
                    message = ""
                }
                
            } label: {
                Image(systemName: "paperplane.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(isSendButtonDisabled ? .gray : .fire)
            }.disabled(isSendButtonDisabled)
            Spacer()
        }.padding(.horizontal)
    }
}
struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatScreen(user: User(uid: "aDS", email: "alpsudilbilir@gmail.com", password: "123", imageUrl: nil))
        }
        
    }
}
