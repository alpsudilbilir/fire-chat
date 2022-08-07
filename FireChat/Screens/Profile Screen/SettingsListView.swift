//
//  SettingsListView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import SwiftUI

struct SettingsListView: View {
    @EnvironmentObject var mainVm: MainMessagesViewModel
    @EnvironmentObject var profileVm : ProfileScreenViewModel
    
    var body: some View {
        List {
            darkModeToggle
            statusPicker
            favoriteMessages
            deleteAccountButton
        }
        .onAppear(perform: {
            profileVm.selectedStatus = mainVm.currentUser?.status ?? ""
        })
        .hasScrollEnabled(false)
        .listStyle(.plain)
    }
    private var statusPicker: some View {
        HStack {
            Text("Status")
            Spacer()
            Picker("", selection: $profileVm.selectedStatus) {
                ForEach(profileVm.statusSelections, id: \.self) {
                    Text($0)
                        .foregroundColor(.black)
                }
            }.pickerStyle(.menu)
                .onChange(of: profileVm.selectedStatus) { newValue in
                    profileVm.saveUserStatusToFireStore()
                    print(profileVm.selectedStatus + "setted.")
                    mainVm.fetchCurrentUser()
                    mainVm.fetchRecentMessages()
                }
        }
    }
    private var favoriteMessages: some View {
        NavigationLink {
                FavoriteMessagesScreen()
                    .environmentObject(mainVm)
        } label: {
            Text("Favorite Messages")
        }
    }
    private var deleteAccountButton: some View {
        Button(role: .destructive) {
            profileVm.showDeleteAccountAlert = true
        } label: {
            Text("Delete Account")
        }
    }
    private var darkModeToggle: some View {
        HStack {
            Text("Dark Mode")
            Spacer()
            
            Toggle("", isOn: $profileVm.isDarkModeOn)
                .tint(.fire)
                .onTapGesture {
                    if profileVm.isDarkModeOn == false {
                        UserDefaultService.shared.setTheme(isDarkTheme: true)
                    } else {
                        UserDefaultService.shared.setTheme(isDarkTheme: false)
                    }
                }
        }
    }
}

struct SettingsListView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsListView()
            .environmentObject(ProfileScreenViewModel())
            .environmentObject(MainMessagesViewModel())
    }
}
