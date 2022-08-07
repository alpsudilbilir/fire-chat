//
//  ProfileScreen.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 17.07.2022.
//

import SwiftUI
import SDWebImageSwiftUI

struct ProfileScreen: View {
    @EnvironmentObject var mainVm: MainMessagesViewModel
    @EnvironmentObject var profileVm: ProfileScreenViewModel
    var body: some View {
        VStack {
            if let imageURL = mainVm.currentUser?.imageUrl {
                NavigationLink {
                    PhotoScreen(imageURL: imageURL, isEditButtonAvailable: true)
                        .environmentObject(mainVm)
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
            Text(mainVm.currentUser?.username ?? "Unkown")
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
                .environmentObject(profileVm)
                .environmentObject(mainVm)
            
        }
        .alert("Do you want to delete your account?", isPresented: $profileVm.showDeleteAccountAlert, actions: {
            Button(role: .cancel, action: {}) {
                Text("Cancel")
            }
            Button(role: .destructive) {
                mainVm.deleteAccount()
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


