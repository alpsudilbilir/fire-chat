//
//  ContentView.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 23.06.2022.
//

import SwiftUI
import Firebase
struct StartScreen: View {
    let screens = ["Login", "Register"]
    @State private var selectedScreen = "Login"
    
    
    init() {
        UISegmentedControl.appearance().selectedSegmentTintColor = UIColor(.fire)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.white)], for: .selected)
        UISegmentedControl.appearance().setTitleTextAttributes([.foregroundColor: UIColor(.fire)], for: .normal)
    }
    
    var body: some View {
        NavigationView {
            ScrollView {
                Picker("Select your screen", selection: $selectedScreen) {
                    ForEach(screens, id:\.self) {
                        Text($0)
                    }
                }
                .padding()
                .pickerStyle(SegmentedPickerStyle())
                if selectedScreen == "Login" {
                    LoginScreen()
                } else {
                    RegisterScreen()
                }
                Spacer()
                
            }
            .navigationBarHidden(true)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        StartScreen()
    }
}
