//
//  UserData.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation


struct UserData {
    
    static var profileImageString: String? {
           get {
               return UserDefaults.standard.string(forKey: "profile")
           }
           set {
               UserDefaults.standard.setValue(newValue, forKey: "profile")
           }
       }
    
    static var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickname")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "nickname")
        }
    }
    
    static func resetData() {
        
        UserDefaults.standard.removeObject(forKey: "profile")
        UserDefaults.standard.removeObject(forKey: "nickname")
    }
}
