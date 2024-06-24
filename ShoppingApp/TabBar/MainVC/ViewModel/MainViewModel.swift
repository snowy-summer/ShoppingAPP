//
//  MainViewModel.swift
//  ShoppingApp
//
//  Created by 최승범 on 6/14/24.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    @Published private(set) var list = UserData.data.searchRecordList
    
    func updateRecordList(text: String) {
        
        let text = text.lowercased()
        
        if let recordList = UserData.data.searchRecordList {
           
            for record in recordList {
                if record.name == text { return }
            }
        }
        
        var oldList: [SearchRecord]
        
        oldList = list ?? []
        
        let value = SearchRecord(name: text,
                               date: Date())
        oldList.append(value)
        oldList.sort { A, B in
            A.date > B.date
        }
        
        list = oldList
        UserData.data.searchRecordList = oldList
    }
    
    func deleteRecordList(at index: Int) {
        
        guard var oldList = list else { return }
        
        oldList.remove(at: index)
        list = oldList
        UserData.data.searchRecordList = oldList
    }
    
    func deleteListAll() {
        
        list = []
        UserData.data.deleteSearchRecordList()
    }
}
