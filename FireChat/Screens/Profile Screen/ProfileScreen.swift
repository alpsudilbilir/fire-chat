//
//  ProfileScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 17.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
    @EnvironmentObject var vm: ProfileScreenViewModel
    var body: some View {
        VStack {
            if let imageURL = viewModel.currentUser?.imageUrl {
                NavigationLink {
                    PhotoScreen(imageURL: imageURL, isEditButtonAvailable: true)
                        .environmentObject(viewModel)
                } label: {
                    WebImage(url: URL(string: imageURL))
                        .resizable()
                        .scaledToFill()
                        .frame(width: 150, height: 150)
                        .cornerRadius(75)
                        .clipped()
                        .overlay(Circle().stroke(lineWidth: 2).foregroundColor(.fire))
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .frame(width: 200, height: 200)
                    .cornerRadius(75)
                    .foregroundColor(.fire)
            }
            Text(viewModel.currentUser?.username ?? "Unkown")
                .font(.system(size: 36))
            Spacer()
            HStack {
                Text("Settings")
                    .bold()
                    .font(.title2)
                    .foregroundColor(.fire)
                Spacer()
            }
            .padding(.horizontal)
            
            SettingsListView()
                .environmentObject(vm)
                .environmentObject(viewModel)
            
        }
        .alert("Do you want to delete your account?", isPresented: $vm.showDeleteAccountAlert, actions: {
            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
            Button(role: .destructive) {
                viewModel.deleteAccount()
            } label: {
                Text("Delete")
            }
        })
        .navigationTitle("Profile")
        .onAppear {
            UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor(Color.fire)]
        }
    }
}
struct ProfileScreen_Previews: PreviewProvider {
    static var previews: some View {
        ProfileScreen()
            .environmentObject(MainMessagesViewModel())
    }
}


