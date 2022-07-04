//
//  ContentView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI

struct LoginRegisterScreen: View {
    @EnvironmentObject var viewModel: MainMessagesViewModel
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
        .environmentObject(viewModel)
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
