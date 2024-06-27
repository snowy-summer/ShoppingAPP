//
//  UserData.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation

final class UserData {
    
    private init() { }
    static let data = UserData()
    
    var signUpDate: String? {
        get {
            return UserDefaults.standard.string(forKey: "signUpDate")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "signUpDate")
        }
    }
    
    var profileImageString: String? {
        get {
            return UserDefaults.standard.string(forKey: "profile")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "profile")
        }
    }
    
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: "nickname")
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: "nickname")
        }
    }
    
    var searchRecordList: [SearchRecord]? {
        get {
            
            guard let recordData = UserDefaults.standard.data(forKey: "searchRecord") else { return nil}
            let data = try? JSONDecoder().decode([SearchRecord].self,
                                                 from: recordData )
            return data
        }
        set {
            
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(data, forKey: "searchRecord")
        }
    }
    
    var like: [String]? {
        get {
            
            guard let recordData = UserDefaults.standard.stringArray(forKey: "like") else { return nil}
            
            return recordData
        }
        set {
            
            UserDefaults.standard.setValue(newValue, forKey: "like")
            
        }
    }
    
    func deleteSearchRecordList() {
        UserDefaults.standard.removeObject(forKey: "searchRecord")
    }
    
    func resetData() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
    }
}
