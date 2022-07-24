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
    
//    func setLogin(loginModel: LoginModel){
//
//        if let encoded = try? JSONEncoder().encode(loginModel){
//            let defaults = UserDefaults.standard
//            defaults.set(encoded, forKey: "loginModel")
//        }
//
//    }
//
//    func getLogin()-> LoginModel{
//
//        let defaults = UserDefaults.standard
//        if let userModel = defaults.object(forKey: "loginModel") as? Data {
//            let decoder = JSONDecoder()
//            if let user = try? decoder.decode(LoginModel.self, from: userModel) {
//                return user
//            }
//        }
//
//        return LoginModel(email: "")
//
//    }
    func getTheme() -> Bool {
        let isThemeDark = UserDefaults.standard.bool(forKey: "theme")
        return isThemeDark
        
    }
    func setTheme(isDarkTheme: Bool) {
        UserDefaults.standard.set(isDarkTheme, forKey: "theme")
    }
}
