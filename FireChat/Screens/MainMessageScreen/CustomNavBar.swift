//
//  CustomNavBar.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 27.06.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct CustomNavBar: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
    @State var showNewMessageScreen = false
    @State var showConfirmationDialog = false
    var body: some View {
        HStack(spacing: 15) {
            WebImage(url: URL(string: viewModel.user?.imageUrl ?? "https://eitrawmaterials.eu/wp-content/uploads/2016/09/person-icon.png"))
                .resizable()
                .scaledToFill()
                .frame(width: 40, height: 40)
                .cornerRadius(40)
                .clipped()
                .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
            VStack(alignment: .leading, spacing: 0) {
                Text(viewModel.user?.email.replacingOccurrences(of: "@gmail.com", with: "") ?? "Unkown")
                    .font(.system(size: 24, weight: .semibold))
                HStack {
                    Circle()
                        .foregroundColor(.green)
                        .frame(width: 8, height: 8)
                    Text("online")
                        .foregroundColor(Color.gray)
                        .font(.caption)
                }
            }
            Spacer()
            Button {
                showNewMessageScreen.toggle()
            } label: {
                Image(systemName: "plus.bubble")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.fire)
            }
            Spacer()
                .frame(width: 1)
            Button {
                showConfirmationDialog.toggle()
            } label: {
                Image(systemName: "gear")
                    .resizable()
                    .frame(width: 24, height: 24)
                    .foregroundColor(.fire)
            }
        }
        .padding(.horizontal)
        .fullScreenCover(isPresented: $showNewMessageScreen) {
            NewMessageScreen(didSelectNewUser: { user  in
                print(user.email)
                viewModel.userThatWillBeMessaged = user
                viewModel.isNavigationLinkActive.toggle()
                 })
        }
        .confirmationDialog(Text("Do you want to sign out?"), isPresented: $showConfirmationDialog, actions: {
            Button("Cancel", role: .cancel) { }
            Button("Sign out", role: .destructive) {
                viewModel.signOut()
            }
        })
    }
}

struct CustomNavBar_Previews: PreviewProvider {
    static var previews: some View {
        CustomNavBar()
            .environmentObject(MainMessagesViewModel())
    }
}
