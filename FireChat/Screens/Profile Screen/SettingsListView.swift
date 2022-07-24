//
//  SettingsListView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import SwiftUI

struct SettingsListView: View {
    @EnvironmentObject var vm : ProfileScreenViewModel
    var body: some View {
        List {
            darkModeToggle
            HStack {
                Text("Status")
                Spacer()
                Picker("", selection: $vm.selected) {
                    ForEach(vm.statusSelections, id: \.self) {
                        Text($0)
                            .foregroundColor(.black)
                    }
                }.pickerStyle(.menu)
            }
            favoriteMessages
            deleteAccountButton
        }
        .hasScrollEnabled(false)
        .listStyle(.plain)
    }
    private var favoriteMessages: some View {
        NavigationLink {
            List(vm.favoriteMessages ?? ["No Message Found"], id: \.self) { message in
                Text(message)
            }
        } label: {
            Text("Favorite Messages")
        }
    }
    private var deleteAccountButton: some View {
        Button(role: .destructive) {
            vm.showDeleteAccountAlert = true
        } label: {
            Text("Delete Account")
        }
    }
    private var darkModeToggle: some View {
        HStack {
            Text("Dark Mode")
            Spacer()
            
            Toggle("", isOn: $vm.isDarkModeOn)
                .tint(.fire)
                .onTapGesture {
                    if vm.isDarkModeOn == false {
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
    }
}
