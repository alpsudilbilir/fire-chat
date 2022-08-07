//
//  UserDefaultService.swift
//  FireChat
//
//  Created by Alpsu Dilbilir on 24.07.2022.
//

import Foundation
import SwiftUI

class UserDefaultService {
    
    static let shared = UserDefaultService()
    func getTheme() -> Bool {
        let isThemeDark = UserDefaults.standard.bool(forKey: "theme")
        return isThemeDark
    }
    func setTheme(isDarkTheme: Bool) {
        UserDefaults.standard.set(isDarkTheme, forKey: "theme")
    }
}
