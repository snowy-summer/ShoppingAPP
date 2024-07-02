//
//  UserData.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation

final class UserData {
    
    private enum Key: String {
        case signUpDate
        case profile
        case nickname
        case searchRecord
        case like
    }
    
    private init() { }
    static let data = UserData()
    
    var signUpDate: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.signUpDate.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.signUpDate.rawValue)
        }
    }
    
    var profileImageString: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.profile.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.profile.rawValue)
        }
    }
    
    var nickname: String? {
        get {
            return UserDefaults.standard.string(forKey: Key.nickname.rawValue)
        }
        set {
            UserDefaults.standard.setValue(newValue, forKey: Key.nickname.rawValue)
        }
    }
    
    var searchRecordList: [SearchRecord]? {
        get {
            
            guard let recordData = UserDefaults.standard.data(forKey: Key.searchRecord.rawValue) else { return nil}
            let data = try? JSONDecoder().decode([SearchRecord].self,
                                                 from: recordData )
            return data
        }
        set {
            
            let data = try? JSONEncoder().encode(newValue)
            UserDefaults.standard.setValue(data, forKey: Key.searchRecord.rawValue)
        }
    }
    
    var like: [String]? {
        get {
            
            guard let recordData = UserDefaults.standard.stringArray(forKey: Key.like.rawValue) else { return nil}
            
            return recordData
        }
        set {
            
            UserDefaults.standard.setValue(newValue, forKey: Key.like.rawValue)
            
        }
    }
    
    func deleteSearchRecordList() {
        UserDefaults.standard.removeObject(forKey: Key.searchRecord.rawValue)
    }
    
    func resetData() {
        for key in UserDefaults.standard.dictionaryRepresentation().keys {
            UserDefaults.standard.removeObject(forKey: key.description)
        }
        
    }
}
