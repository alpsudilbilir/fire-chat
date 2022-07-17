//
//  LoginScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

struct LoginScreen: View {
    @EnvironmentObject var viewModel:  MainMessagesViewModel
    @State var user = User()
    var fireBaseManager = FireBaseManager()
    var body: some View {
        ScrollView {
            HStack {
                Text("Welcome Back!")
                    .foregroundColor(.fire)
                    .fontWeight(.bold)
                    .font(.system(size: 28))
                Spacer()
            }
            .padding()
            CustomTextField(prompt: "Email", text: $user.email)                .keyboardType(.emailAddress)
            CustomSecureField(prompt: "Password", text: $user.password)

            Button {
                viewModel.loginUser(email: user.email, password: user.password)
            } label: {
                Text("Login")
                    .foregroundColor(.white)
                    .frame(maxWidth: .infinity, minHeight: 50, maxHeight: 60)
                    .background(Color.fire)
                    .clipShape(Capsule())
                    .padding()
            }
            Spacer()
        }
        .onDisappear(perform: {
            viewModel.isProgressContinues = false
        })
        .overlay(content: {
            if viewModel.isProgressContinues {
                ProgressView()
                    .tint(.fire)
                    .scaleEffect(x: 3, y: 3, anchor: .center)
                    .offset(y: -50)
            }
     
        })
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            .environmentObject(MainMessagesViewModel())
    }
}
