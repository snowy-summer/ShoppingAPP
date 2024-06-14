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
    
    static func saveName(value: String) {
        UserDefaults.standard.setValue(value, forKey: "profile")
    }
    
    
    static func resetData() {
        UserDefaults.standard.setValue("대장", forKey: "UserName")
        UserDefaults.standard.removeObject(forKey: "다마고치")
    }
}
