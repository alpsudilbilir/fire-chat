//
//  ProfileScreenViewModel.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import Foundation

final class ProfileScreenViewModel: ObservableObject {
    let statusSelections = ["online", "offline", "busy"]

    @Published var isDarkModeOn: Bool  = false
    @Published var favoriteMessages = [String]()
    @Published var selectedStatus = "online"
    @Published var showDeleteAccountAlert = false

    
    init() {
        self.isDarkModeOn = UserDefaultService.shared.getTheme()
    }
    
    func saveUserStatusToFireStore() {
        guard let uid = FireBaseManager.shared.auth.currentUser?.uid else { return }
        FireBaseManager.shared.firestore
            .collection("users")
            .document(uid)
            .setData(["status": self.selectedStatus], merge: true)
    }
}
