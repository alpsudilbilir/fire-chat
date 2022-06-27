//
//  LoginScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

struct LoginScreen: View {
    @State var user = User()
    var fireBaseManager = FireBaseManager()
    @State private var showsheet = false
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

            CustomTextField(prompt: "Email", text: $user.email)
                .keyboardType(.emailAddress)
            CustomSecureField(prompt: "Password", text: $user.password)
            
            Button {
                fireBaseManager.loginUser(email: user.email, password: user.password)
                showsheet.toggle()
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
        .sheet(isPresented: $showsheet) {
            MainMessages()
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
            
    }
}
