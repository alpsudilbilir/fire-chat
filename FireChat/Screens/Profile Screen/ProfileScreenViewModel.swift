//
//  ProfileScreenViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import Foundation

final class ProfileScreenViewModel: ObservableObject {
    @Published var isDarkModeOff: Bool  = true
    @Published var favoriteMessages = [String]()
    @Published var selected = "online"
    @Published var showDeleteAccountAlert = false
    let statusSelections = ["online", "offline", "unavailable"]

    
    init() {
        self.isDarkModeOff = UserDefaultService.shared.getTheme()
        print(isDarkModeOff)
    }
}
