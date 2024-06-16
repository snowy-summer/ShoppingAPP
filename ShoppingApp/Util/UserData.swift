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
    
    var searchRecordList: [RecordList]? {
        get {
            
            guard let recordData = UserDefaults.standard.data(forKey: "searchRecord") else { return nil}
            let data = try? JSONDecoder().decode([RecordList].self,
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
        
        UserDefaults.standard.removeObject(forKey: "profile")
        UserDefaults.standard.removeObject(forKey: "nickname")
        UserDefaults.standard.removeObject(forKey: "searchRecord")
        UserDefaults.standard.removeObject(forKey: "like")
    }
    
    
}
