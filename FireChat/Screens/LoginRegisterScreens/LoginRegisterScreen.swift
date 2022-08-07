//
//  ContentView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @EnvironmentObject var mainVm: MainMessagesViewModel
    let screens = ["Login", "Register"]
    @State private var selectedScreen = "Login"
    
    var body: some View {
        ScrollView {
            Picker("Select your screen", selection: $selectedScreen) {
                ForEach(screens, id:\.self) {
                    Text($0)
                }
            }
            .onAppear(perform: customizePicker)
            .padding()
            .pickerStyle(SegmentedPickerStyle())
            if selectedScreen == "Login" {
                LoginScreen()
            } else {
                RegisterScreen()
            }
            Spacer()
        }
        .environmentObject(mainVm)
        .alert("Registiration Failed", isPresented: $mainVm.showRegistirationAlert) {
            Button(role: .none, action: { mainVm.showRegistirationAlert = false }) {
                Text("Try again")
                    .foregroundColor(.fire)
            }
        } message: {
            Text("Please make sure fill all the fields and select a photo")
        }
        .alert("Login Failed", isPresented: $mainVm.showLoginAlert) {
            Button(role: .none, action: { mainVm.showLoginAlert = false }) {
                Text("Try again")
                    .foregroundColor(.fire)
            }
        } message: {
            Text("Invalid email or password")
        }
    }
    private func customizePicker() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.fire)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.fire)], for: .normal)
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        LoginRegisterScreen()
            .environmentObject(MainMessagesViewModel())
    }
}
