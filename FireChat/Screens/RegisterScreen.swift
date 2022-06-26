//
//  RegisterScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

struct RegisterScreen: View {
    var fireBaseManager = FireBaseManager()
    @State var user = User()
    @State var showImagePicker = false
    @State var image: UIImage?
    var body: some View {
        ScrollView {
            HStack {
                Text("Register")
                    .font(.system(size: 28))
                    .fontWeight(.bold)
                    .foregroundColor(.fire)
                Spacer()
            }
            .padding()
            
            Button {
                showImagePicker.toggle()
            } label: {
                VStack {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75)
                            .overlay(Circle().stroke(Color.fire, lineWidth: 2))
                            

                    } else {
                        Image(systemName: "person.circle")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 150, height: 150)
                            .cornerRadius(75)
                            .foregroundColor(.fire.opacity(0.7))
                    }
                }
            }
            CustomTextField(prompt: "Email", text: $user.email)
                .keyboardType(.emailAddress)
            CustomSecureField(prompt: "Password", text: $user.password)
            
            Button {
                fireBaseManager.createNewAccount(email: user.email, password: user.password, image: image ?? UIImage())
            } label: {
                Text("Register")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 60)
                    .background(Color.fire)
                    .clipShape(Capsule())
                    .padding()
            }
        }
        .navigationBarHidden(true)
        .sheet(isPresented: $showImagePicker) {
            ImagePicker(image: $image)
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
