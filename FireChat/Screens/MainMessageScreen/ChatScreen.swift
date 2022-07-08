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
    @FocusState private var keyboardState: Bool
    
    init(user: User) {
        self.user = user
        self.vm = .init(user: user)
    }
    
    @ObservedObject var vm : ChatScreenViewModel


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
                ForEach(vm.messages, id: \.self) { message in
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
                value.scrollTo(vm.messages.last, anchor: .center)
            }
            }
        }
        .onTapGesture {
            keyboardState = false
            vm.placeholder = "Message"
        }
    }
    private var bottomBar: some View {

        HStack {
            HStack(spacing: 3) {
                Image(systemName: "photo.on.rectangle.angled")
                    .font(.system(size: 36))
                    .foregroundColor(.gray)
                  
                TextEditor(text: $vm.messageText)
                    .frame(maxWidth: .infinity, minHeight: 32, idealHeight: 32, maxHeight: 32, alignment: .center)
                    .focused($keyboardState)
                    .overlay {
                        HStack {
                            Text(vm.placeholder)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        vm.placeholder = ""
                    }
            }.padding(.horizontal)
            
            Button {
                vm.handleSend(text: vm.messageText)
                
            } label: {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 36))
                    .foregroundColor(vm.isSendButtonDisabled ? .gray : .fire)
            }.disabled(vm.isSendButtonDisabled)
            Spacer()
        }
    }
}
struct ChatScreen_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ChatScreen(user: User(uid: "aDS", email: "alpsudilbilir@gmail.com", password: "123", imageUrl: nil))
        }
        
    }
}
