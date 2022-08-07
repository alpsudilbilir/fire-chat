//
//  ChatScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 2.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ChatScreen: View {
    @Environment(\.presentationMode) var presentationMode: Binding<PresentationMode>
    @EnvironmentObject var profileVm: ProfileScreenViewModel
    @FocusState private var keyboardState: Bool
    @State var image: UIImage?
    @State var showImagePickerSheet = false
    @State var isUserSendingImage = false
    @State var showMessageDialog = false
    @State var refresh: Bool = false
    let user: User?
    
    init(user: User) {
        self.user = user
        self.chatVm = .init(user: user)
        chatVm.fetchMessages()
        chatVm.fetchUserStatus(uid: user.uid)
    }
    
    @ObservedObject var chatVm : ChatScreenViewModel
    
    
    var body: some View {
        VStack {
            navbarView
            if isUserSendingImage {
                if let image = image {
                    VStack {
                        Spacer()
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                        Spacer()
                    }
                }
            } else {
                messageView
                    
            }
            bottomBar
        }
        .onChange(of: chatVm.messageText, perform: { newValue in
            if !chatVm.messageText.isEmpty {
                chatVm.isSendButtonDisabled = false
            } else {
                chatVm.isSendButtonDisabled = true
            }
        })
        .sheet(isPresented: $showImagePickerSheet, content: {
            ImagePicker(image: $image)
                .onDisappear {
                    if let image = image {
                        chatVm.saveChatImageToStorage(image: image)
                    }
                }
        })
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarHidden(true)
        .onDisappear {
            chatVm.snapshotListener?.remove()
        }
    }
    private var navbarView: some View {
        HStack {
            Button {
                self.presentationMode.wrappedValue.dismiss()
            } label: {
                Image(systemName: "chevron.left")
                    .foregroundColor(.fire)
            }
            Spacer().frame(width: 75)
            NavigationLink {
                PhotoScreen(imageURL: user?.imageUrl ?? "", isEditButtonAvailable: false)
            } label: {
                WebImage(url: URL(string: user?.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 34, height: 34)
                    .cornerRadius(34)
                    .clipped()
                    .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
            }
            
            VStack(alignment: .leading, spacing: 3) {
                Text(user?.username ?? "")
                    .bold()
                HStack(spacing: 3) {
                    Circle()
                        .foregroundColor(Color.statusColor(status: chatVm.userStatus ))
                        .frame(width: 8, height: 8)
                    Text(chatVm.userStatus ?? "")
                        .font(.caption)
                }
            }
            Spacer()
        }
        .padding(.horizontal)
        
    }
    private var messageView: some View {
        ScrollView {
            ScrollViewReader { reader in
                VStack {
                    ForEach(chatVm.messages) { message in
                        if let user = user {
                            MessageCell(user: user ,message: message)
                                .onChange(of: chatVm.messages.count) { newValue in
                                    withAnimation(.easeOut(duration: 0.5)) {
                                        reader.scrollTo("bottom", anchor: .bottom)
                                    }
                                }
                        }
                    }.onAppear {
                        reader.scrollTo("bottom", anchor: .bottom)
                    }
                    
                    HStack {
                        Spacer()
                    }.id("bottom")
                }
            }
        }
        .onTapGesture {
            keyboardState = false
            chatVm.placeholder = "Message"
        }
    }
    private var bottomBar: some View {
        
        HStack {
            HStack(spacing: 3) {
                Button {
                    showImagePickerSheet = true
                    isUserSendingImage = true
                } label: {
                    Image(systemName: "photo.on.rectangle.angled")
                        .font(.system(size: 32))
                        .foregroundColor(.gray)
                }
                TextEditor(text: $chatVm.messageText)
                    .frame(maxWidth: .infinity, minHeight: 32, idealHeight: 32, maxHeight: 32, alignment: .center)
                    .focused($keyboardState)
                    .overlay {
                        HStack {
                            Text(chatVm.placeholder)
                                .foregroundColor(.gray)
                            Spacer()
                        }
                    }
                    .onTapGesture {
                        chatVm.placeholder = ""
                    }
            }.padding(.horizontal)
            
            Button {
                isUserSendingImage = false
                chatVm.handleSend(imageUrl: chatVm.imageUrl)
            } label: {
                Image(systemName: "arrow.right.circle.fill")
                    .font(.system(size: 32))
                    .foregroundColor(chatVm.checkSendButton()  ? .gray : .fire)
            }.disabled(chatVm.checkSendButton())
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
